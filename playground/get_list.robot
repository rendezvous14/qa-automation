*** Settings ***
Library   Collections

*** Test Cases ***
Test 1
    @{detailedStatus}=  Set Variable    NEW   READY_TO_PICK   PACKED
    Log   ${detailedStatus}
    Compare  ${detailedStatus}

*** Keywords ***
Compare
    [Arguments]  ${detailedStatus}
    Log   @{detailedStatus}[0]
    Should Be Equal   "@{detailedStatus}[0]"   "NEW"
