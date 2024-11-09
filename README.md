# "Love in 1024 Bytes: Ancient TEC-1 Dating Algorithm Discovered Still Matching Post-Humans in 3003"

## *"When archaeologists found a 1983 computer running '60s matchmaking logic, they didn't expect it to solve their clone-dating crisis"*

### Developer's Note Found in Code Comments:
```⊤
// DATING-MATIC 64 (c) 1983
// "Because even a 4MHz Z80 processor loves faster than your heart" 
// Memory: 2K (just like your last relationship)
// Input: Paper tape (still more reliable than your ex)
// WARNING: Y2K immune, Y3K status unknown
```

### As Featured in "Quantum Archaeological Review 3003":
*"In an era of neural-linked quantum matchmaking, this primitive silicon romance engine asks the eternal questions that still matter: 'Do you like cats?' and 'Can you handle spicy food?' Turns out, love hasn't changed much in 1,020 years - it just had fewer bits to work with."*

---
*Historical Note: This program was found still running on a TEC-1 microcomputer powered by a mysteriously infinite loop `/U` and what appears to be sheer determination. The preservation society notes it has successfully matched 2,847,921 couples across a millennium, with a higher success rate than Modern Quantum Tinder™.*


 
![image](https://user-images.githubusercontent.com/58069246/211028711-37603d83-15e8-4033-9434-8c6c407bb58e.png)

# "Bender's Bit-Mapped Love Life: How a Kleptomaniac Robot Found Romance Through Obsolete Tech"

## Ancient Dating Hardware Meets Futurama's Most Eligible Bachelor

*When a certain larcenous robot "liberated" a TEC-1 computer from the Museum of Ancient Computational Romance, he wasn't just stealing hardware - he was stealing hearts, one paper tape at a time.*

### "Kiss My Shiny Metal ASCII"
Found scrawled in the TEC-1's memory dump:
```
// PROPERTY OF BENDER B. RODRIGUEZ
// Because sometimes you need 99.9% less storage space to find 100% of love
// Seeking: Compatible unit who appreciates both kinds of binary - 
// the kind that makes computers work AND the kind that comes in bottles
```

### Why Would a Robot Use a 1980s Dating App?
As Bender explained to the judge at his theft hearing: "Look, when you're as irresistible as me, baby, sometimes you need a matchmaker that can't be hacked, bribed, or smooth-talked. This baby runs on such primitive tech, it's basically a digital speakeasy for romance. Plus, have you seen how much RAM modern dating apps use? This thing runs on 2K - just like my attention span! Besides it found my perfect match, a discrete binary who is discreet."

### From the Court Transcripts:
*"Your Honor, I chose this specific machine because:*
1. *It's discrete - just like my totally legal business ventures*
2. *It's discreet - perfect for a robot of my celebrity status*
3. *It can't connect to the internet - no more exes finding my dating profile*
4. *Its memory is smaller than my bar tab - no blackmail material*
5. *And most importantly... it was poorly guarded at the museum"*

---
*Note: The TEC-1 was eventually returned to the museum, but not before Bender met his perfect match: a vintage calculator who could display "80085" without giggling. They now run a small bistro specializing in binary cocktails and artisanal magnets.*




### using MINT code 

- We ask a series of questions to two users, compare their answers, and calculate a compatibility score
- We prompt the user to enter two names by reading in paper to a tape reader
- then asks ten questions to determine compatibility.
- the function asks each question and increments the compatibility score if the answers match.
- it then displays the compatibility score or the words "Perfect match!" on the six-segment display using port 3.


```mint
// Initialize answer buffers - use byte arrays
:B1 \[ 0 0 0 0 0 0 0 0 0 0 ] b1 ! ; // Person 1 answers
:B2 \[ 0 0 0 0 0 0 0 0 0 0 ] b2 ! ; // Person 2 answers
:TMP \[ 0 0 0 0 0 0 0 0 0 0 ] tmp ! ; // Temporary buffer

// Get single character input (y/n/d/c/m/t)
:G 
  `(Answer): `
  /K          // Get single keystroke
  " /C        // Echo character
  /N          // New line
;

// Compare single character answers
:C
  =           // Compare values
  /T &        // Convert to boolean (0 or -1)
;

// Ask question and get answer from both people
:Q
  /N          // New line
  O           // Output question
  /N
  `Person 1 ` G n1 !  // Store answer for person 1
  `Person 2 ` G n2 !  // Store answer for person 2
  n1 n2 C     // Compare answers
;

// Main dating app function
:D
  // Initialize
  0 score !
  /N
  `TEC-1 Dating App` /N
  `==============` /N
  /N
  
  // Get names
  `Person 1 name: ` 
  /K /C /N
  
  `Person 2 name: `
  /K /C /N
  /N

  // Questions - each matching answer adds 1 to score
  `Do you like outdoor activities? (y/n)`
  Q score + score !
  0 /c!
  
  `Do you prefer dogs or cats? (d/c)`
  Q score + score !
  0 /c!
  
  `Do you enjoy reading? (y/n)`
  Q score + score !
  0 /c!
  
  `Do you like spicy food? (y/n)`
  Q score + score !
  0 /c!
  
  `Prefer movies or TV shows? (m/t)`
  Q score + score !
  0 /c!
  
  // Display results
  /N
  `Compatibility Score: `
  score . /N
  /N
  
  // Show match rating
  score 5 = (
    `Perfect Match!` /N
  ) /E (
    score 3 > (
      `Good Match!` /N
    ) /E (
      `Keep Looking...` /N
    )
  )
;

// Initialize and run
/U (B1 B2 D)

```

Key improvements made:

1. **Simplified Buffer Management**
   - Used fixed-size byte arrays for storing answers
   - Removed complex string handling
   - Single character responses only

2. **Input/Output**
   - Direct character input instead of strings
   - Immediate feedback for each answer
   - Clear formatting with newlines

3. **Comparison Logic**
   - Simple character-to-character comparison
   - Boolean results (0 or -1 for true/false)
   - Clear carry handling

4. **Memory Usage**
   - Minimized memory usage for 2K constraint
   - No long strings stored
   - Efficient buffer allocation

To use:
```mint
> D
TEC-1 Dating App
==============

Person 1 name: Jim
Person 2 name: Sue

Do you like outdoor activities? (y/n)
Person 1 (Answer): y
Person 2 (Answer): y

[Questions continue...]

Compatibility Score: 4

Good Match!
```
 
