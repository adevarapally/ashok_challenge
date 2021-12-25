#!/usr/bin/python3

import re

def validate_creditcards(creditcards):
    # Validating starting numbers and creditcard number length
    pre_match = re.search(r'^[456]\d{3}(-?)\d{4}\1\d{4}\1\d{4}$',creditcards)
    # Validating repetead
    if pre_match:
        processed_string = "".join(pre_match.group(0).split('-'))
        final_match = re.search(r'(\d)\1{3,}',processed_string)
        if final_match:
            print("Invalid")
        else :
            print("Valid")
    else:
        print("Invalid")
        
if __name__ == "__main__":
    for i in range(int(input())):
        creditcards = input().strip()
        validate_creditcards(creditcards)
        
