*** Settings ***
Resource          All_global_library.robot

*** Variables ***
${R_SELENIUM_HUB}    ${CONFIG_SELENIUM_HUB}

*** Keywords ***
Wait Until Page Contains Element Override
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}    timeout=30    error=Timeout exceed 30 s.

Set open browser
    [Arguments]    ${url}
    Run Keyword If    ${R_SELENIUM_HUB != None}    Open Browser    ${url}    chrome    remote_url=${R_SELENIUM_HUB}    desired_capabilities=browserName:chrome
    Run Keyword If    ${R_SELENIUM_HUB == None}    Open Browser    ${url}    chrome
