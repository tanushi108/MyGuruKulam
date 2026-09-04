⭐ Assignment 3

📌 Overview

This assignment contains 2 parts:

➜ Part A : Star Pattern Generator

➜ Part B : TomCat Number Checker

⭐ Part A - Star Pattern Generator

🎯 Objective

Create a shell script drawStar.sh that generates different star patterns based on:

✔ Size

✔ Pattern Type (t1 - t7)

▶ Usage

./drawStar.sh <size> <type>

Example

./drawStar.sh 5 t1

📥 Inputs

Symbol	Description

🔢	Size of the pattern

🔤	Pattern Type (t1–t7)

📤 Sample Outputs

⭐ t1

<img width="378" height="134" alt="image" src="https://github.com/user-attachments/assets/7932ab07-1aae-4b41-bea8-b801f5103657" />



⭐ t2

<img width="378" height="134" alt="image" src="https://github.com/user-attachments/assets/f06d718f-688a-4240-ba0f-2203b605aceb" />



⭐ t3

<img width="378" height="134" alt="image" src="https://github.com/user-attachments/assets/fea27762-df0a-49e0-8cb5-c1dcd4fa618a" />



⭐ t4

<img width="378" height="134" alt="image" src="https://github.com/user-attachments/assets/2d2c986f-2bd3-4bc3-b221-c90b21f6a4f7" />



⭐ t5


<img width="378" height="120" alt="image" src="https://github.com/user-attachments/assets/9b007d3d-df74-425f-9d9a-bb2ee4a3f613" />



⭐ t6

<img width="378" height="120" alt="image" src="https://github.com/user-attachments/assets/c4e5ec09-7d1f-41fc-8889-6f90d88c582b" />



⭐ t7

<img width="378" height="182" alt="image" src="https://github.com/user-attachments/assets/015e2d13-0a93-4bae-b3a4-1b2e524501bc" />


🛠 Concepts Used

✔ Command Line Arguments

✔ case statement

✔ for loop

✔ Nested loops

✔ Arithmetic operations

✔ Pattern Printing
________________________________________


🐱 Part B - TomCat Script

🎯 Objective

Create a shell script printTomcat.sh that prints output according to divisibility rules.

▶ Usage

./printTomcat.sh <number>

📋 Conditions

If divisible by 3  ➜ tom

If divisible by 5  ➜ cat

If divisible by 15 ➜ tomcat

Otherwise          ➜ This number is not divisible by 3,5 and 15.

📤 Sample Execution

$ ./printTomcat.sh 7
This number is not divisible by 3,5 and 15.

$ ./printTomcat.sh 6
tom

$ ./printTomcat.sh 10
cat

$ ./printTomcat.sh 30
tomcat


<img width="378" height="165" alt="image" src="https://github.com/user-attachments/assets/b6c66399-443f-4f04-857a-13f5d3a2068b" />




🛠 Concepts Used

✔ if-elif-else

✔ Modulus (%)

✔ Command Line Arguments

✔ Integer Comparison

✔ Conditional Statements

⚙️ Make Scripts Executable

chmod +x drawStar.sh

chmod +x printTomcat.sh

▶ Execute

./drawStar.sh 5 t1

./printTomcat.sh 30


📁 Assignment

 ├── Problem Statement.txt

 ├── drawStar.sh
 
 ├── printTomCat.sh
 
 └── README.md

✅ Learning Outcomes

✓ Bash Scripting

✓ Command Line Arguments

✓ Conditional Statements

✓ case Statement

✓ for Loops

✓ Nested Loops

✓ Pattern Printing

✓ Arithmetic Operations

✓ Modulus Operator

✓ Script Execution Permissions
________________________________________
🎉 Assignment Completed
