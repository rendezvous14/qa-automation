*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${LOGIN_BUTTON}    xpath=/html/body/div[2]/form/div[3]/button
@{chrome_arguments}    --disable-infobars    --headless    --disable-gpu

*** Keywords ***
Login to admin
    ${chrome_options}=    Set Chrome Options
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Go To    ${ADMIN_URL}
    Maximize Browser Window
    Wait Until Page Contains Element    ${LOGIN_BUTTON}    timeout=30    error=Time out!!!
    input text        name=username     ${ADMIN_LOGIN_NAME}
    input password    name=password     ${ADMIN_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Keyword Succeeds    2x    10s    Page Should Contain     Welcome to Admin Portal.

Set Chrome Options
    [Documentation]    Set Chrome options for headless mode
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    : FOR    ${option}    IN    @{chrome_arguments}
    \    Call Method    ${options}    add_argument    ${option}
    [Return]    ${options}

Go to ui-sales-order page
    [Arguments]    ${partner_id}
    Login to admin
    Go to    ${SO_URL}/${partner_id}

Go to ui-inventory page
    [Arguments]    ${partner_id}
    Login to admin
    Go to    ${INVENTORY_URL}/${partner_id}

Verify Item on portal
    [Arguments]    ${partner_id}  ${partnerItemId_General}  ${description}
    #####    Check item on portal    #####
    Go to ui-inventory page   ${partner_id}
    Wait Until Keyword Succeeds   5x  10s  Element Text Should Be    ${ITEM_MASTERLIST_ROW_1_COL_1}    ${partnerItemId_General}
    Wait Until Keyword Succeeds   5x  10s  Element Text Should Be    ${ITEM_MASTERLIST_ROW_1_COL_2}    ${description}

#
# Verify Item Discount on portal
#     [Arguments]    ${partner_id}  ${partner_item_id}  ${description}  ${getdate}
#     #####    Check item on portal    #####
#     ${R_ITEM_DISCOUNT_LIST}    Replace String    ${R_ITEM_DISCOUNT_LIST}    <CONFIG_PARTNER_ID>    ${partner_id}
#     Login to admin    ${R_ITEM_DISCOUNT_LIST}
#     Element Text Should Be    ${R_WE_ITEM_DISCOUNT_LIST_ROW_1_COL_1}    ${partner_item_id}
#     Element Text Should Be    ${R_WE_ITEM_DISCOUNT_LIST_ROW_1_COL_2}    ${description}
#     Element Should Contain    ${R_WE_ITEM_DISCOUNT_LIST_ROW_1_COL_3}    ${getdate}
#
# Verify Item Service on portal
#     [Arguments]    ${partner_id}  ${partner_item_id}  ${description}  ${getdate}
#     #####    Check item on portal    #####
#     ${R_ITEM_SERVICE_LIST}    Replace String    ${R_ITEM_SERVICE_LIST}    <CONFIG_PARTNER_ID>    ${partner_id}
#     Login to admin    ${R_ITEM_SERVICE_LIST}
#     Element Text Should Be    ${R_WE_ITEM_SERVICE_LIST_ROW_1_COL_1}    ${partner_item_id}
#     Element Text Should Be    ${R_WE_ITEM_SERVICE_LIST_ROW_1_COL_2}    ${description}
#     Element Should Contain    ${R_WE_ITEM_SERVICE_LIST_ROW_1_COL_3}    ${getdate}
