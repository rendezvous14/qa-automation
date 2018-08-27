*** Settings ***
Documentation     Keyword collections for Dev platform
Resource          ../variables/variables_dev_platform.robot
# Library           OperatingSystem
Library           Selenium2Library

*** Keywords ***
Login Platform
  [Arguments]    ${URL}  ${MICRO_SERVICES}   ${USER_ROLE}
  Open Browser   ${URL}${MICRO_SERVICES}   ${BROWSER}
  Maximize Browser Window
  Login Platform Page Should Be Open
  Enter User Name   ${USER_ROLE}
  Enter Password    ${PASSWORD}
  Submit Credentials

Login Platform Page Should Be Open
  Element Text Should Be   css=body > div.content > form > h3   Login to aCommerce Management Portal

Enter User Name
  [Arguments]   ${USERNAME}
  Input Text    xpath=/html/body/div[2]/form/div[1]/div/input    ${USERNAME}

Enter Password
  [Arguments]   ${PASSWORD}
  Input Password   xpath=/html/body/div[2]/form/div[2]/div/input    ${PASSWORD}

Submit Credentials
  Click Button    css=body > div.content > form > div.form-actions > button

Reporting Services Page Should Be Open
  Wait Until Keyword Succeeds  3x  2s  Element Text Should Be   css=#results > div > div.header > div   Repository

Access Denied to Reporting Services
  Wait Until Keyword Succeeds  3x  2s  Element Text Should Be   xpath=/html/body/div/div/div   Oops, You don't have the right access to the Domain!
  Wait Until Keyword Succeeds  3x  2s  Element Text Should Be   xpath=/html/body/div/div/h1    403

Logout Reporting Service and close browser
  Click Element  css=#main_logOut_link
  Close Browser

Logout Portal and close browser
  [Arguments]  ${URL}
  Go To    ${URL}/user/logout/
  Close Browser
