# Problem
Deepseek v4 pro is great but lacks native vision capability so when you show it a screenshot of a UI issue it gave up.

# Solution
This `vision-skill` agent skill allow deepseek to take the image pass it to a shell script utility and get back the description in the image.

# About the shell script
This skill uses a shell script called `describe-image.sh`. It essentially send the image to **Kimi K2.6** with a prompt to get the image description.

It uses an **OpenAI** compatible API so you can replace kimi with another model or provider. Just change the following:
* model from `kimi-k2.6`
* url from `https://api.moonshot.ai/`
* `MOONSHOT_API_KEY`
