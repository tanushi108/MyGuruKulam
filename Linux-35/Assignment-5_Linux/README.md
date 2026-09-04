# Template Engine & Text Editor Utility

## 📌 Assignment Overview

This assignment consists of two parts:

* **Part A:** Template Engine
* **Part B:** Text Editor Utility

The objective is to create command-line utilities using Bash scripting that simplify template processing and text-file editing operations.

---

# Part A — Template Engine

## 📖 Description

The Template Engine is a Bash utility that generates an output file by replacing variables present in a template file with values provided as command-line arguments.

### Syntax

```bash
./templateEngine.sh <template-file> key1=value1 key2=value2 ...
```

---

## 📂 Example Template

Create a file named `trainer.template`:

```text
{{fname}} is trainer of {{topic}}
```

### Command

```bash
./templateEngine.sh trainer.template fname=sandeep topic=linux
```

### Output

```text
sandeep is trainer of linux
```
<img width="645" height="226" alt="image" src="https://github.com/user-attachments/assets/dcb54ef5-1617-462a-a0e3-e3f5597ecb89" />

---

## ⚙️ How It Works

1. The script accepts a template file as the first argument.
2. Key-value pairs are provided after the template file.
3. The script extracts the key and value from each argument.
4. It searches for variables in the format `{{key}}`.
5. Each variable is replaced with its corresponding value.
6. The processed content is generated as the output.

### Example

Template:

```text
Hello {{fname}}
You are learning {{topic}}.
Trainer: {{trainer}}
```

Command:

```bash
./templateEngine.sh trainer.template fname=Tanushi topic=Linux trainer=Sandeep
```

Output:

```text
Hello Tanushi
You are learning Linux.
Trainer: Sandeep
```

---

## 📸 Figure — Template Engine Flow

```text
                  ┌─────────────────────┐
                  │   Template File     │
                  │                     │
                  │ {{fname}} is        │
                  │ trainer of {{topic}}│
                  └──────────┬──────────┘
                             │
                             ▼
                  ┌─────────────────────┐
                  │  Template Engine    │
                  │      Script         │
                  └──────────┬──────────┘
                             │
                  key=value arguments
                             │
                             ▼
                  ┌─────────────────────┐
                  │ Variable Replacement│
                  │                     │
                  │ fname=sandeep       │
                  │ topic=linux         │
                  └──────────┬──────────┘
                             │
                             ▼
                  ┌─────────────────────┐
                  │   Generated Output  │
                  │                     │
                  │ sandeep is trainer  │
                  │ of linux            │
                  └─────────────────────┘
```

---

# Part B — Text Editor Utility

## 📖 Description

The Text Editor Utility is a command-line Bash utility that provides different operations for modifying text files without manually opening a text editor.

The utility supports:

* Add a line at the top
* Add a line at the bottom
* Add a line at a specific line number
* Replace the first occurrence of a word
* Replace all occurrences of a word
* Insert a word
* Delete a line
* Delete a line containing a specific word

---

# 🚀 Supported Commands

## 1. Add Line at Top

### Syntax

```bash
./otTextEditor addLineTop <file> <line>
```

### Example

```bash
./otTextEditor addLineTop file1.txt "This is the first line"
```

### Result

The specified line is added at the beginning of the file.

<img width="598" height="82" alt="image" src="https://github.com/user-attachments/assets/effdb358-bf71-4a0e-a2ab-243ce3b94fc7" />

---

## 2. Add Line at Bottom

### Syntax

```bash
./otTextEditor addLineBottom <file> <line>
```

### Example

```bash
./otTextEditor addLineBottom file1.txt "This is the last line"
```

The line is added at the end of the file.

<img width="604" height="103" alt="image" src="https://github.com/user-attachments/assets/64a02a6a-14c6-450d-b13a-94512c48f6f9" />

---

## 3. Add Line at Specific Line Number

### Syntax

```bash
./otTextEditor addLineAt <file> <linenumber> <line>
```

### Example

```bash
./otTextEditor addLineAt file1.txt 3 "This is a new third line"
```

The specified line is inserted at line number `3`.

<img width="639" height="119" alt="image" src="https://github.com/user-attachments/assets/1da76697-4aa8-4c68-97ef-ef2fa5e79b0d" />

---

## 4. Update First Word

Replaces the first occurrence of a word.

### Syntax

```bash
./otTextEditor updateFirstWord <file> <word> <word2>
```

### Example

```bash
./otTextEditor updateFirstWord file1.txt Linux Unix
```

If the file contains:

```text
I am learning Linux.
Linux is an operating system.
```

The result will be:

```text
I am learning Unix.
Linux is an operating system.
```

<img width="587" height="119" alt="image" src="https://github.com/user-attachments/assets/1d6b4a69-141c-48b4-ae9c-6b6d043fe8e1" />

---

## 5. Update All Words

Replaces all occurrences of a word.

### Syntax

```bash
./otTextEditor updateAllWords <file> <word> <word2>
```

### Example

```bash
./otTextEditor updateAllWords file1.txt Linux Unix
```

Result:

```text
I am learning Unix.
Unix is an operating system.
```

<img width="621" height="122" alt="image" src="https://github.com/user-attachments/assets/cf7c3b44-dd77-4cf2-a136-cf219965e432" />

---

## 6. Insert Word

Inserts a word after a specified word.

### Syntax

```bash
./otTextEditor insertWord <file> <word1> <word2> <word-to-be-inserted>
```

### Example

```bash
./otTextEditor insertWord sample.txt I learning quickly
```

The utility inserts the specified word according to the implemented insertion logic.

<img width="608" height="120" alt="image" src="https://github.com/user-attachments/assets/5ae82884-fa4a-40ae-8ba2-4c648f1e6655" />

---

## 7. Delete Line

Deletes a line using its line number.

### Syntax

```bash
./otTextEditor deleteLine <file> <line-no>
```

### Example

```bash
./otTextEditor deleteLine file1.txt 3
```

Line number `3` will be removed from the file.

<img width="503" height="33" alt="image" src="https://github.com/user-attachments/assets/2b9a0117-415e-42a1-a161-383adb2d2296" />


<img width="402" height="87" alt="image" src="https://github.com/user-attachments/assets/69c4e281-aa0d-43f9-9037-5d1ec614d574" />

---

## 8. Delete Line Containing a Word

Deletes the line containing the specified word.

### Syntax

```bash
./otTextEditor deleteLine <file> <line-no> <word>
```

### Example

```bash
./otTextEditor deleteLine file1.txt 3 Linux
```

The matching line will be removed according to the implemented logic.

<img width="564" height="107" alt="image" src="https://github.com/user-attachments/assets/cf93eb55-cb15-4270-94e7-96cfc1706cf3" />

---

# ⭐ Additional Features

The Text Editor Utility can also provide additional features to make it more useful.

### Suggested Features

* 📄 Display complete file
* 🔢 Display line numbers

<img width="457" height="143" alt="image" src="https://github.com/user-attachments/assets/a543c36b-0e6d-4d2c-95dc-d0af9311735e" />

---

# 📸 Figure — Text Editor Utility Flow

```text
                  ┌─────────────────────┐
                  │     User Command    │
                  │                     │
                  │ ./otTextEditor ... │
                  └──────────┬──────────┘
                             │
                             ▼
                  ┌─────────────────────┐
                  │   Command Parser    │
                  └──────────┬──────────┘
                             │
             ┌───────────────┼───────────────┐
             │               │               │
             ▼               ▼               ▼
        Add Line        Update Word     Delete Line
             │               │               │
             └───────────────┼───────────────┘
                             ▼
                  ┌─────────────────────┐
                  │     Text File       │
                  │      Modified       │
                  └─────────────────────┘
```




---

# 🧪 Testing

The utilities should be tested with:

* Valid input
* Invalid file names
* Missing arguments
* Empty files
* Multiple occurrences of words
* Words that do not exist
* Invalid line numbers
* Special characters
* Multiple key-value pairs in the template engine

Example:

```bash
chmod +x templateEngine.sh
chmod +x otTextEditor

./templateEngine.sh trainer.template fname=Tanushi topic=Linux

./otTextEditor addLineTop sample.txt "Welcome to Linux"
./otTextEditor addLineBottom sample.txt "End of file"
./otTextEditor addLineAt sample.txt 3 "New line"
./otTextEditor updateFirstWord sample.txt Linux Unix
./otTextEditor updateAllWords sample.txt Linux Unix
./otTextEditor deleteLine sample.txt 3
```
<img width="376" height="307" alt="image" src="https://github.com/user-attachments/assets/59666026-e244-4388-8a10-b3e836e2eaf9" />

---

# 🛡️ Error Handling

The scripts should display meaningful error messages when:

* The file does not exist.

Example:

```text
Error: File 'abc.txt' does not exist.
```

<img width="456" height="53" alt="image" src="https://github.com/user-attachments/assets/907a6c91-a897-47c6-a8d2-6b61d06765d8" />


---

# 👩‍💻 Author

**Tanushi Rana**

This assignment demonstrates the implementation of command-line utilities using Bash scripting.
