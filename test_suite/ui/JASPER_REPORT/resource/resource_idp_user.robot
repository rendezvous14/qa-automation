*** Settings ***
Documentation     Keyword collections for Dev platform
Resource          ../variables/variables_dev_platform.robot
Library           Selenium2Library

*** Keywords ***
Login Platform
  [Arguments]    ${USER_ROLE}
  Open Browser   ${domain}${MICRO_SERVICES}   ${BROWSER}
  Maximize Browser Window
  Login Platform Page Should Be Open
  Enter User Name   ${USER_ROLE}
  Enter Password    ${PASSWORD}
  Submit Credentials

Login Platform Page Should Be Open
  Element Text Should Be   ${welcome_text_login_page_locator}   Login to aCommerce Management Portal

Enter User Name
  [Arguments]   ${USERNAME}
  Input Text    ${input_username_locator}    ${USERNAME}

Enter Password
  [Arguments]   ${PASSWORD}
  Input Password   ${input_password_locator}   ${PASSWORD}

Submit Credentials
  Click Button    ${login_button_locator}

Reporting Services Page Should Be Opened
  Sleep   5s
  Wait Until Keyword Succeeds    2x    5s    Element Text Should Be   ${jasper_server_home_locator}    Repository
  Click Element    xpath=//*[@id="handler5"]

Access Denied to Reporting Services
  Wait Until Keyword Succeeds    2x    2s    Element Text Should Be   ${login_failed_message_locator}   Oops, You don't have the right access to the Domain!
  Wait Until Keyword Succeeds    2x    2s    Element Text Should Be   ${login_failed_403_locator}  403

Logout Reporting Service and close browser
  ${status}=  Run Keyword And Return Status  Element Should Contain   ${jasper_server_home_locator}  Repository
  Run Keyword If    ${status}   Click Element   ${logout_button_locator}
  Close Browser

Logout Portal and close browser
  [Arguments]  ${URL}
  Go To    ${URL}/user/logout/
  Close Browser

Sherlock folder can be displayed
  [Arguments]   ${sherlock_folder}
  Wait Until Keyword Succeeds    2x    2s   Page Should Contain   ${sherlock_folder}

Sherlock folder cannot be displayed
  [Arguments]   ${sherlock_folder}
  Wait Until Keyword Succeeds    2x    2s   Page Should Not Contain    ${sherlock_folder}
