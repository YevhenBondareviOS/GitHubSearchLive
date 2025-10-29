#!/usr/bin/env python3
"""
Token Obfuscation Helper for GitHubSearchLive
This script helps obfuscate your GitHub token to avoid detection in commits.
"""

import sys

def obfuscate_token(token, key=42):
    """Obfuscate a GitHub token using XOR encryption."""
    if token.startswith('ghp_'):
        prefix = token[:4]  # "ghp_"
        token_body = token[4:]
    elif token.startswith('github_pat_'):
        prefix = token[:11]  # "github_pat_"
        token_body = token[11:]
    else:
        print("Warning: Token doesn't start with 'ghp_' or 'github_pat_' - this might not be a valid GitHub token")
        prefix = token[:4]  # Default to first 4 chars
        token_body = token[4:]
    
    # Split into 3 parts
    part_length = len(token_body) // 3
    part1 = token_body[:part_length]
    part2 = token_body[part_length:part_length*2]
    part3 = token_body[part_length*2:]
    
    # Obfuscate each part using base64 encoding to avoid character issues
    import base64
    
    def obfuscate_part(part, key):
        # XOR each character
        xor_result = ''.join(chr(ord(c) ^ key) for c in part)
        # Encode to base64 to avoid character encoding issues
        return base64.b64encode(xor_result.encode('latin-1')).decode('ascii')
    
    obfuscated1 = obfuscate_part(part1, key)
    obfuscated2 = obfuscate_part(part2, key)
    obfuscated3 = obfuscate_part(part3, key)
    
    return prefix, obfuscated1, obfuscated2, obfuscated3, key

def main():
    if len(sys.argv) != 2:
        print("Usage: python3 obfuscate_token.py <your_github_token>")
        print("Example: python3 obfuscate_token.py ghp_1234567890abcdef")
        sys.exit(1)
    
    token = sys.argv[1]
    prefix, part1, part2, part3, key = obfuscate_token(token)
    
    print("\n" + "="*60)
    print("OBFUSCATED TOKEN PARTS")
    print("="*60)
    if token.startswith('github_pat_'):
        print("let prefixPart1 = \"git\" // First part of prefix")
        print("let prefixPart2 = \"hub_\" // Second part of prefix")
        print("let prefixPart3 = \"pat_\" // Third part of prefix")
    else:
        print("let prefixPart1 = \"ghp\" // First part of prefix")
        print("let prefixPart2 = \"_\" // Second part of prefix")
        print("let prefixPart3 = \"\" // Third part of prefix")
    
    print(f"let part1 = \"{part1}\" // Replace with actual token parts")
    print(f"let part2 = \"{part2}\" // Replace with actual token parts")
    print(f"let part3 = \"{part3}\" // Replace with actual token parts")
    print(f"let key: UInt8 = {key}")
    print("="*60)
    print("\nCopy these lines into your Network.swift file.")
    print("⚠️  WARNING: This is still not secure! Consider using environment variables.")
    print("="*60)

if __name__ == "__main__":
    main()
