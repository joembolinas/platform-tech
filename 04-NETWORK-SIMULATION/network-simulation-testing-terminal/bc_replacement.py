#!/usr/bin/env python
import sys
import re

def calculate(expression):
    try:
        # Clean the expression
        expr = expression.strip()
        
        # Handle scale parameter (ignore it for basic calculations)
        if expr.startswith('scale='):
            parts = expr.split(';', 1)
            if len(parts) > 1:
                expr = parts[1].strip()
            else:
                return "0"
        
        # Basic math operations
        expr = expr.replace(' ', '')
        
        # Simple evaluation for basic arithmetic
        result = eval(expr)
        
        # Format result
        if isinstance(result, float):
            if result.is_integer():
                return str(int(result))
            else:
                return f"{result:.1f}"
        else:
            return str(result)
            
    except:
        return "0"

if __name__ == "__main__":
    if len(sys.argv) > 1:
        expression = ' '.join(sys.argv[1:])
    else:
        expression = sys.stdin.read()
    
    print(calculate(expression))
