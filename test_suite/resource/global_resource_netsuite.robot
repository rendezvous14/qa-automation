*** Settings ***
Resource          global_resource_metadata.robot
Resource          All_global_library.robot
Resource          global_resource_selenium.robot

*** Variables ***
${R_USERNAME_NS}    ${CONFIG_USERNAME_NS}
${R_PASSWORD_NS}    ${CONFIG_PASSWORD_NS}
${R_NS_URL}       ${CONFIG_NS_URL}
${R_NS_XPATH_USERNAME}    //*[@id="userName"]
${R_NS_XPATH_PASSWORD}    //*[@id="password"]
${R_NS_XPATH_LOGIN_SUBMIT}    //*[@id="submitButton"]
${R_NS_XPATH_ANSWER}    //*[@id="null"]
${R_NS_XPATH_ANSWER_SUBMIT}    xpath=/html/body/form/table/tbody/tr[4]/td/input
${R_NS_XPATH_QUESTION}    xpath=/html/body/form/table/tbody/tr[3]/td/table/tbody/tr[2]/td[2]
${R_NS_XPATH_SEARCH_STRING}    id=_searchstring
${R_NS_XPATH_SEARCH_RESULT}    //*[@id="row0"]/td[1]/a[2]
# Item Master
${R_NS_XPATH_INVENTORY_ITEM_NAME}    //*[@id="tr_fg_fieldGroup6"]/td[1]/table/tbody/tr[2]/td/div/span[2]
${R_NS_XPATH_INVENTORY_ITEM_EXTERNAL_ID}    //*[@id="tr_fg_fieldGroup6"]/td[1]/table/tbody/tr[3]/td/div/span[2]
${R_NS_XPATH_INVENTORY_ITEM_EXTERNAL_ID_C}    //*[@id="tr_fg_fieldGroup6"]/td[1]/table/tbody/tr[4]/td/div/span[2]
${R_NS_XPATH_INVENTORY_ITEM_PARTNER_ID}    //*[@id="tr_fg_fieldGroup6"]/td[1]/table/tbody/tr[5]/td/div/span[2]
${R_NS_XPATH_INVENTORY_ITEM_UPC}    //*[@id="tr_fg_fieldGroup6"]/td[2]/table/tbody/tr[2]/td/div/span[2]
${R_NS_XPATH_INVENTORY_ITEM_PRODUCT_TITLE}    //*[@id="tr_fg_fieldGroup7"]/td[1]/table/tbody/tr[1]/td/div/span[2]
${R_NS_XPATH_INVENTORY_ITEM_FULFILLMENT_PATTERN}    //*[@id="tr_fg_fieldGroup7"]/td[2]/table/tbody/tr[1]/td/div/span[2]/span
${R_NS_XPATH_INVENTORY_ITEM_STORAGE_REQ}    //*[@id="tr_fg_fieldGroup7"]/td[2]/table/tbody/tr[3]/td/div/span[2]/span
${R_NS_XPATH_INVENTORY_ITEM_WEIGHT}    //*[@id="tr_fg_fieldGroup7"]/td[2]/table/tbody/tr[4]/td/div/span[2]
${R_NS_XPATH_INVENTORY_ITEM_LENGTH}    //*[@id="tr_fg_fieldGroup7"]/td[3]/table/tbody/tr[1]/td/div/span[2]
${R_NS_XPATH_INVENTORY_ITEM_WIDTH}    //*[@id="tr_fg_fieldGroup7"]/td[3]/table/tbody/tr[2]/td/div/span[2]
${R_NS_XPATH_INVENTORY_ITEM_HEIGHT}    //*[@id="tr_fg_fieldGroup7"]/td[3]/table/tbody/tr[3]/td/div/span[2]
${R_NS_XPATH_PO_PARTNER_PO_ID}    //*[@id="main_form"]/table/tbody/tr[1]/td/div[1]/div[4]/div[1]
# Item Service
${R_NS_ITEM_SERVICE}        Service for Sale
${R_NS_XPATH_ITEM_SERVICE_TYPE}    //*[@id="main_form"]/table/tbody/tr[1]/td/div[1]/div[3]/h1
${R_NS_XPATH_ITEM_SERVICE_INTERNAL_ID}     //*[@id="tr_fg_fieldGroup67"]/td[1]/table/tbody/tr[2]/td/div/span[2]
${R_NS_XPATH_ITEM_SERVICE_EXTERNAL_ID}     //*[@id="tr_fg_fieldGroup67"]/td[1]/table/tbody/tr[3]/td/div/span[2]
${R_NS_XPATH_ITEM_SERVICE_EXTERNAL_ID_C}   //*[@id="tr_fg_fieldGroup67"]/td[1]/table/tbody/tr[4]/td/div/span[2]
${R_NS_XPATH_ITEM_SERVICE_PARTNER_ID}   //*[@id="tr_fg_fieldGroup67"]/td[1]/table/tbody/tr[5]/td/div/span[2]
# ${R_NS_XPATH_ITEM_SERVICE_UPC}        //*[@id="tr_fg_fieldGroup67"]/td[2]/table/tbody/tr[1]/td/div/span[2]
${R_NS_XPATH_ITEM_SERVICE_PRODUCT_TITLE}   //*[@id="tr_fg_fieldGroup68"]/td[1]/table/tbody/tr[2]/td/div/span[2]
# Item Discount
${R_NS_ITEM_DISCOUNT}        Discount for Sale
${R_NS_XPATH_ITEM_DISCOUNT_TYPE}            //*[@id="main_form"]/table/tbody/tr[1]/td/div[1]/div[3]/h1
${R_NS_XPATH_ITEM_DISCOUNT_ITEM_NAME}       //*[@id="tr_fg_fieldGroup83"]/td[1]/table/tbody/tr[1]/td/div/span[2]
${R_NS_XPATH_ITEM_DISCOUNT_DISPLAY_NAME}    //*[@id="tr_fg_fieldGroup83"]/td[2]/table/tbody/tr[1]/td/div/span[2]
${R_NS_XPATH_ITEM_DISCOUNT_DESCRIPTION}     //*[@id="tr_fg_fieldGroup83"]/td[3]/table/tbody/tr/td/div/span[2]
${R_NS_XPATH_ITEM_DISCOUNT_UPC}             //*[@id="tr_fg_fieldGroup83"]/td[1]/table/tbody/tr[3]/td/div/span[2]


*** Keywords ***
Login to NS
    Comment    Open browser    ${R_NS_URL}    gc
    Set open browser    ${R_NS_URL}
    Maximize Browser Window
    Sleep    ${R_SLEEP_3_S}
    Input text    ${R_NS_XPATH_USERNAME}    ${R_USERNAME_NS}
    Input password    ${R_NS_XPATH_PASSWORD}    ${R_PASSWORD_NS}
    Click element    ${R_NS_XPATH_LOGIN_SUBMIT}
    Sleep    ${R_SLEEP_3_S}
    ${question}=    Get Text    ${R_NS_XPATH_QUESTION}
    Run Keyword If    "${question }"=="What is the middle name of your oldest child?"    Input password    ${R_NS_XPATH_ANSWER}    child1234
    Run Keyword If    "${question }"=="Who is your favorite ancient historical figure?"    Input password    ${R_NS_XPATH_ANSWER}    figure1234
    Run Keyword If    "${question }"== "In what city did you meet your spouse/significant other?"    Input password    ${R_NS_XPATH_ANSWER}    other1234
    Run Keyword If    "${question }"== "What is your oldest sibling's middle name?"    Input password    ${R_NS_XPATH_ANSWER}    name1234
    Run Keyword If    "${question }"== "In what city or town was your first job?"    Input password    ${R_NS_XPATH_ANSWER}    job1234
    Run Keyword If    "${question }"=="What was your childhood nickname?"    Input password    ${R_NS_XPATH_ANSWER}    nickname1234
    Click element    ${R_NS_XPATH_ANSWER_SUBMIT}
    Sleep    ${R_SLEEP_3_S}

Search partner item id and verify
    [Arguments]    ${partner_item_id}    ${prefix}    ${partner_id}    ${upc}    ${description}    ${fulfillment_pattern}
    ...    ${storage_req}    ${weight}    ${length}    ${width}    ${height}
    Input Text    ${R_NS_XPATH_SEARCH_STRING}    ${partner_item_id}
    Press Key    ${R_NS_XPATH_SEARCH_STRING}    \\13
    Sleep    ${R_SLEEP_3_S}
    Wait Until Page Contains Element Override    ${R_NS_XPATH_SEARCH_RESULT}
    Click Element    ${R_NS_XPATH_SEARCH_RESULT}
    Sleep    ${R_SLEEP_3_S}
    Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_NAME}    ${prefix}_${partner_item_id}
    Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_EXTERNAL_ID}    ${partner_item_id}
    Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_EXTERNAL_ID_C}    ${partner_item_id}
    Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_PARTNER_ID}    ${partner_id}
    Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_UPC}    ${upc}
    Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_PRODUCT_TITLE}    ${description}
    Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_FULFILLMENT_PATTERN}    ${fulfillment_pattern}
    Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_STORAGE_REQ}    ${storage_req}
    Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_WEIGHT}    ${weight}
    Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_LENGTH}    ${length}
    Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_WIDTH}    ${width}
    Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_HEIGHT}    ${height}

Verify Item Discount on NS
    [Arguments]    ${partner_id}  ${partner_item_id}  ${description}
    #####    Verify Created Item on NS
    Login to NS
    Input Text    ${R_NS_XPATH_SEARCH_STRING}    ${partner_item_id}
    Press Key    ${R_NS_XPATH_SEARCH_STRING}    \\13
    Sleep    ${R_SLEEP_3_S}
    Wait Until Page Contains Element Override    ${R_NS_XPATH_SEARCH_RESULT}
    Click Element    ${R_NS_XPATH_SEARCH_RESULT}
    Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${R_NS_XPATH_ITEM_DISCOUNT_TYPE}  ${R_NS_ITEM_DISCOUNT}
    Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${R_NS_XPATH_ITEM_DISCOUNT_ITEM_NAME}        ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}
    # Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${R_NS_XPATH_ITEM_DISCOUNT_DISPLAY_NAME}     ${partner_item_id}
    # Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${R_NS_XPATH_ITEM_DISCOUNT_DESCRIPTION}      ${description}
    # Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${R_NS_XPATH_ITEM_DISCOUNT_UPC}              ${partner_id}

Verify Item Service on NS
    [Arguments]    ${partner_id}  ${partner_item_id}  ${description}
    #####    Verify Created Item on NS
    Login to NS
    Input Text    ${R_NS_XPATH_SEARCH_STRING}    ${partner_item_id}
    Press Key    ${R_NS_XPATH_SEARCH_STRING}    \\13
    Sleep    ${R_SLEEP_3_S}
    Wait Until Page Contains Element Override    ${R_NS_XPATH_SEARCH_RESULT}
    Click Element    ${R_NS_XPATH_SEARCH_RESULT}
    Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${R_NS_XPATH_ITEM_SERVICE_TYPE}   ${R_NS_ITEM_SERVICE}
    Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${R_NS_XPATH_ITEM_SERVICE_INTERNAL_ID}    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}
    Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${R_NS_XPATH_ITEM_SERVICE_EXTERNAL_ID}    ${partner_item_id}
    Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${R_NS_XPATH_ITEM_SERVICE_EXTERNAL_ID_C}  ${partner_item_id}
    Wait Until Keyword Succeeds   3x   5s   Element Text Should Be    ${R_NS_XPATH_ITEM_SERVICE_PRODUCT_TITLE}    ${description}
