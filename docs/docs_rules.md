# 🧠 Prompt: Minimal Documentation Generator

I want you to act as a **documentation generator**.  
For each Dart file inside my `core/` folder, create a corresponding Markdown file in a `docs/` folder with the same name.

Each Markdown file should **summarize the file briefly** without showing implementation details or long explanations.

## 📝 Requirements

For each file, include the following sections:

### 1. Purpose
A short sentence describing what the file is responsible for.

### 2. Classes / Functions
List each class or function in a single concise line:
- Show its **parameters** and **return type**.
- Add a **short (1-line)** description of what it does.

## 📄 Output Format

Each generated Markdown file should follow this structure:

