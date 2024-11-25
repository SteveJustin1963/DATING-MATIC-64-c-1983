
- Port setup (tape interface)
- Any interrupt setup (Z function)
- Full I/O port range definition

- HEX to segment pattern conversion
- SHOW function for numerical values
- Clear display function

- Full keyboard matrix scanning
- Tape input handling
- Input validation functions


```mint
// Port definitions
:H
[ #01 #02 #03 #04 #05 #06 ] h!
;

// System initialization 
// Sets up all I/O and buffers
:I
#3F00 s!
// Clear all outputs
6(
  0 /i h ? /O
)
// Clear flags
0 /c! 
0 /r! 
// Init display buffer
[ 0 0 0 0 0 0 ] a! 
// Init keyboard buffer
[ 0 0 0 0 ] b!
// Init tape buffer
[ 0 0 0 0 0 0 0 0 ] t!
;

// Pattern table for all displayable chars
:P 
[ #3F #06 #5B #4F #66 #6D #7D #07 
  #7F #6F #77 #7C #39 #5E #79 #71 
  #00 #40 #80 ] p!
;

// Convert hex to pattern
// n -- pattern
:N
#0F & p + ?
;

// Clear display
:C
#FF 1 /O
6(
  0 /i a ?!
)
;

// Full keyboard scan
// Returns key value or FF
:K
0 t!
// Scan rows
4(
  // Set row
  1 { /i | 2 /O
  // Read columns
  3 /I v!
  // Debounce
  25(1 1+')
  // Check stable
  3 /I v = (
    // Valid key found
    v /F = /F (
      // Calculate key number
      /i 4 * w!
      // Find column bit
      0 x!
      4(
        v 1 & (
          x w + y!
        )
        v 1 } v!
        x 1+ x!
      )
      // Store key
      y t!
    )
  )
)
// Return result
t
;

// Display refresh with current buffer
:R
#FF 1 /O
6(
  #FF 1 /O
  /i a ? 1 /O
  /i 2 /O
  25(1 1+')
)
;

// Show number in hex
// n --
:X
" #F0 & 4 } N 0 a ?!
#0F & N 1 a ?!
R
;

// Show Error code
// n --
:E
`Err`
" X
100(R)
;

// Read tape with timeout
:T
0 n!
/U(
  5 /I 1 & /T (
    4 /I m!
    /B
  )
  n 1+ n!
  n 100 > /W
)
#FF
;

// Question data
:Q
[ #77 #7C #3F #3E #78 0 ] q!
[ #71 #3F #3F #5E 0 0 ] r!
[ #76 #3F #7C #6E 0 0 ] s!
[ #38 #3F #3E #79 0 0 ] t!
[ #39 #77 #50 #6D 0 0 ] u!
;

// Show message
// addr --
:S
6(
  /i over ? v!
  v 0 = /F (
    v /i a ?!
  )
)
'
R
;

// Process answer for question
// addr --
:A
// Show question text
" S
100(R)

// Get input (keyboard or tape)
5 /I 1 & (
  // Use tape
  T k!
) /E (
  // Use keyboard
  K k!
)

// Validate input
k #FF = (
  1 E
) /E (
  k 9 > (
    2 E
  ) /E (
    // Check answer
    k p ? v!
    " 0 ? v = (
      c 1+ c!
    )
  )
)
;

// Interrupt handler
:Z
1 /I #80 & (
  // Handle tape interrupt
  T d!
) /E (
  // Handle keyboard interrupt
  K d!
)
d #FF = /F (
  // Process valid input
  d b!
)
;

// Main quiz program
:D
C
0 c!
// Run questions
q A
r A
s A
t A
u A
// Show result
c 5 = (
  `WIN`
) /E (
  c 3 > (
    `GOOD`
  ) /E (
    `FAIL`
  )
)
S
200(R)
;

// Main program loop
:M
I P H
/U(
  D
  `NEXT` S
  50(R)
  K #FF = /W
)
;

```
/////////////////////////////////////////
Key Additions:

1. Hardware Functions:
- Port definitions array
- Full keyboard matrix scan
- Tape interface support
- Interrupt handler

2. Display Functions:
- HEX to segment conversion
- Number display
- Clear display
- Better message handling

3. Input Processing:
- Keyboard matrix scanning
- Tape reading with timeout
- Input validation
- Input buffering

4. Safety Features:
- Port initialization
- Buffer clearing
- Timeout handling
- Error reporting

To use:
```mint
M               // Start program
1 X             // Show hex number
`TEST` S        // Show message
K               // Read keyboard
T               // Read tape
```

///////////////////////
future:
1. Add tape checksum verification?
2. Add more diagnostic functions?
3. Add score saving to memory?
4. Add configuration options?
