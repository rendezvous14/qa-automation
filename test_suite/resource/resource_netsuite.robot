*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${NS_XPATH_USERNAME}    //*[@id="userName"]
${NS_XPATH_PASSWORD}    //*[@id="password"]
${NS_XPATH_LOGIN_SUBMIT}    //*[@id="submitButton"]
${NS_XPATH_ANSWER}    //*[@id="null"]
${NS_XPATH_ANSWER_SUBMIT}    xpath=/html/body/form/table/tbody/tr[4]/td/input
${NS_XPATH_QUESTION}    xpath=/html/body/form/table/tbody/tr[3]/td/table/tbody/tr[2]/td[2]
${NS_XPATH_SEARCH_STRING}    id=_searchstring
${NS_XPATH_SEARCH_RESULT}    //*[@id="row0"]/td[1]/a[2]
# Item Master
${NS_XPATH_INVENTORY_ITEM_NAME}    //*[@id="tr_fg_fieldGroup6"]/td[1]/table/tbody/tr[2]/td/div/span[2]
${NS_XPATH_INVENTORY_ITEM_EXTERNAL_ID}    //*[@id="tr_fg_fieldGroup6"]/td[1]/table/tbody/tr[3]/td/div/span[2]
${NS_XPATH_INVENTORY_ITEM_EXTERNAL_ID_C}    //*[@id="tr_fg_fieldGroup6"]/td[1]/table/tbody/tr[4]/td/div/span[2]
${NS_XPATH_INVENTORY_ITEM_PARTNER_ID}    //*[@id="tr_fg_fieldGroup6"]/td[1]/table/tbody/tr[5]/td/div/span[2]
${NS_XPATH_INVENTORY_ITEM_UPC}    //*[@id="tr_fg_fieldGroup6"]/td[2]/table/tbody/tr[2]/td/div/span[2]
${NS_XPATH_INVENTORY_ITEM_PRODUCT_TITLE}    //*[@id="tr_fg_fieldGroup7"]/td[1]/table/tbody/tr[1]/td/div/span[2]
${NS_XPATH_INVENTORY_ITEM_FULFILLMENT_PATTERN}    //*[@id="tr_fg_fieldGroup7"]/td[2]/table/tbody/tr[1]/td/div/span[2]/span
${NS_XPATH_INVENTORY_ITEM_STORAGE_REQ}    //*[@id="tr_fg_fieldGroup7"]/td[2]/table/tbody/tr[3]/td/div/span[2]/span
${NS_XPATH_INVENTORY_ITEM_WEIGHT}    //*[@id="tr_fg_fieldGroup7"]/td[2]/table/tbody/tr[4]/td/div/span[2]
${NS_XPATH_INVENTORY_ITEM_LENGTH}    //*[@id="tr_fg_fieldGroup7"]/td[3]/table/tbody/tr[1]/td/div/span[2]
${NS_XPATH_INVENTORY_ITEM_WIDTH}    //*[@id="tr_fg_fieldGroup7"]/td[3]/table/tbody/tr[2]/td/div/span[2]
${NS_XPATH_INVENTORY_ITEM_HEIGHT}    //*[@id="tr_fg_fieldGroup7"]/td[3]/table/tbody/tr[3]/td/div/span[2]
${NS_XPATH_PO_PARTNER_PO_ID}    //*[@id="main_form"]/table/tbody/tr[1]/td/div[1]/div[4]/div[1]
# Item Service
${NS_ITEM_SERVICE}        Service for Sale
${NS_XPATH_ITEM_SERVICE_TYPE}    //*[@id="main_form"]/table/tbody/tr[1]/td/div[1]/div[3]/h1
${NS_XPATH_ITEM_SERVICE_INTERNAL_ID}     //*[@id="tr_fg_fieldGroup67"]/td[1]/table/tbody/tr[2]/td/div/span[2]
${NS_XPATH_ITEM_SERVICE_EXTERNAL_ID}     //*[@id="tr_fg_fieldGroup67"]/td[1]/table/tbody/tr[3]/td/div/span[2]
${NS_XPATH_ITEM_SERVICE_EXTERNAL_ID_C}   //*[@id="tr_fg_fieldGroup67"]/td[1]/table/tbody/tr[4]/td/div/span[2]
${NS_XPATH_ITEM_SERVICE_PARTNER_ID}   //*[@id="tr_fg_fieldGroup67"]/td[1]/table/tbody/tr[5]/td/div/span[2]
# ${NS_XPATH_ITEM_SERVICE_UPC}        //*[@id="tr_fg_fieldGroup67"]/td[2]/table/tbody/tr[1]/td/div/span[2]
${NS_XPATH_ITEM_SERVICE_PRODUCT_TITLE}   //*[@id="tr_fg_fieldGroup68"]/td[1]/table/tbody/tr[2]/td/div/span[2]
# Item Discount
${NS_ITEM_DISCOUNT}        Discount for Sale
${NS_XPATH_ITEM_DISCOUNT_TYPE}            //*[@id="main_form"]/table/tbody/tr[1]/td/div[1]/div[3]/h1
${NS_XPATH_ITEM_DISCOUNT_ITEM_NAME}       //*[@id="tr_fg_fieldGroup83"]/td[1]/table/tbody/tr[1]/td/div/span[2]
${NS_XPATH_ITEM_DISCOUNT_DISPLAY_NAME}    //*[@id="tr_fg_fieldGroup83"]/td[2]/table/tbody/tr[1]/td/div/span[2]
${NS_XPATH_ITEM_DISCOUNT_DESCRIPTION}     //*[@id="tr_fg_fieldGroup83"]/td[3]/table/tbody/tr/td/div/span[2]
${NS_XPATH_ITEM_DISCOUNT_UPC}             //*[@id="tr_fg_fieldGroup83"]/td[1]/table/tbody/tr[3]/td/div/span[2]

*** Keywords ***
# Set Chrome Options
#     [Documentation]    Set Chrome options for headless mode
#     ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
#     : FOR    ${option}    IN    @{chrome_arguments}
#     \    Call Method    ${options}    add_argument    ${option}
#     [Return]    ${options}

Login to NS
    ${chrome_options}=    Set Chrome Options
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Go To    ${NS_URL}
    Maximize Browser Window
    Sleep    3s
    Input text    ${NS_XPATH_USERNAME}    ${USERNAME_NS}
    Input password    ${NS_XPATH_PASSWORD}    ${PASSWORD_NS}
    Click element    ${NS_XPATH_LOGIN_SUBMIT}
    Sleep    3s
    ${question}=    Get Text    ${NS_XPATH_QUESTION}
    Run Keyword If    "${question }"=="What is the middle name of your oldest child?"    Input password    ${NS_XPATH_ANSWER}    child1234
    Run Keyword If    "${question }"=="Who is your favorite ancient historical figure?"    Input password    ${NS_XPATH_ANSWER}    figure1234
    Run Keyword If    "${question }"== "In what city did you meet your spouse/significant other?"    Input password    ${NS_XPATH_ANSWER}    other1234
    Run Keyword If    "${question }"== "What is your oldest sibling's middle name?"    Input password    ${NS_XPATH_ANSWER}    name1234
    Run Keyword If    "${question }"== "In what city or town was your first job?"    Input password    ${NS_XPATH_ANSWER}    job1234
    Run Keyword If    "${question }"=="What was your childhood nickname?"    Input password    ${NS_XPATH_ANSWER}    nickname1234
    Click element    ${NS_XPATH_ANSWER_SUBMIT}
    Sleep    3s

Verify Item on NS
    [Arguments]    ${partner_id}  ${partnerItemId_General}   ${description}
    Login to NS
    Input Text    ${NS_XPATH_SEARCH_STRING}    ${partnerItemId_General}
    Press Key    ${NS_XPATH_SEARCH_STRING}    \\13
    Sleep    3s
    Wait Until Page Contains Element    ${NS_XPATH_SEARCH_RESULT}
    Click Element    ${NS_XPATH_SEARCH_RESULT}
    Sleep    10s
    Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_EXTERNAL_ID}      ${partnerItemId_General}
    Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_EXTERNAL_ID_C}    ${partnerItemId_General}
    Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_PARTNER_ID}       ${partner_id}
    Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_PRODUCT_TITLE}    ${description}

# Search partner item id and verify
#     [Arguments]    ${partner_item_id}    ${prefix}    ${partner_id}    ${upc}    ${description}    ${fulfillment_pattern}
#     ...    ${storage_req}    ${weight}    ${length}    ${width}    ${height}
#     Input Text    ${NS_XPATH_SEARCH_STRING}    ${partner_item_id}
#     Press Key    ${NS_XPATH_SEARCH_STRING}    \\13
#     Sleep    ${SLEEP_3_S}
#     Wait Until Page Contains Element Override    ${NS_XPATH_SEARCH_RESULT}
#     Click Element    ${NS_XPATH_SEARCH_RESULT}
#     Sleep    ${SLEEP_3_S}
#     Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_NAME}    ${prefix}_${partner_item_id}
#     Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_EXTERNAL_ID}    ${partner_item_id}
#     Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_EXTERNAL_ID_C}    ${partner_item_id}
#     Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_PARTNER_ID}    ${partner_id}
#     Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_UPC}    ${upc}
#     Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_PRODUCT_TITLE}    ${description}
#     Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_FULFILLMENT_PATTERN}    ${fulfillment_pattern}
#     Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_STORAGE_REQ}    ${storage_req}
#     Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_WEIGHT}    ${weight}
#     Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_LENGTH}    ${length}
#     Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_WIDTH}    ${width}
#     Element Text Should Be    ${NS_XPATH_INVENTORY_ITEM_HEIGHT}    ${height}

# Verify Item Discount on NS
#     [Arguments]    ${partner_id}  ${partner_item_id}  ${description}
#     #####    Verify Created Item on NS
#     Login to NS
#     Input Text    ${NS_XPATH_SEARCH_STRING}    ${partner_item_id}
#     Press Key    ${NS_XPATH_SEARCH_STRING}    \\13
#     Sleep    ${SLEEP_3_S}
#     Wait Until Page Contains Element Override    ${NS_XPATH_SEARCH_RESULT}
#     Click Element    ${NS_XPATH_SEARCH_RESULT}
#     Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${NS_XPATH_ITEM_DISCOUNT_TYPE}  ${NS_ITEM_DISCOUNT}
#     Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${NS_XPATH_ITEM_DISCOUNT_ITEM_NAME}        ${PARTNER_PREFIX_NS_6}_${partner_item_id}
#     # Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${NS_XPATH_ITEM_DISCOUNT_DISPLAY_NAME}     ${partner_item_id}
#     # Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${NS_XPATH_ITEM_DISCOUNT_DESCRIPTION}      ${description}
#     # Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${NS_XPATH_ITEM_DISCOUNT_UPC}              ${partner_id}

# Verify Item Service on NS
#     [Arguments]    ${partner_id}  ${partner_item_id}  ${description}
#     #####    Verify Created Item on NS
#     Login to NS
#     Input Text    ${NS_XPATH_SEARCH_STRING}    ${partner_item_id}
#     Press Key    ${NS_XPATH_SEARCH_STRING}    \\13
#     Sleep    ${SLEEP_3_S}
#     Wait Until Page Contains Element Override    ${NS_XPATH_SEARCH_RESULT}
#     Click Element    ${NS_XPATH_SEARCH_RESULT}
#     Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${NS_XPATH_ITEM_SERVICE_TYPE}   ${NS_ITEM_SERVICE}
#     Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${NS_XPATH_ITEM_SERVICE_INTERNAL_ID}    ${PARTNER_PREFIX_NS_6}_${partner_item_id}
#     Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${NS_XPATH_ITEM_SERVICE_EXTERNAL_ID}    ${partner_item_id}
#     Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${NS_XPATH_ITEM_SERVICE_EXTERNAL_ID_C}  ${partner_item_id}
#     Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${NS_XPATH_ITEM_SERVICE_PRODUCT_TITLE}    ${description}
