*** Settings ***
Test Teardown     Teardown item master method
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
BEEH-1124 [ITEM-PROD] Add created date and Updated date on API Response
    #####    Check Item services response    #####
    ${R_PATH_ITEM_SERVICES}    Replace String    ${R_PATH_ITEM_SERVICES}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_PATH_ITEM_DISCOUNTS}    Replace String    ${R_PATH_ITEM_DISCOUNTS}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    open browser    http://${R_ENDPOINT_ITEM}${R_PATH_ITEM_SERVICES}    chrome
    Maximize Browser Window
    sleep    ${R_SLEEP_2_S}
    Page Should Contain    createdDate
    Page Should Contain    updatedDate
    #####    Check Item discounts response    #####
    open browser    http://${R_ENDPOINT_ITEM}${R_PATH_ITEM_DISCOUNTS}    chrome
    Maximize Browser Window
    sleep    ${R_SLEEP_2_S}
    Page Should Contain    createdDate
    Page Should Contain    updatedDate

BEEH-1153 [ITEM] Duplicate error message_01_no_require_field
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_MANDA_AND_NO_REQUIRE_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION    Test by automation script
    log    ${request_body}
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    ${R_ERROR_MSG_UI_REQ_FIELD_IS_MISSING}    ${R_ERROR_MSG_UI_REQ_FIELD_IS_MISSING}   ${R_USERNAME_ADMIN_PORTAL}

BEEH-1153 [ITEM] Duplicate error message_02_with_require_field_but_no_value
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_MANDA_AND_REQUIRE_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_UOM    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_PRICES    ${EMPTY}
    log    ${request_body}
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_REQ_FIELD_CANNOT_BE_NULL}   ${R_USERNAME_ADMIN_PORTAL}

BEEH-1112 [PO-PROD] Can't import PO due to empty line in csv file_need_test_on_itemmaster_aswell
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_MANDA_AND_REQUIRE_FIELD_AND_EMPTY_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION    Test by automation script
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_UOM    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_PRICES    ${EMPTY}
    log    ${request_body}
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Failed    ${R_ERROR_MSG_UI_FILE_CONTAINS_LINE_EMPTY}    ${R_ERROR_MSG_UI_FILE_CONTAINS_LINE_EMPTY}   ${R_USERNAME_ADMIN_PORTAL}

## Found Issue about : Failed to load HostKeys from C:\Windows\system32\config\systemprofile\.ssh\known_hosts
# BEEH-1383 Merge SFTP Poller with Files Importer so it's easier to maintain
#     #####    Set variable    #####
#     ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
#     ${partner_item_id}=    Set Variable    UI_${random}
#     ${request_body}=    Get File    ${R_TEMPLATE_ITEM_MANDA_AND_REQUIRE_FIELD_CSV}
#     ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID    ${partner_item_id}
#     ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION    Test by automation script
#     ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE    ${EMPTY}
#     ${request_body}    Replace String    ${request_body}    VAR_UOM    ${EMPTY}
#     ${request_body}    Replace String    ${request_body}    VAR_PRICES    ${EMPTY}
#     log    ${request_body}
#     Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
#     ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
#     ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
#     Put File From Local To Sftp Server    ${R_SFTP_HOST}    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${R_SFTP_USERNAME}    ${R_SFTP_PWD}    ${R_SFTP_ITEM_PATH_NS_6}
#     Sleep    ${R_SLEEP_6_M}
#     Login to admin    ${R_IMPORT_HIST_INVENTORY}
#     Wait Until Keyword Succeeds   2x   2s   Element Text Should Be    ${R_WE_IMPORT_HIST_ROW_1_COL_1}    Drop File
#     Wait Until Keyword Succeeds   2x   2s   Element Text Should Be    ${R_WE_IMPORT_HIST_ROW_1_COL_2_DIV_2}    create_${partner_item_id}.csv
#     Wait Until Keyword Succeeds   2x   2s   Element Text Should Be    ${R_WE_IMPORT_HIST_ROW_1_COL_3}    Has 1 line error.
#     Wait Until Keyword Succeeds   2x   2s   Element Text Should Be    ${R_WE_IMPORT_HIST_ROW_1_COL_6}    Drop File
#     Wait Until Keyword Succeeds   2x   2s   Element Text Should Be    ${R_WE_IMPORT_HIST_ROW_1_COL_7}    Failed
#     Click Element    ${R_WE_IMPORT_HIST_ROW_1_COL_2_DIV_2}
#     Sleep    ${R_SLEEP_2_S}
#     Verify import history detail    create_${partner_item_id}.csv    Failed    Has 1 line error.    ${R_ERROR_MSG_UI_REQ_FIELD_CANNOT_BE_NULL}    Drop File

BEEH-1944 [IMS] Internal API for returning ATS
    #####    Check availableToSell by item key   #####
    open browser    http://${R_ENDPOINT_INVENTORY}${R_PATH_ATS_GET_BY_ITEM_KEY}/4X7DCNL96HR9H03X4V58ZIE2F/    chrome
    Maximize Browser Window
    sleep    ${R_SLEEP_2_S}
    Page Should Contain    availableToSell
    #####    Check availableToSell by partner id   #####
    open browser    http://${R_ENDPOINT_INVENTORY}${R_PATH_ATS_GET_BY_PARTNER_ID}/3538/ats/    chrome
    Maximize Browser Window
    sleep    ${R_SLEEP_2_S}
    Page Should Contain    availableToSell
    [Teardown]    Close all browsers

BEEH-2028 [Item Master] The GOD's endpoint must be exposing RSP field
    open browser    http://${R_ENDPOINT_ITEM}${R_PATH_INTERNAL_RSP}/3880/item-master-query/?fields=itemId,partnerItemId,retailSellingPrice&item_keys=8LY3293WMUWZW6WO16UUA61L0    chrome
    Log    message
    Maximize Browser Window
    sleep    ${R_SLEEP_2_S}
    Page Should Contain    retailSellingPrice
    [Teardown]    Close all browsers

BEEH-2039 Make sure all items(includes Inventory, Discount and Service types) store the returned NetSuite Internal ID
    ${R_PATH_ITEM}    Replace String    ${R_PATH_ITEM}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    open browser    http://${R_ENDPOINT_ITEM}/im/partner/${R_PARTNER_ID_NS_6}/item-masters/    chrome
    Log    message
    Maximize Browser Window
    sleep    ${R_SLEEP_2_S}
    Page Should Contain    netsuiteInternalId
    [Teardown]    Close all browsers
