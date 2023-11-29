# gptjr
A smart and customizable translation tool for academics

Despite the varying domain knowledge and language proficiency among users, current translation systems do not adequately provide personalized or customized translation results. Our system enables users to customize their translations by (1) allowing manual adjustments to the resulting translations, (2) offering suggestions for similar replacements, and (3) iteratively collecting choices made by users to customize future results. By leveraging LLM to provide explanations for translation results, our system helps users understand the rationale behind translations and encourages feedback for personalization.

## Instruction
Our system provides a simple and intuitive interface for translating English texts into Korean.
1. Log in by entering your preferred username.
2. Click your preferred text source.*
3. Once you get the translation, you can explore your translation with the following **three features**.
4. After exploration, click Next paragraph, and you will be taken to the next paragraph until you reach the end of the text source.

* Note: Source texts are given for evaluation and comparison purposes.

### Features

##### (1) View with original text
You can see the translation with the original text to understand what word led to the translation.   
1. Select a word you are interested in.
2. Click View Original Text.


##### (2) Add preference
1. Select a word you are interested in, and you will be recommended replacements for the selected word.
2. Click a word you want to replace with.

##### (3) Expand preference
You can also get a suggestion for a similar replacement from the system based on your preferences.
1. After choosing a replacement word, you will be recommended a similar replacement you might be also interested.
2. Click the recommended word if you want to replace further.    
<br><br>



## Implementation Notes
Our system is implemented using Flutter for the front-end, and Python, Flask, and Firebase for the back-end.
In the front-end, ResultPage in result_page.dart deals with translated version of each paragraphs, where the user can perform three actions listed above through the function handleWordTap().
The functions `get_translation()` and `add_preference()` in `main.py` handle translation using OpenAI gpt-3.5 and chained prompts.

Prototype URL:  https://gptjr-756b8.web.app  
Front-end URL: https://github.com/otdababy/gptjr

- Front-end: Flutter
- LLM: openai, langchain
- DB: Firebase Firestore
- API: Firebase Cloud Functions, Flask
