*** Settings ***
Suite Setup       Prepare item mock data
Test Teardown     Teardown item master method
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
ITEM_API_001_[partnerItemId] length not over 50 characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_POST}
    Sleep    ${R_SLEEP_10_S}
    #####    Check item on portal    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Login to admin    ${R_INVENTORY_LIST}
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    Test by automation script    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    APP_${R_USER_NAME_API}    7.80005    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB
    Login to NS
    Input Text    ${R_NS_XPATH_SEARCH_STRING}    ${partner_item_id}
    Press Key    ${R_NS_XPATH_SEARCH_STRING}    \\13
    Sleep    ${R_SLEEP_3_S}
    Wait Until Page Contains Element Override    ${R_NS_XPATH_SEARCH_RESULT}
    Click Element    ${R_NS_XPATH_SEARCH_RESULT}
    Sleep    ${R_SLEEP_3_S}
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_NAME}    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_EXTERNAL_ID}    ${partner_item_id}
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_EXTERNAL_ID_C}    ${partner_item_id}
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_PARTNER_ID}    ${R_PARTNER_ID_NS_6}
    # Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_UPC}    UPC_${random}
    # Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_PRODUCT_TITLE}    Test by automation script
    # Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_FULFILLMENT_PATTERN}    FIFO
    # Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_STORAGE_REQ}    Cool_Room
    # Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_WEIGHT}    4.70005
    # Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_LENGTH}    5.60005
    # Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_WIDTH}    7.80005
    # Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_NS_XPATH_INVENTORY_ITEM_HEIGHT}    3.50005

ITEM_API_002_[partnerItemId] length over 50 characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}_12345678901234567890123456789012345678901234567890
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_PARTNER_ITEM_ID_CANNOT_EXCEED}
    ${remove_file}    Set Variable    ${None}

ITEM_API_003_[partnerItemId] input special characters
    #####    Set variable #1    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id_1}=    Set Variable    API_${random}_[TEST]
    #####    Set request body #1    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body_except_item_id}=    Set Variable    ${request_body}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id_1}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request #1    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Sleep    ${R_SLEEP_1_S}
    #####    Set variable #2    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id_2}=    Set Variable    [API_${random}_TEST]
    #####    Set request body #2    #####
    ${REQUEST_BODY_2}    Replace String    ${request_body_except_item_id}    VAR_PARTNER_ITEM_ID    ${partner_item_id_2}
    #####    Send Http request #2    #####
    ${response}=    Create_item    ${REQUEST_BODY_2}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_004_[partnerItemId] input other language ex. TH
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}_เทสโดยคิวเอ
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_005_[partnerItemId] input empty string
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    ${EMPTY}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_PARTNER_ITEM_ID_CANNOT_NULL}

ITEM_API_006_[partnerItemId] delete partnerItemId field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}=    Remove String Using Regexp    ${request_body}    "partnerItemId":"VAR_PARTNER_ITEM_ID",
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_PARTNER_ITEM_ID_CANNOT_NULL}

ITEM_API_007_[partnerItemId] input space bar
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API${SPACE}${random}
    ${partner_item_id_space_at_last}=    Set Variable    API_${random}_${SPACE}
    ${partner_item_id_space_at_first}=    Set Variable    ${SPACE}_API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body_except_partner_item_id}=    Set Variable    ${request_body}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${request_body_except_partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id_space_at_last}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${request_body_except_partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id_space_at_first}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

XXX_ITEM_API_008_[upcCode] length over 10 array of string
    [Documentation]    upcCode will be discussed later.
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    Prepare item mock data    ${R_TEMPLATE_ITEM_OVER_UPC}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE1    UPC_${random}_1
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE2    UPC_${random}_2
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE3    UPC_${random}_3
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE4    UPC_${random}_4
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE5    UPC_${random}_5
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE6    UPC_${random}_6
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE7    UPC_${random}_7
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE8    UPC_${random}_8
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE9    UPC_${random}_9
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE10    UPC_${random}_10
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE11    UPC_${random}_11
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_UPC_CANNOT_OVER_TEN}

XXX_ITEM_API_009_[upcCode] delete field
    [Documentation]    upcCode will be discussed later.
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    Prepare item mock data
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${request_body}=    Remove String Using Regexp    ${request_body}    "upcCode":["VAR_UPC_CODE"],
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

XXX_ITEM_API_010_[upcCode] input empty string
    [Documentation]    upcCode will be discussed later.
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "upcCode":["VAR_UPC_CODE"],    "upcCode":[],
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

XXX_ITEM_API_011_[upcCode] length not over 180 char
    [Documentation]    upcCode will be discussed later.
    #####    Set variable #1    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body #1    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}_1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request #1    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}   ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

XXX_ITEM_API_012_[upcCode] length over 180 char
    [Documentation]    upcCode will be discussed later.
    #####    Set variable #1    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body #1    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}_12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request #1    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_UPC_CANNOT_EXCEED_25_CHAR}

XXX_ITEM_API_013_[upcCode] input spacial char in array of string
    [Documentation]    upcCode will be discussed later.
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}_[TEST]
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

XXX_ITEM_API_014_[upcCode] updated not over 10 array of string
    [Documentation]    upcCode will be discussed later.
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}_1
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    #####    Set request body for update    #####
    Sleep    ${R_SLEEP_10_S}
    ${request_body}    Replace String    ${request_body}    UPC_${random}_1    UPC_${random}_2
    ${request_body}    Replace String    ${request_body}    "action": "create",    "action": "update",
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

XXX_ITEM_API_015_[upcCode] updated over 10 array of string
    [Documentation]    upcCode will be discussed later.
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    #####    Set request body for update    #####
    Sleep    ${R_SLEEP_10_S}
    Prepare item mock data    ${R_TEMPLATE_ITEM_OVER_UPC}
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE1    UPC_${random}_1
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE2    UPC_${random}_2
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE3    UPC_${random}_3
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE4    UPC_${random}_4
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE5    UPC_${random}_5
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE6    UPC_${random}_6
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE7    UPC_${random}_7
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE8    UPC_${random}_8
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE9    UPC_${random}_9
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE10    UPC_${random}_10
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE11    UPC_${random}_11
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    "action": "create",    "action": "update",
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_UPC_CANNOT_OVER_TEN_UPDATE}

ITEM_API_016_[description] length not over 255 Characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    Prepare item mock data
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    Test by automation script    Test by automation script_1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_017_[description] length over 255 Characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    Test by automation script    Test by automation script_12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_DESC_CANNOT_EXCEED_255_CHAR}

ITEM_API_018_[description] input special characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    Test by automation script    Test by automation script [TEST]
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_019_[description] input other language ex. TH
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    Test by automation script    เทสสร้างโดยสคริป
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_020_[description] input other language ex. Chinese
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    Test by automation script    圆领，凸显脖子的线条美，显得精神有气质。灯笼袖的造型，上身舒适不紧绷。耀眼的银色钉珠扣袢，吸睛耀眼。
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_021_[description] input other language ex. Japanese
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    Test by automation script    特別割引コードはチラシ裏の下部に記載があります。
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_022_[description] input other language ex. Korean
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    Test by automation script    델리모먼트 드레싱 디퓨저
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_023_[description] input data type Numeric
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "description":"Test by automation script",    "description":12345,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_024_[description] input empty string
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    Test by automation script    ${EMPTY}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_DESC_IS_REQUIRED}

ITEM_API_025_[description] delete field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}=    Remove String Using Regexp    ${request_body}    "description":"Test by automation script",
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_DESC_IS_REQUIRED}

ITEM_API_026_[width] input over decimal(7,5)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "width":7.80005,    "width":12345678.80005,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_WIDTH_LENGTH}

ITEM_API_027_[width] input characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "width":7.80005,    "width":"ten",
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_WIDTH_LENGTH}

ITEM_API_028_[width] negative value
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "width":7.80005,    "width":-7.80005,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_WIDTH_CANNOT_SET_NEGATIVE}

ITEM_API_029_[width] can updated width
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    #####    Set request body for update    #####
    Sleep    ${R_SLEEP_10_S}
    ${request_body}    Replace String    ${request_body}    "width":7.80005,    "width":7.99995,
    ${request_body}    Replace String    ${request_body}    "action": "create",    "action": "update",
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    #####    Check item on portal    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Login to admin    ${R_INVENTORY_LIST}
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    Test by automation script    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    APP_${R_USER_NAME_API}    7.99995    3.50005    5.60005    4.70005    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB

ITEM_API_030_[length] input over decimal(7,5)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "length":5.60005,    "length":12345678.60005,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_LENGTH_LENGTH}

ITEM_API_031_[length] input characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "length":5.60005,    "length":"ten",
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_LENGTH_LENGTH}

ITEM_API_032_[length] negative value
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "length":5.60005,    "length":-5.60005,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_LENGTH_CANNOT_SET_NEGATIVE}

ITEM_API_033_[length] can updated length
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_034_[weight] input over decimal(7,5)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "weight":4.70005,    "weight":12345678.70005,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_WEIGHT_LENGTH}

ITEM_API_035_[weight] input characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "weight":4.70005,    "weight":"ten",
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_WEIGHT_LENGTH}

ITEM_API_036_[weight] negative value
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "weight":4.70005,    "weight":-4.70005,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_WEIGHT_CANNOT_SET_NEGATIVE}

ITEM_API_037_[weight] can updated weight
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    #####    Set request body for update    #####
    Sleep    ${R_SLEEP_10_S}
    ${request_body}    Replace String    ${request_body}    "weight":4.70005,    "weight":4.99995,
    ${request_body}    Replace String    ${request_body}    "action": "create",    "action": "update",
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    #####    Check item on portal    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Login to admin    ${R_INVENTORY_LIST}
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Wait Until Keyword Succeeds    3x    5s   Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_DESC}
    Verify inventory detail    Test by automation script    ${R_PARTNER_PREFIX_NS_6}_${partner_item_id}    ${R_PARTNER_NAME_NS_6}    ${partner_item_id}    ${EMPTY}    ${EMPTY}
    ...    APP_${R_USER_NAME_API}    7.80005    3.50005    5.60005    4.99995    Cool Room
    ...    FIFO    EA    5.00000 %    UPC_${random}    Test item group    98.00 THB
    Click Element    ${R_WE_INV_DETAIL_ITEM_PRICE_TAB}
    Verify inventory detail item price tab    ${R_SUPPLIER_NS_6}    ${R_SUPPLIER_NS_6}    50.25    THB

ITEM_API_038_[height] input over decimal(7,5)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "height":3.50005,    "height":12345678.50005,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_HEIGHT_LENGTH}

ITEM_API_039_[height] input characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "height":3.50005,    "height":"ten",
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_HEIGHT_LENGTH}

ITEM_API_040_[height] negative value
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "height":3.50005,    "height":-3.50005,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should Contain    ${response}    ${R_ERROR_MSG_HEIGHT_CANNOT_SET_NEGATIVE}

ITEM_API_041_[storageRequirement] input incorrect data(Cool_RoomX)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "storageRequirement":"Cool_Room",    "storageRequirement":"Cool_RoomX",
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_STORAGE_REQUIREMENT_INVALID_1}

ITEM_API_042_[storageRequirement] input incorrect data (Number)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "storageRequirement":"Cool_Room",    "storageRequirement":12345,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_STORAGE_REQUIREMENT_INVALID_2}

ITEM_API_043_[storageRequirement] input blank field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "storageRequirement":"Cool_Room",    "storageRequirement":"",
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_044_[fulfillmentPattern] input incorrect data(LILO)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "fulfillmentPattern":"FIFO",    "fulfillmentPattern":"LILO",
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_FULFILLMENT_PATTERN_INVALID_1}

ITEM_API_045_[fulfillmentPattern] input incorrect data (Number)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "fulfillmentPattern":"FIFO",    "fulfillmentPattern":12345,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_FULFILLMENT_PATTERN_INVALID_2}

ITEM_API_046_[fulfillmentPattern] input blank field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "fulfillmentPattern":"FIFO",    "fulfillmentPattern":"",
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_047_[qcInformation] input over length (100.55)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "qcInformation":"5",    "qcInformation":"100.55",
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_QC_CANNOT_EXCEED_100}

ITEM_API_048_[qcInformation] input characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "qcInformation":"5",    "qcInformation":"ten",
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_QC_LENGTH}

ITEM_API_049_[qcInformation] negative value
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "qcInformation":"5",    "qcInformation":"-15",
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_QC_CANNOT_SET_NEGATIVE}

ITEM_API_050_[isSerialTracked] delete field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}=    Remove String Using Regexp    ${request_body}    "isSerialTracked": true,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_051_[isSerialTracked] input false
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "isSerialTracked": true,    "isSerialTracked": false,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_052_[isSerialTracked] input other word (No Boolean) : No, Yes
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "isSerialTracked": true,    "isSerialTracked": Yes,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_053_[isBatchTracked] delete field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}=    Remove String Using Regexp    ${request_body}    "isBatchTracked" :true,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_054_[isBatchTracked] input false
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "isBatchTracked" :true,    "isBatchTracked" :false,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_055_[active] delete field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "retailSellingPrice":98,    "retailSellingPrice":98
    ${request_body}=    Remove String Using Regexp    ${request_body}    "active": true
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_056_[active] input other word (No Boolean) : No, Yes
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "active": true    "active": Yes
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_057_[price] input over length (9 digits)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "price": 50.25,    "price": 123456789.12345,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_PRICES_CANNOT_EXCEED}

ITEM_API_058_[price] input characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "price": 50.25,    "price": "ten",
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_PRICES_CANNOT_SET_INVALID}

ITEM_API_059_[price] negative value
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "price": 50.25,    "price": -50.25,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_PRICES_CANNOT_SET_INVALID}

ITEM_API_060_[supplierCode] input empty string
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    #####    Fail because set supplierCode is required field    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_SUPPLIER_DOES_NOT_EXIST}

ITEM_API_061_[supplierCode] deleted field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}=    Remove String Using Regexp    ${request_body}    "supplierCode": "VAR_SUPPLIER_CODE"
    ${request_body}    Remove String Using Regexp    ${request_body}    "supplierKey": "${R_SUPPLIER_NS_6_KEY}",
    ${request_body}    Replace String    ${request_body}    "preferred": true,    "preferred": true
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_SUPPLIER_KEY_REQUIRED_FOR_PRICE}

ITEM_API_062_[preferred] delete_field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}=    Remove String Using Regexp    ${request_body}    "preferred": true,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_063_[preferred] input false
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "preferred": true,    "preferred": false,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_064_[preferred] input other word (No Boolean) : No, Yes
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    "preferred": true,    "preferred": Yes,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_065_[itemGroup] length not over 25 Characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    Prepare item mock data
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    Test item group    Test item group_123456789
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_066_[itemGroup] length over 25 Characters
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    Prepare item mock data
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    Test item group    Test item group_1234567890
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_ITEM_GROUP_CANNOT_EXCEED_25_CHAR}

ITEM_API_067_[itemGroup] delete field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    Prepare item mock data
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Remove String    ${request_body}    "itemGroup":"Test item group",
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}

ITEM_API_068_[retailSellingPrice] input over length
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    Prepare item mock data
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body_before_edit_rsp}=    Set Variable    ${request_body}
    ${request_body}    Replace String    ${request_body}    "retailSellingPrice":98,    "retailSellingPrice":9800000.500005,
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_RSP_LENGTH_DECIMAL}
    #####    Update retailSellingPrice    #####
    ${request_body}=    Set Variable    ${request_body_before_edit_rsp}
    ${request_body}    Replace String    ${request_body}    "retailSellingPrice":98,    "retailSellingPrice":980000000000000.50005,
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_RSP_LENGTH_DIGIT}
    #####    Update retailSellingPrice    #####
    ${request_body}=    Set Variable    ${request_body_before_edit_rsp}
    ${request_body}    Replace String    ${request_body}    "retailSellingPrice":98,    "retailSellingPrice":980000000000000.500005,
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}
    Should contain    ${response}    ${R_ERROR_MSG_RSP_LENGTH_DIGIT}

ITEM_API_069_[retailSellingPrice] delete field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    API_${random}
    #####    Set request body    #####
    Prepare item mock data
    ${request_body}=    Set Variable    ${G_REQUEST_BODY}
    ${request_body}    Remove String    ${request_body}    "retailSellingPrice":98,
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_KEY    ${R_SUPPLIER_NS_6_KEY}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    #####    Send Http request    #####
    ${response}=    Create_item    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${R_PATH_ITEM}    ${R_PARTNER_ID_NS_6}
    ...    ${R_X_ROLES_NS_6}    ${R_HTTP_POST}