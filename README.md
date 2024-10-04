# tec-DATING
a TEC-1 1960's style computer dating app

 
![image](https://user-images.githubusercontent.com/58069246/211028711-37603d83-15e8-4033-9434-8c6c407bb58e.png)

"Why did Bender use a software dating service? .... Because he was sick of being hit on all the time and he wanted a `discrete binary` relationship that was `discreet` at finding love."

Certainly! I'll create a simple dating app using MINT code that can run on the TEC-1 computer and display answers on a serial terminal. This app will ask a series of questions to two users, compare their answers, and calculate a compatibility score. Here's the MINT code for the dating app:

### logic
- prompts the user to enter two names by reading in paper to a tape reader,
- and then asks ten questions to determine compatibility.
-
- The COMPATIBILITY function asks each question and increments the compatibility score if the answers match.
- The program then displays the compatibility score or the words "Perfect match!" on the six-segment display using port 3.

### date.md

This MINT code implements a simple dating app for the TEC-1 computer. Here's how it works:

1. The `I` function reads input from the paper tape reader, storing characters in a buffer until it encounters a carriage return.

2. The `O` function outputs a string to the serial terminal.

3. The `C` function compares two strings and returns 1 if they're equal, 0 otherwise.

4. The `Q` function asks a question (outputs it) and gets an answer (inputs it).

5. The main `D` function runs the dating app:
   - It asks for the names of two people.
   - It then asks five questions to each person.
   - For each matching answer, it increments the compatibility score.
   - Finally, it displays the compatibility score and a message based on the score.

To run the app on the TEC-1:

1. Load this MINT code into the TEC-1's memory.
2. Ensure the TEC-1 is connected to a serial terminal for input and output.
3. Run the `D` function to start the dating app.

The app will guide the users through the questions and display the results on the serial terminal.

Note that this is a basic implementation and could be expanded with more questions, more sophisticated matching algorithms, or additional features like storing results in memory. The code assumes that the TEC-1 is set up with the necessary I/O capabilities for serial communication and paper tape reading.





