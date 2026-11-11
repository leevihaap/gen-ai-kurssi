
import os
import sys
 
from openai import OpenAI
 
 
def main() -> None:
    prompt = " ".join(sys.argv[1:]) or "Kerro yhdellä lauseella, mikä on WSL."
 
    client = OpenAI(
        api_key=os.environ["CHAT_API_KEY"],
        base_url=os.environ["CHAT_BASE_URL"],
    )
    response = client.chat.completions.create(
        model=os.environ["CHAT_MODEL"],
        messages=[
            {"role": "user", "content": prompt},
        ],
    )
    print(response.choices[0].message.content)
 
 
if __name__ == "__main__":
    main()
