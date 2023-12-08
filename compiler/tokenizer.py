import re

PLUS = "+"
MINUS = "-"
TIMES = "*"
DIV = "/"
POT = "^"
EQUAL = "="
NOT = "!"

AND = "&&"
COMPARE = "=="
OR = "||"
GT = ">"
LT = "<"

INT = "INTEGER"
STR = "STRING"
VAR = "variable"
T_INT = "int"
T_STRING = "string"

TILDE = "~"
BRA_IN = "["
BRA_OUT = "]"
PAR_IN = "("
PAR_OUT = ")"
SEMICOLUMN = ";"

IDENTIFIER = "IDENTIFIER"
PRINT = "Log"
SCAN = "scanf"
IF = "condition"
ELSE = "otherway"
DURING = "during"

END = "\n"
EOF = "End of File"



class Token:
    def __init__(self, type, value):
        self.type = type
        self.value = value


class Tokenizer:
    def __init__(self, source, next=None, position=0):
        self.source = str(source)
        self.next = next
        self.position = position

    def selectNext(self):
        if self.position >= len(self.source):  # Checking if is EOF
            self.next = Token(type=EOF, value="EOF")
            return

        while self.position < len(self.source):
            if self.position >= len(self.source):
                self.next = Token(EOF, " ")
                return
            if re.match("[0-9]", self.source[self.position]):  # Checking if is number
                val = ""
                while self.position < len(self.source):
                    if re.match(r"[0-9]", self.source[self.position]):
                        val += self.source[self.position]
                        self.position += 1
                    else:
                        self.next = Token(type=INT, value=int(val))
                        return
                self.next = Token(type=INT, value=int(val))
                return
            elif self.source[self.position] == '"': # checking if is string
                string_value = ""
                self.position+=1
                while (self.position < len(self.source)):
                    if self.source[self.position] != '"':
                        string_value+=self.source[self.position]
                        self.position+=1
                    else:
                        self.position+=1
                        self.next = Token(type=STR, value=str(string_value))
                        return
                raise Exception("String Incorrect")
            elif self.source[self.position] == "+":  # Checking if is plus
                self.next = Token(type=PLUS, value=self.source[self.position])
                self.position += 1
                return
            elif self.source[self.position] == "-":  # Checking if is minus
                self.next = Token(type=MINUS, value=self.source[self.position])
                self.position += 1
                return
            elif self.source[self.position] == "*":  # Checking if is times
                self.next = Token(type=TIMES, value=self.source[self.position])
                self.position += 1
                return
            elif self.source[self.position] == "/":  # Checking if is division
                self.next = Token(type=DIV, value=self.source[self.position])
                self.position += 1
                return
            elif self.source[self.position] == "~":  # Checking if is tilde
                self.next = Token(type=TILDE, value=self.source[self.position])
                self.position += 1
                return
            elif self.source[self.position] == "(":  # Checking if is parentheses open
                self.next = Token(type=PAR_IN, value=self.source[self.position])
                self.position += 1
                return
            elif self.source[self.position] == ")":  # Checking if is parentheses closed
                self.next = Token(type=PAR_OUT, value=self.source[self.position])
                self.position += 1
                return
            elif self.source[self.position] == "[":  # Checking if is bracket open
                self.next = Token(type=BRA_IN, value=self.source[self.position])
                self.position += 1
                return
            elif self.source[self.position] == "]":  # Checking if is bracket close
                self.next = Token(type=BRA_OUT, value=self.source[self.position])
                self.position += 1
                return
            elif self.source[self.position] == "\n":  # Checking if is end
                self.next = Token(type=END, value=self.source[self.position])
                self.position += 1
                return
            elif self.source[self.position] == ";":  # Checking if is semicolumn
                self.next = Token(type=SEMICOLUMN, value=self.source[self.position])
                self.position += 1
                return
            elif re.match(
                "[a-zA-Z]", self.source[self.position]
            ):  # Checking if is IDENTIFIER
                val = ""
                while self.position < len(self.source) and re.match(
                    r"[a-zA-Z1-9_]", self.source[self.position]
                ):
                    val += self.source[self.position]
                    self.position += 1
                if val == PRINT:
                    self.next = Token(type=PRINT, value=str(val))
                elif val == SCAN:
                    self.next = Token(type=SCAN, value=str(val))
                elif val == IF:
                    self.next = Token(type=IF, value=str(val))
                elif val == ELSE:
                    self.next = Token(type=ELSE, value=str(val))
                elif val == DURING:
                    self.next = Token(type=DURING, value=str(val))
                elif val == VAR:
                    self.next = Token(type=VAR, value=str(val))
                elif val == T_INT:
                    self.next = Token(type=T_INT, value=str(val))
                elif val == T_STRING:
                    self.next = Token(type=T_STRING, value=str(val))
                else:
                    self.next = Token(type=IDENTIFIER, value=str(val))
                return
            elif self.source[self.position] == ">":  # Checking if is >
                self.next = Token(type=GT, value=self.source[self.position])
                self.position += 1
                return
            elif self.source[self.position] == "<":  # Checking if is <
                self.next = Token(type=LT, value=self.source[self.position])
                self.position += 1
                return
            elif self.source[self.position] == "!":  # Checking if is !
                self.next = Token(type=NOT, value=self.source[self.position])
                self.position += 1
                return
            elif self.source[self.position] == "^":  # Checking if is .
                self.next = Token(type=POT, value=self.source[self.position])
                self.position += 1
                return
            elif self.source[self.position] == "|":  # Checking if is ||
                self.position += 1
                if self.source[self.position] == "|":
                    self.next = Token(type=OR, value=self.source[self.position])
                    self.position += 1
                    return
                else:
                    raise Exception("| is not valid, try ||")
            elif self.source[self.position] == "=":  # Checking if is =
                self.position += 1
                if self.source[self.position] == "=": # Checking if is ==
                    self.next = Token(type=COMPARE, value=self.source[self.position])
                    self.position += 1
                else:
                    self.next = Token(type=EQUAL, value=self.source[self.position - 1])
                return
            elif self.source[self.position] == "&":  # Checking if is &&
                self.position += 1
                if self.source[self.position] == "&":
                    self.next = Token(type=AND, value=self.source[self.position])
                    self.position += 1
                    return
                else:
                    raise Exception("& is not valid, try &&")
            elif self.source[self.position] == " ":  # jumping spaces
                self.position += 1
                continue
            else:
                raise Exception("Not a Token")