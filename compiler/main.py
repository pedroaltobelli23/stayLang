import sys
from parserP import Parser
import os

if __name__ == "__main__":
    chain = sys.argv[1]
    if chain.find(".stay") == -1:
        raise Exception("Must be a .stay file")
    parser = Parser()
    final = parser.run(chain,"/outputs_asm/")
