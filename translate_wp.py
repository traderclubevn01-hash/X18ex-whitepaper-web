import os
import json
import time
import urllib.request
import urllib.error

API_KEY = "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"
URL = "https://api.openai.com/v1/chat/completions"

PROMPT = """You are an expert blockchain and crypto translator. 
Translate the following Vietnamese whitepaper content into highly professional, commercial-standard English. 
IMPORTANT RULES:
1. Preserve all Markdown formatting perfectly (headings, bold, tables, lists, code blocks, mermaid diagrams).
2. DO NOT translate technical terms that should remain in English (e.g., node, staking, yield, smart contract, AMM, CLOB, slippage).
3. Keep the tone professional, institutional, and compelling (VC-grade).
4. Do not output anything except the translated markdown content. Do not wrap in ```markdown if it wasn't in the original, just return the exact translated string.
"""

def translate_content(text):
    data = {
        "model": "gpt-4o",
        "messages": [
            {"role": "system", "content": PROMPT},
            {"role": "user", "content": text}
        ],
        "temperature": 0.2
    }
    
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {API_KEY}"
    }
    
    req = urllib.request.Request(URL, data=json.dumps(data).encode('utf-8'), headers=headers)
    
    try:
        with urllib.request.urlopen(req) as response:
            result = json.loads(response.read().decode())
            return result['choices'][0]['message']['content']
    except urllib.error.HTTPError as e:
        print(f"HTTP Error: {e.code} - {e.read().decode()}")
        return None
    except Exception as e:
        print(f"Error: {e}")
        return None

def main():
    base_dir = "."
    
    # Files to ignore
    ignore_files = ["README.md"]
    
    md_files = []
    for root, dirs, files in os.walk(base_dir):
        # Ignore node_modules or .git
        if ".git" in root or "node_modules" in root:
            continue
        for file in files:
            if file.endswith(".md") and file not in ignore_files:
                md_files.append(os.path.join(root, file))
                
    total = len(md_files)
    print(f"Found {total} files to translate.")
    
    for idx, filepath in enumerate(md_files):
        print(f"[{idx+1}/{total}] Translating {filepath}...")
        
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Avoid translating if already looks mostly English or very short
        if len(content.strip()) < 10:
            continue
            
        translated = translate_content(content)
        
        if translated:
            # Clean up markdown wrappers if Gemini added them
            if translated.startswith("```markdown\n") and translated.endswith("\n```"):
                translated = translated[12:-4]
            elif translated.startswith("```\n") and translated.endswith("\n```"):
                translated = translated[4:-4]
                
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(translated)
            print(f"  -> Success")
        else:
            print(f"  -> Failed. Skipping...")
            
        # Rate limit protection (OpenAI)
        time.sleep(1)

if __name__ == "__main__":
    main()
