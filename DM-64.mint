// System initialization
: INIT
  #3F00 /s !     // Set stack pointer
  #00 SCAN /O    // Clear scan register
  #FF DISP /O    // Blank display
  #00 DPOS /O    // Reset digit select
  0 /c!          // Clear carry
  0 /r!          // Clear remainder
;

// Port definitions with initialization
: SCAN 2 ;    // Keyboard scan (output)
: KEY 3 ;     // Keyboard read (input)
: DISP 1 ;    // Display segments (output)
: DPOS 2 ;    // Display position (output)
: TAPE 4 ;    // Paper tape reader (input)
: STATUS 5 ;  // Tape status (input)

// System timing constants
: SCAN_DELAY 100 ;   // Keyboard scan delay
: DISP_DELAY 50 ;    // Display refresh delay
: TAPE_TIMEOUT 200 ; // Tape read timeout

// Memory buffers with initialization
: BUF \[ 0 0 0 0 0 0 ] buf ! ;        // Display buffer
: TBUF \[ 0 0 0 0 0 0 0 0 ] tape ! ;  // Tape buffer
: KBUF \[ 0 0 0 0 0 0 ] key ! ;       // Keyboard buffer

// Display segment patterns (unchanged but verified)
: PAT0 #3F ; : PAT1 #06 ; : PAT2 #5B ; : PAT3 #4F ;
: PAT4 #66 ; : PAT5 #6D ; : PAT6 #7D ; : PAT7 #07 ;
: PAT8 #7F ; : PAT9 #6F ;
: PATA #77 ; : PATB #7C ; : PATC #39 ; : PATD #5E ; 
: PATE #79 ; : PATF #71 ; : PATG #3D ; : PATH #76 ;
: PATI #06 ; : PATL #38 ; : PATN #37 ; : PATO #3F ;
: PATP #73 ; : PATR #50 ; : PATS #6D ; : PATT #78 ;
: PATU #3E ; : PATY #6E ;

// Safe display refresh with timing
: REFRESH
  #FF DISP /O           // Blank first
  DISP_DELAY (          // Small delay
    1 1 + '
  )
  6 (                   // For each digit
    #FF DISP /O         // Blank
    /i buf \?           // Get pattern
    DISP /O             // Output segments
    /i DPOS /O          // Select digit
    DISP_DELAY (        // Hold time
      1 1 + '
    )
  )
;

// Debounced keypad read
: READ_KEY
  0 bounce !
  SCAN_DELAY (          // Debounce delay
    KEY /I " = (        // If key stable
      bounce 1+ bounce !
    )
  )
  bounce SCAN_DELAY 2 / > ( // If stable long enough
    KEY /I              // Return key value
  ) /E (
    #FF                 // No valid key
  )
;

// Paper tape read with timeout
: READ_TAPE
  0 timeout !
  /U (
    TAPE_TIMEOUT timeout 1+ timeout !
    timeout TAPE_TIMEOUT = /W  // Break on timeout
    STATUS /I 1 & /T (        // If tape ready
      TAPE /I                 // Read byte
      /B                      // Break with byte
    )
  )
  #FF                         // Timeout return
;

// Error handler
: ERROR    // error_code --
  `Err` SHOW
  " . /N                     // Show error number
  SCAN_DELAY 10 * (          // Long delay
    1 1 + '
  )
;

// Safe memory write with bounds check
: WRITE    // value addr --
  " #3FFF > (               // If address too high
    ' ' #1                  // Drop values, error 1
    ERROR
  ) /E (
    !                      // Safe to write
  )
;

// Questions with checksums
: Q1 [ PATA PATB PATO PATU PATT #00 ] q1 ! ; 
: Q2 [ PATF PATO PATO PATD #00 #00 ] q2 ! ; 
: Q3 [ PATH PATO PATB PATY #00 #00 ] q3 ! ; 
: Q4 [ PATL PATO PATU PATE #00 #00 ] q4 ! ; 
: Q5 [ PATC PATA PATR PATS #00 #00 ] q5 ! ; 

// Main program
: D
  INIT                      // System initialization
  0 score !
  
  // Input selection
  STATUS /I 1 & (          // If tape present
    READ_TAPE              // Use tape
  ) /E (
    READ_KEY               // Use keypad
  )
  
  // Questions (with error checking)
  q1 ASK ERROR /F (        // Continue if no error
    q2 ASK ERROR /F (
      q3 ASK ERROR /F (
        q4 ASK ERROR /F (
          q5 ASK
        )
      )
    )
  )
  
  // Results (unchanged)
  score 5 = (
    `MATCH` SHOW
  ) /E (
    score 3 > (
      `GOOD` SHOW
    ) /E (
      `NOPE` SHOW
    )
  )
  
  score PAT0 + 5 WRITE
  REFRESH
;

// Main loop with error recovery
: M
  /U (
    #FF DISP /O           // Ensure display blank
    BUF                   // Initialize buffers
    TBUF
    KBUF
    /U (
      D                   // Run program
      `MORE` SHOW
      READ_KEY #0 = /W    // Break on 0
    )
    `DONE` SHOW
    SCAN_DELAY 100 * (    // End delay
      1 1 + '
    )
  )
;

// Entry point
INIT M
