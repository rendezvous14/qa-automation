*** Settings ***
Test Teardown     Teardown item master method
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
ITEM_SEARCH_001_[QuickSearch] search by partner item id, item key and item description
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    ${partner_item_id_fetch}=    Get Substring    UI_${random}    0    17
    #####    Set request body    #####
    ${request_body}=    Get File    ${R_TEMPLATE_ITEM_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script ${random}
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${random}
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_1    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_1    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_1    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_1    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Quick search exact by partner item id    #####
    Go To    ${R_INVENTORY_LIST}
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${partner_item_id}
    Wait Until Page Contains Element Override    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script ${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Element Text Should Be    ${R_WE_INV_LIST_SHOW_TOTAL_RESULT}    Showing 1 to 1 of 1 entries
    #####    Quick search like by partner item id    #####
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${partner_item_id_fetch}
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script ${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Element Text Should Be    ${R_WE_INV_LIST_SHOW_TOTAL_RESULT}    Showing 1 to 1 of 1 entries
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    ${url}=    Get Location
    ${item_key}=    Fetch From Right    ${url}    /
    #####    Quick search by item key    #####
    Go To    ${R_INVENTORY_LIST}
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${item_key}
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script ${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Element Text Should Be    ${R_WE_INV_LIST_SHOW_TOTAL_RESULT}    Showing 1 to 1 of 1 entries
    #####    Quick search by description    #####
    Go To    ${R_INVENTORY_LIST}
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    Test by automation script ${random}
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script ${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${random}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Element Text Should Be    ${R_WE_INV_LIST_SHOW_TOTAL_RESULT}    Showing 1 to 1 of 1 entries

ITEM_SEARCH_002_[QuickSearch] search by three partner item id, item key and item description
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body #1    #####
    ${request_body}=    Get File    ${R_TEMPLATE_THREE_ITEMS_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}_1
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script ${partner_item_id}_1
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${partner_item_id}_1
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_1    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_1    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_1    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_1    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    #####    Set request body #2    #####
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_2    ${partner_item_id}_2
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_2    Test by automation script ${partner_item_id}_2
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_2    UPC_${partner_item_id}_2
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_2    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_2    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_2    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_2    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_2    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_2    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_2    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_2    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_2    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_2    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_2    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_2    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_2    true
    #####    Set request body #3    #####
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_3    ${partner_item_id}_3
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_3    Test by automation script ${partner_item_id}_3
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_3    UPC_${partner_item_id}_3
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_3    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_3    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_3    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_3    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_3    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_3    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_3    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_3    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_3    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_3    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_3    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_3    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_3    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_3    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_3    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_3    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}_1_2_3.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}_1_2_3.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Quick search like by partner item id    #####
    Go To    ${R_INVENTORY_LIST}
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${partner_item_id}
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Page Should Contain    ${partner_item_id}_1
    Page Should Contain    Test by automation script ${partner_item_id}_1
    Page Should Contain    UPC_${partner_item_id}_1
    Page Should Contain    ${partner_item_id}_2
    Page Should Contain    Test by automation script ${partner_item_id}_2
    Page Should Contain    UPC_${partner_item_id}_2
    Page Should Contain    ${partner_item_id}_3
    Page Should Contain    Test by automation script ${partner_item_id}_3
    Page Should Contain    UPC_${partner_item_id}_3
    #####    Quick search exact by partner item id    #####
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${partner_item_id}_1
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script ${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    #####    Quick search like by description    #####
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    Test by automation script ${partner_item_id}
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Page Should Contain    ${partner_item_id}_1
    Page Should Contain    Test by automation script ${partner_item_id}_1
    Page Should Contain    UPC_${partner_item_id}_1
    Page Should Contain    ${partner_item_id}_2
    Page Should Contain    Test by automation script ${partner_item_id}_2
    Page Should Contain    UPC_${partner_item_id}_2
    Page Should Contain    ${partner_item_id}_3
    Page Should Contain    Test by automation script ${partner_item_id}_3
    Page Should Contain    UPC_${partner_item_id}_3
    #####    Quick search exact by description    #####
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    Test by automation script ${partner_item_id}_1
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script ${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    ${url}=    Get Location
    ${item_key}=    Fetch From Right    ${url}    /
    #####    Quick search exact by partner item id    #####
    Go To    ${R_INVENTORY_LIST}
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${partner_item_id}_2
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_2
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script ${partner_item_id}_2
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_2
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Element Text Should Be    ${R_WE_INV_LIST_SHOW_TOTAL_RESULT}    Showing 1 to 1 of 1 entries
    #####    Quick search exact by item key    #####
    Go To    ${R_INVENTORY_LIST}
    Input Text    ${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    ${item_key}
    Click Element    ${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script ${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    Element Text Should Be    ${R_WE_INV_LIST_SHOW_TOTAL_RESULT}    Showing 1 to 1 of 1 entries

ITEM_SEARCH_003_[AdvanceSearch] search by three partner item id, item key, item description, upc code, supplier and create/update date
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${date}=    Get Current Date    result_format=%Y-%m-%d
    ${partner_item_id}=    Set Variable    UI_${random}
    #####    Set request body #1    #####
    ${request_body}=    Get File    ${R_TEMPLATE_THREE_ITEMS_WITH_ALL_FIELD_CSV}
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_1    ${partner_item_id}_1
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_1    Test by automation script ${partner_item_id}_1
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_1    UPC_${partner_item_id}_1
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_1    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_1    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_1    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_1    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_1    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_1    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_1    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_1    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_1    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_1    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_1    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_1    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_1    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_1    true
    #####    Set request body #2    #####
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_2    ${partner_item_id}_2
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_2    Test by automation script ${partner_item_id}_2
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_2    UPC_${partner_item_id}_2
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_2    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_2    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_2    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_2    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_2    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_2    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_2    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_2    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_2    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_2    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_2    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_2    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_2    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_2    true
    #####    Set request body #3    #####
    ${request_body}    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID_3    ${partner_item_id}_3
    ${request_body}    Replace String    ${request_body}    VAR_DESCRIPTION_3    Test by automation script ${partner_item_id}_3
    ${request_body}    Replace String    ${request_body}    VAR_UPC_CODE_3    UPC_${partner_item_id}_3
    ${request_body}    Replace String    ${request_body}    VAR_SUPPLIER_CODE_3    ${R_SUPPLIER_NS_6}
    ${request_body}    Replace String    ${request_body}    VAR_UOM_3    EA
    ${request_body}    Replace String    ${request_body}    VAR_PRICES_3    50.25
    ${request_body}    Replace String    ${request_body}    VAR_WIDTH_3    7.80005
    ${request_body}    Replace String    ${request_body}    VAR_HEIGHT_3    3.50005
    ${request_body}    Replace String    ${request_body}    VAR_LENGTH_3    5.60005
    ${request_body}    Replace String    ${request_body}    VAR_WEIGHT_3    4.70005
    ${request_body}    Replace String    ${request_body}    VAR_STORAGE_REQUIREMENT_3    Cool_Room
    ${request_body}    Replace String    ${request_body}    VAR_FULFILLMENT_PATTERN_3    FIFO
    ${request_body}    Replace String    ${request_body}    VAR_IS_SERIAL_TRACKED_3    true
    ${request_body}    Replace String    ${request_body}    VAR_IS_BATCH_TRACKED_3    true
    ${request_body}    Replace String    ${request_body}    VAR_QC_INFORMATION_3    5
    ${request_body}    Replace String    ${request_body}    VAR_ITEM_GROUP_3    Test item group
    ${request_body}    Replace String    ${request_body}    VAR_RETAIL_SELLING_PRICE_3    98
    ${request_body}    Replace String    ${request_body}    VAR_PREFERRED_3    true
    ${request_body}    Replace String    ${request_body}    VAR_ACTIVE_3    true
    log    ${request_body}
    #####    Create csv file    #####
    Create File    ${R_TEST_DATA_ITEM_GENERATE}create_${partner_item_id}_1_2_3.csv    ${request_body}
    #####    Drop file and verify result    #####
    ${R_INVENTORY_LIST}    Replace String    ${R_INVENTORY_LIST}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${R_IMPORT_HIST_INVENTORY}    Replace String    ${R_IMPORT_HIST_INVENTORY}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    Drop file and verify import history    ${R_INVENTORY_LIST}    ${R_IMPORT_HIST_INVENTORY}    create_${partner_item_id}_1_2_3.csv    Completed    ${EMPTY}    ${EMPTY}
    #####    Adv search like by partner item id    #####
    Go To    ${R_INVENTORY_LIST}
    Wait Until Page Contains Element Override    ${R_WE_INV_LIST_ADV_SEARCH_BUTTON}
    Click Element    ${R_WE_INV_LIST_ADV_SEARCH_BUTTON}
    Input Text    ${R_WE_INV_LIST_ADV_SEARCH_PARTNER_ITEM_ID}    ${partner_item_id}
    Click Element    ${R_WE_INV_LIST_ADV_SEARCH_SUBMIT}
    Sleep    ${R_SLEEP_2_S}
    Page Should Contain    ${partner_item_id}_1
    Page Should Contain    Test by automation script ${partner_item_id}_1
    Page Should Contain    UPC_${partner_item_id}_1
    Page Should Contain    ${partner_item_id}_2
    Page Should Contain    Test by automation script ${partner_item_id}_2
    Page Should Contain    UPC_${partner_item_id}_2
    Page Should Contain    ${partner_item_id}_3
    Page Should Contain    Test by automation script ${partner_item_id}_3
    Page Should Contain    UPC_${partner_item_id}_3
    #####    Adv search exact by partner item id    #####
    Input Text    ${R_WE_INV_LIST_ADV_SEARCH_PARTNER_ITEM_ID}    ${partner_item_id}_1
    Click Element    ${R_WE_INV_LIST_ADV_SEARCH_SUBMIT}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script ${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    #####    Get item key    #####
    Click Element    ${R_WE_INV_LIST_ROW_1_COL_1}
    ${url}=    Get Location
    ${item_key}=    Fetch From Right    ${url}    /
    Go To    ${R_INVENTORY_LIST}
    Click Element    ${R_WE_INV_LIST_ADV_SEARCH_BUTTON}
    #####    Adv search exact by item key    #####
    Input Text    ${R_WE_INV_LIST_ADV_SEARCH_ITEM_KEY}    ${item_key}
    Click Element    ${R_WE_INV_LIST_ADV_SEARCH_SUBMIT}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script ${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_1
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    #####    Adv search like by description    #####
    Input Text    ${R_WE_INV_LIST_ADV_SEARCH_ITEM_KEY}    ${EMPTY}
    Input Text    ${R_WE_INV_LIST_ADV_SEARCH_DESC}    ${EMPTY}
    Click Element    ${R_WE_INV_LIST_ADV_SEARCH_SUBMIT}
    Sleep    ${R_SLEEP_2_S}
    Input Text    ${R_WE_INV_LIST_ADV_SEARCH_DESC}    Test by automation script ${partner_item_id}
    Click Element    ${R_WE_INV_LIST_ADV_SEARCH_SUBMIT}
    Sleep    ${R_SLEEP_2_S}
    Page Should Contain    ${partner_item_id}_1
    Page Should Contain    Test by automation script ${partner_item_id}_1
    Page Should Contain    UPC_${partner_item_id}_1
    Page Should Contain    ${partner_item_id}_2
    Page Should Contain    Test by automation script ${partner_item_id}_2
    Page Should Contain    UPC_${partner_item_id}_2
    Page Should Contain    ${partner_item_id}_3
    Page Should Contain    Test by automation script ${partner_item_id}_3
    Page Should Contain    UPC_${partner_item_id}_3
    #####    Adv search exact by upc code    #####
    Input Text    ${R_WE_INV_LIST_ADV_SEARCH_UPC}    UPC_${partner_item_id}_2
    Click Element    ${R_WE_INV_LIST_ADV_SEARCH_SUBMIT}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_2
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script ${partner_item_id}_2
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_2
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
    #####    Adv search like by upc code    #####
    Input Text    ${R_WE_INV_LIST_ADV_SEARCH_UPC}    UPC_${partner_item_id}
    Click Element    ${R_WE_INV_LIST_ADV_SEARCH_SUBMIT}
    Sleep    ${R_SLEEP_2_S}
    Page Should Contain    ${partner_item_id}_1
    Page Should Contain    Test by automation script ${partner_item_id}_1
    Page Should Contain    UPC_${partner_item_id}_1
    Page Should Contain    ${partner_item_id}_2
    Page Should Contain    Test by automation script ${partner_item_id}_2
    Page Should Contain    UPC_${partner_item_id}_2
    Page Should Contain    ${partner_item_id}_3
    Page Should Contain    Test by automation script ${partner_item_id}_3
    Page Should Contain    UPC_${partner_item_id}_3
    #####    Adv search by supplier code    #####
    Input Text    ${R_WE_INV_LIST_ADV_SEARCH_SUPPLIER}    ${R_SUPPLIER_NS_6}
    Click Element    ${R_WE_INV_LIST_ADV_SEARCH_SUBMIT}
    Sleep    ${R_SLEEP_2_S}
    Page Should Contain    ${partner_item_id}_1
    Page Should Contain    Test by automation script ${partner_item_id}_1
    Page Should Contain    UPC_${partner_item_id}_1
    Page Should Contain    ${partner_item_id}_2
    Page Should Contain    Test by automation script ${partner_item_id}_2
    Page Should Contain    UPC_${partner_item_id}_2
    Page Should Contain    ${partner_item_id}_3
    Page Should Contain    Test by automation script ${partner_item_id}_3
    Page Should Contain    UPC_${partner_item_id}_3
    #####    Adv search by specific only create date from    #####
    Input Text    ${R_WE_INV_LIST_ADV_SEARCH_PARTNER_ITEM_ID}    ${partner_item_id}_2
    Click Element    ${R_WE_INV_LIST_ADV_CREATED_DATE_FROM}
    Press Key    ${R_WE_INV_LIST_ADV_CREATED_DATE_FROM}    \\13
    Sleep    ${R_SLEEP_2_S}
    Click Element    ${R_WE_INV_LIST_ADV_CREATED_DATE_TO}
    Press Key    ${R_WE_INV_LIST_ADV_CREATED_DATE_TO}    \\13
    Sleep    ${R_SLEEP_2_S}
    Click Element    ${R_WE_INV_LIST_ADV_MODIFIED_DATE_FROM}
    Press Key    ${R_WE_INV_LIST_ADV_MODIFIED_DATE_FROM}    \\13
    Sleep    ${R_SLEEP_2_S}
    Click Element    ${R_WE_INV_LIST_ADV_MODIFIED_DATE_TO}
    Press Key    ${R_WE_INV_LIST_ADV_MODIFIED_DATE_TO}    \\13
    Sleep    ${R_SLEEP_2_S}
    Input Text    ${R_WE_INV_LIST_ADV_SEARCH_DESC}    ${EMPTY}
    Input Text    ${R_WE_INV_LIST_ADV_SEARCH_UPC}    ${EMPTY}
    Sleep    ${R_SLEEP_2_S}
    Click Element    ${R_WE_INV_LIST_ADV_SEARCH_SUBMIT}
    Sleep    ${R_SLEEP_2_S}
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_1}    ${partner_item_id}_2
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_2}    Test by automation script ${partner_item_id}_2
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_3}    UPC_${partner_item_id}_2
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_4}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_5}    0
    Element Text Should Be    ${R_WE_INV_LIST_ROW_1_COL_6}    0
