: INPUT ( -- name1 name2 )
   BEGIN
      PAPER_TAPE_READER 8 C@
      OVER C@ '\r' = UNTIL
      SWAP C!
   REPEAT
;

: COMPARE ( name1 name2 -- result )
   DUP LENGTH SWAP LENGTH =
   IF
      0
   ELSE
      SWAP
      BEGIN
         DUP WHILE
         1+
         OVER C@ SWAP C@ =
         IF
            DROP
         ELSE
            -1
         THEN
      REPEAT
   THEN
;

: MATCH? ( name1 name2 -- flag )
   COMPARE 0 =
;

: OUTPUT ( result -- )
   BEGIN
      3 C@
      SIX_DIGIT_DISPLAY C!
      1+
   WHILE
;

: QUESTION ( question -- answer )
   "Enter answer for question: "
   TYPE
   question
   TYPE
   INPUT
;

: COMPATIBILITY ( -- compatibility-score )
   0
   question "Do you enjoy outdoor activities?"
   MATCH?
   IF
      1+
   THEN
   question "Do you prefer dogs or cats?"
   MATCH?
   IF
      1+
   THEN
   question "Do you prefer city or country living?"
   MATCH?
   IF
      1+
   THEN
   question "Do you prefer sweet or savory food?"
   MATCH?
   IF
      1+
   THEN
   question "Do you enjoy going to concerts?"
   MATCH?
   IF
      1+
   THEN
   question "Do you prefer movies or books?"
   MATCH?
   IF
      1+
   THEN
   question "Do you enjoy trying new things?"
   MATCH?
   IF
      1+
   THEN
   question "Do you prefer morning or night?"
   MATCH?
   IF
      1+
   THEN
   question "Do you enjoy travelling?"
   MATCH?
   IF
      1+
   THEN
;

: DATING ( -- )
   "Enter names:"
   TYPE
   INPUT
   "Calculating compatibility..."
   OUTPUT
   COMPATIBILITY
   DUP 10 =
   IF
      "Perfect match!"
      OUTPUT
   ELSE
      "Compatibility score: "
      OUTPUT
      .
   THEN
;
