*** Settings ***
Library    String

*** Variables ***
${var}   "123456789012345678901234567890"

*** Test Cases ***
TEST1
    ${result_str}=   Evaluate  (${var}[:22] + '...') if len(${var}) > 25 else ${var}
    Log   ${result_str}