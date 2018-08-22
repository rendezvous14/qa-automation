*** Settings ***
Resource          All_global_library.robot
Resource          global_resource_testdata_template.robot
Resource          global_resource_api.robot
Resource          global_resource_selenium.robot
Resource          global_resource_metadata.robot
Resource          global_resource_portal.robot

*** Variables ***
${R_WE_INV_LIST_QUICK_SEARCH_TXTBOX}    //*[@id="quick_search_text"]
${R_WE_INV_LIST_QUICK_SEARCH_BUTTON}    //*[@id="quick_search_button"]/i
${R_WE_INV_LIST_ADV_SEARCH_BUTTON}    //*[@id="main-container"]/app-root/div/app-inventory-list/div[1]/div[1]/span/a
${R_WE_INV_LIST_ADV_SEARCH_PARTNER_ITEM_ID}    //*[@id="main-container"]/app-root/div/app-inventory-list/div[2]/div/advance-search/div/inventory-adv-search/form/div/div/div/div[1]/div[1]/div/div[1]/input
${R_WE_INV_LIST_ADV_SEARCH_ITEM_KEY}    //*[@id="main-container"]/app-root/div/app-inventory-list/div[2]/div/advance-search/div/inventory-adv-search/form/div/div/div/div[2]/div[1]/div/div[1]/input
${R_WE_INV_LIST_ADV_SEARCH_DESC}    //*[@id="main-container"]/app-root/div/app-inventory-list/div[2]/div/advance-search/div/inventory-adv-search/form/div/div/div/div[1]/div[1]/div/div[2]/input
${R_WE_INV_LIST_ADV_SEARCH_UPC}    //*[@id="main-container"]/app-root/div/app-inventory-list/div[2]/div/advance-search/div/inventory-adv-search/form/div/div/div/div[2]/div[1]/div/div[2]/input
${R_WE_INV_LIST_ADV_SEARCH_SUPPLIER}    //*[@id="main-container"]/app-root/div/app-inventory-list/div[2]/div/advance-search/div/inventory-adv-search/form/div/div/div/div[1]/div[1]/div/div[3]/input
${R_WE_INV_LIST_ADV_CREATED_DATE_FROM}    //*[@id="datecreated-from"]
${R_WE_INV_LIST_ADV_CREATED_DATE_TO}    //*[@id="datecreated-to"]
${R_WE_INV_LIST_ADV_MODIFIED_DATE_FROM}    //*[@id="lastmodified-from"]
${R_WE_INV_LIST_ADV_MODIFIED_DATE_TO}    //*[@id="lastmodified-to"]
${R_WE_INV_LIST_ADV_SEARCH_SUBMIT}    //*[@id="main-container"]/app-root/div/app-inventory-list/div[2]/div/advance-search/div/inventory-adv-search/form/div/div/div/div[3]/div/button
${R_WE_INV_LIST_ROW_1_COL_1}    //*[@id="tbody_item"]/tr[1]/td[1]/a
${R_WE_INV_LIST_ROW_1_COL_2}    //*[@id="tbody_item"]/tr[1]/td[2]/a
${R_WE_INV_LIST_ROW_1_COL_3}    //*[@id="tbody_item"]/tr[1]/td[3]/a
${R_WE_INV_LIST_ROW_1_COL_4}    //*[@id="tbody_item"]/tr[1]/td[4]/div
${R_WE_INV_LIST_ROW_1_COL_5}    //*[@id="tbody_item"]/tr[1]/td[5]/div
${R_WE_INV_LIST_ROW_1_COL_6}    //*[@id="tbody_item"]/tr[1]/td[6]/div
${R_WE_INV_LIST_ROW_2_COL_1}    //*[@id="tbody_item"]/tr[2]/td[1]/a
${R_WE_INV_LIST_ROW_2_COL_2}    //*[@id="tbody_item"]/tr[2]/td[2]/a
${R_WE_INV_LIST_ROW_2_COL_3}    //*[@id="tbody_item"]/tr[2]/td[3]/a
${R_WE_INV_LIST_ROW_2_COL_4}    //*[@id="tbody_item"]/tr[2]/td[4]/div
${R_WE_INV_LIST_ROW_2_COL_5}    //*[@id="tbody_item"]/tr[2]/td[5]/div
${R_WE_INV_LIST_ROW_2_COL_6}    //*[@id="tbody_item"]/tr[2]/td[6]/div
${R_WE_INV_LIST_ROW_3_COL_1}    //*[@id="tbody_item"]/tr[3]/td[1]/a
${R_WE_INV_LIST_ROW_3_COL_2}    //*[@id="tbody_item"]/tr[3]/td[2]/a
${R_WE_INV_LIST_ROW_3_COL_3}    //*[@id="tbody_item"]/tr[3]/td[3]/a
${R_WE_INV_LIST_ROW_3_COL_4}    //*[@id="tbody_item"]/tr[3]/td[4]/div
${R_WE_INV_LIST_ROW_3_COL_5}    //*[@id="tbody_item"]/tr[3]/td[5]/div
${R_WE_INV_LIST_ROW_3_COL_6}    //*[@id="tbody_item"]/tr[3]/td[6]/div
${R_WE_INV_LIST_NO_ITEMS}    //*[@id="tbody_no_items"]/tr/td
${R_WE_INV_LIST_SHOW_TOTAL_RESULT}    //*[@id="main-container"]/app-root/div/app-inventory-list/div[3]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p
${R_WE_INV_DETAIL_DESC}    //*[@id="main-container"]/app-root/div/app-item-master-detail/div[1]/div[2]/h3/span
${R_WE_INV_DETAIL_ITEM_ID}    //*[@id="main-container"]/app-root/div/app-item-master-detail/div[2]/div[1]/div[1]/div[2]
${R_WE_INV_DETAIL_PARTNER}    //*[@id="main-container"]/app-root/div/app-item-master-detail/div[2]/div[1]/div[2]/div[2]
${R_WE_INV_DETAIL_PARTNER_ITEM_ID}    //*[@id="main-container"]/app-root/div/app-item-master-detail/div[2]/div[1]/div[3]/div[2]
${R_WE_INV_DETAIL_DATE_CREATED}    //*[@id="main-container"]/app-root/div/app-item-master-detail/div[2]/div[2]/div[1]/div[2]
${R_WE_INV_DETAIL_LAST_MODIFIED}    //*[@id="main-container"]/app-root/div/app-item-master-detail/div[2]/div[2]/div[2]/div[2]
${R_WE_INV_DETAIL_UPDATED_BY}    //*[@id="main-container"]/app-root/div/app-item-master-detail/div[2]/div[2]/div[3]/div[2]
${R_WE_INV_DETAIL_WIDTH}    //*[@id="lblWidth"]
${R_WE_INV_DETAIL_HEIGHT}    //*[@id="lblHeight"]
${R_WE_INV_DETAIL_LENGTH}    //*[@id="lblLength"]
${R_WE_INV_DETAIL_WEIGHT}    //*[@id="lblWeight"]
${R_WE_INV_DETAIL_STORAGE}    //*[@id="lblStorage"]
${R_WE_INV_DETAIL_FULFILLMENT}    //*[@id="lblFulfillment"]
${R_WE_INV_DETAIL_UOM}    //*[@id="main-container"]/app-root/div/app-item-master-detail/div[3]/div/tabs/div/tab[1]/div/div/div/div[2]/div/form/div[7]/div[2]/div
${R_WE_INV_DETAIL_QC}    //*[@id="lblQcInformation"]
${R_WE_INV_DETAIL_UPC}   //*[@id="lblUpc"]
${R_WE_INV_DETAIL_ITEM_GROUP}    //*[@id="itemGroup"]
${R_WE_INV_DETAIL_RSP}    //*[@id="lblRetailSellingPrice"]
${R_WE_INV_DETAIL_EDIT_ITEM}    //*[@id="btnEdit"]/i
${R_WE_INV_DETAIL_SUBMIT_ITEM}    //*[@id="btnSubmit"]/i
${R_WE_INV_DETAIL_ITEM_PRICE_TAB}    //*[@id="main-container"]/app-root/div/app-item-master-detail/div[3]/div/tabs/ul/li[2]/a/b
${R_WE_INV_DETAIL_ITEM_PRICE_SUPPLIER_NAME}    //*[@id="tbody_itemprice"]/tr/th[1]
${R_WE_INV_DETAIL_ITEM_PRICE_SUPPLIER_CODE}    //*[@id="tbody_itemprice"]/tr/th[2]
${R_WE_INV_DETAIL_ITEM_PRICE_SUPPLIER_PRICE}    //*[@id="tbody_itemprice"]/tr/th[3]
${R_WE_INV_DETAIL_ITEM_PRICE_SUPPLIER_CURRENCY}    //*[@id="tbody_itemprice"]/tr/th[4]
${R_WE_INV_ITEM_IMPORT_BUTTON}    //*[@id="import_button"]
${R_WE_IMPORT_HIST_ROW_1_COL_1}    //*[@id="element_list"]/tbody/tr[1]/td[1]/a
${R_WE_IMPORT_HIST_ROW_1_COL_2_DIV_1}    //*[@id="element_list"]/tbody/tr[1]/td[2]/div/div[1]/a/b
${R_WE_IMPORT_HIST_ROW_1_COL_2_DIV_2}    //*[@id="element_list"]/tbody/tr[1]/td[2]/div/div[2]/a
${R_WE_IMPORT_HIST_ROW_1_COL_3}    //*[@id="element_list"]/tbody/tr[1]/td[3]/a
${R_WE_IMPORT_HIST_ROW_1_COL_4}    //*[@id="element_list"]/tbody/tr[1]/td[4]/a
${R_WE_IMPORT_HIST_ROW_1_COL_5}    //*[@id="element_list"]/tbody/tr[1]/td[5]/a
${R_WE_IMPORT_HIST_ROW_1_COL_6}    //*[@id="element_list"]/tbody/tr[1]/td[6]/a
${R_WE_IMPORT_HIST_ROW_1_COL_7}    //*[@id="element_list"]/tbody/tr[1]/td[7]/a
${R_WE_IMPORT_HIST_DETAIL_FILE_NAME}    //*[@id="main-container"]/app-root/div/app-files-importer-detail/div[1]/div[2]/div[1]/div[2]
${R_WE_IMPORT_HIST_DETAIL_INPUT_METHOD}    //*[@id="main-container"]/app-root/div/app-files-importer-detail/div[1]/div[2]/div[2]/div[2]
${R_WE_IMPORT_HIST_DETAIL_STATUS}    //*[@id="main-container"]/app-root/div/app-files-importer-detail/div[1]/div[2]/div[4]/div[2]
${R_WE_IMPORT_HIST_DETAIL_REASON}    //*[@id="main-container"]/app-root/div/app-files-importer-detail/div[1]/div[2]/div[5]/div[2]
${R_ERROR_MSG_ACTION_CANNOT_BLANK}    "action, This field cannot be empty"
${R_ERROR_MSG_BODY_CANNOT_EMTPY}      "body, Cannot be empty"
${R_ERROR_MSG_PARTNER_ITEM_ID_CANNOT_EXCEED}    {"partnerItemId":["\\"partnerItemId\\" cannot exceed 50 characters"]}
${R_ERROR_MSG_PARTNER_ITEM_ID_CANNOT_BLANK}    {"partnerItemId":["\\"partnerItemId\\" may not be blank"]}
${R_ERROR_MSG_PARTNER_ITEM_ID_CANNOT_NULL}    "PartnerItemId, This field is not be null"
${R_ERROR_MSG_UPC_CANNOT_OVER_TEN_UPDATE}    ["\\"upcCode\\", This field is max 10 array."]
${R_ERROR_MSG_UPC_CANNOT_OVER_TEN}    "UPC Code max array 10"
${R_ERROR_MSG_UPC_CANNOT_EXCEED_25_CHAR}    {"upcCode":["\\"upcCode\\" cannot exceed 25 characters"]}
${R_ERROR_MSG_UPC_CANNOT_EXCEED_180_CHAR}    {"upcCode":["\\"upcCode\\" cannot exceed 180 characters"]}
${R_ERROR_MSG_DESC_CANNOT_EXCEED_255_CHAR}    {"description":["\\"description\\" cannot exceed 255 characters"]}
${R_ERROR_MSG_DESC_IS_REQUIRED}    {"description":["\\"description\\" field is required"]}
${R_ERROR_MSG_WIDTH_LENGTH}    {"width":["\\"width\\" only allow up to 7 digits and 5 decimal"]}
${R_ERROR_MSG_WIDTH_CANNOT_SET_NEGATIVE}    {"width":["\\"width\\" value should be greater or equal to 0"]}
${R_ERROR_MSG_LENGTH_LENGTH}    {"length":["\\"length\\" only allow up to 7 digits and 5 decimal"]}
${R_ERROR_MSG_LENGTH_CANNOT_SET_NEGATIVE}    {"length":["\\"length\\" value should be greater or equal to 0"]}
${R_ERROR_MSG_HEIGHT_LENGTH}    {"height":["\\"height\\" only allow up to 7 digits and 5 decimal"]}
${R_ERROR_MSG_HEIGHT_CANNOT_SET_NEGATIVE}    {"height":["\\"height\\" value should be greater or equal to 0"]}
${R_ERROR_MSG_WEIGHT_LENGTH}    {"weight":["\\"weight\\" only allow up to 7 digits and 5 decimal"]}
${R_ERROR_MSG_WEIGHT_CANNOT_SET_NEGATIVE}    {"weight":["\\"weight\\" value should be greater or equal to 0"]}
${R_ERROR_MSG_STORAGE_REQUIREMENT_INVALID_1}    {"storageRequirement":["\\"Cool_RoomX\\" is not a valid choice."]}
${R_ERROR_MSG_STORAGE_REQUIREMENT_INVALID_2}    {"storageRequirement":["\\"12345\\" is not a valid choice."]}
${R_ERROR_MSG_FULFILLMENT_PATTERN_INVALID_1}    {"fulfillmentPattern":["\\"LILO\\" is not a valid choice."]}
${R_ERROR_MSG_FULFILLMENT_PATTERN_INVALID_2}    {"fulfillmentPattern":["\\"12345\\" is not a valid choice."]}
${R_ERROR_MSG_QC_CANNOT_EXCEED_100}    {"qcInformation":["\\"qcInformation\\" value cannot exceed 100"]}
${R_ERROR_MSG_QC_LENGTH}    {"qcInformation":["\\"qcInformation\\" value should be 0 to 100 and up to 5 decimal"]}
${R_ERROR_MSG_QC_CANNOT_SET_NEGATIVE}    {"qcInformation":["\\"qcInformation\\" value should be greater or equal to 0"]}
${R_ERROR_MSG_PRICES_CANNOT_EXCEED}    {"prices":[{"price":["Ensure that there are no more than 13 digits in total."]}]}
${R_ERROR_MSG_PRICES_CANNOT_SET_INVALID}    ["'price' value should be greater or equal to 0, length allow up to 9 digits."]
${R_ERROR_MSG_SUPPLIER_KEY_REQUIRED_FOR_PRICE}    ["'supplierKey' is required for item price"]
${R_ERROR_MSG_SUPPLIER_DOES_NOT_EXIST}    ["Supplier DoesNotExist"]
${R_ERROR_MSG_ITEM_GROUP_CANNOT_EXCEED_25_CHAR}    {"itemGroup":["\\"itemGroup\\" cannot exceed 25 characters"]}
${R_ERROR_MSG_RSP_LENGTH_DECIMAL}    {"retailSellingPrice":["\\"retailSellingPrice\\" value should not be more than 5 decimal places."]}
${R_ERROR_MSG_RSP_LENGTH_DIGIT}    ["'retailSellingPrice' value should be greater or equal to 0, length allow up to 9 digits."]
${R_ERROR_MSG_UI_PARTNER_ITEM_ID_CANNOT_EXCEED_50_CHAR}    'partnerItemId' cannot exceed 50 characters.
${R_ERROR_MSG_UI_PARTNER_ITEM_ID_CANNOT_BE_NULL}    PartnerItemId cannot be null.
${R_ERROR_MSG_UI_UPCCODE_CANNOT_EXCEED_180_CHAR}    "upcCode" cannot exceed 180 characters
${R_ERROR_MSG_UI_DESC_CANNOT_EXCEED_255_CHAR}    "description" cannot exceed 255 characters
${R_ERROR_MSG_UI_DESC_FIELD_IS_REQUIRED}    "description" field is required
${R_ERROR_MSG_UI_WIDTH_VALUE}    "width" only allow up to 7 digits and 5 decimal
${R_ERROR_MSG_UI_WIDTH_VALUE_NOT_LESS_THAN_0}    "width" value should be greater or equal to 0
${R_ERROR_MSG_UI_LENGTH_VALUE}    "length" only allow up to 7 digits and 5 decimal
${R_ERROR_MSG_UI_LENGTH_VALUE_NOT_LESS_THAN_0}    "length" value should be greater or equal to 0
${R_ERROR_MSG_UI_WEIGHT_VALUE}    "weight" only allow up to 7 digits and 5 decimal
${R_ERROR_MSG_UI_WEIGHT_VALUE_NOT_LESS_THAN_0}    "weight" value should be greater or equal to 0
${R_ERROR_MSG_UI_HEIGHT_VALUE}    "height" only allow up to 7 digits and 5 decimal
${R_ERROR_MSG_UI_HEIGHT_VALUE_NOT_LESS_THAN_0}    "height" value should be greater or equal to 0
${R_ERROR_MSG_UI_COOL_ROOMX_IS_NOT_VALID}    "Cool_RoomX" is not a valid choice.
${R_ERROR_MSG_UI_12345_IS_NOT_VALID}    "12345" is not a valid choice.
${R_ERROR_MSG_UI_LILO_IS_NOT_VALID}    "LILO" is not a valid choice.
${R_ERROR_MSG_UI_QC_VALUE_CANNOT_EXCEED_100}    "qcInformation" value cannot exceed 100
${R_ERROR_MSG_UI_QC_VALUE}    "qcInformation" value should be 0 to 100 and up to 5 decimal
${R_ERROR_MSG_UI_QC_VALUE_NOT_LESS_THAN_0}    "qcInformation" value should be greater or equal to 0
${R_ERROR_MSG_UI_PRICES_CANNOT_EXCEED_13_DIGIT}    Ensure that there are no more than 13 digits in total.
${R_ERROR_MSG_UI_PRICES_CANNOT_CONVERT_TO_FLOAT}    Prices value can not convert to float.
${R_ERROR_MSG_UI_PRICES_VALUE}    'price' value should be greater or equal to 0, length allow up to 9 digits.
${R_ERROR_MSG_UI_SUPPLIER_CODE_CANNOT_BE_NULL}    '['supplierCode']' cannot be null.
${R_ERROR_MSG_UI_SUPPLIER_CODE_IS_MISSING}    Column ['supplierCode'] is missing
${R_ERROR_MSG_UI_ITEM_GROUP_CANNOT_EXCEED_25_CHAR}    "itemGroup" cannot exceed 25 characters
${R_ERROR_MSG_UI_RSP_VALUE}    "retailSellingPrice" value should not be more than 5 decimal places.
${R_ERROR_MSG_UI_RSP_VALUE_NOT_LESS_THAN_0}    'retailSellingPrice' value should be greater or equal to 0, length allow up to 9 digits.
${R_ERROR_MSG_UI_REQ_FIELD_IS_MISSING}    Column ['supplierCode', 'uom'] is missing
${R_ERROR_MSG_UI_REQ_FIELD_CANNOT_BE_NULL}    '['uom', 'supplierCode']' cannot be null.
${R_ERROR_MSG_UI_FILE_CONTAINS_LINE_EMPTY}    File contains line empty value contents
## Item Services
${R_WE_ITEM_SERVICE_LIST_ROW_1_COL_1}    //*[@id="tbody_item"]/tr[1]/td[1]
${R_WE_ITEM_SERVICE_LIST_ROW_1_COL_2}    //*[@id="tbody_item"]/tr[1]/td[2]
${R_WE_ITEM_SERVICE_LIST_ROW_1_COL_3}    //*[@id="tbody_item"]/tr[1]/td[3]
${R_WE_ITEM_SERVICE_LIST_ROW_2_COL_1}    //*[@id="tbody_item"]/tr[2]/td[1]
${R_WE_ITEM_SERVICE_LIST_ROW_2_COL_2}    //*[@id="tbody_item"]/tr[2]/td[2]
${R_WE_ITEM_SERVICE_LIST_ROW_2_COL_3}    //*[@id="tbody_item"]/tr[2]/td[3]
${R_WE_ITEM_SERVICE_LIST_ROW_3_COL_1}    //*[@id="tbody_item"]/tr[3]/td[1]
${R_WE_ITEM_SERVICE_LIST_ROW_3_COL_2}    //*[@id="tbody_item"]/tr[3]/td[2]
${R_WE_ITEM_SERVICE_LIST_ROW_3_COL_3}    //*[@id="tbody_item"]/tr[3]/td[3]
${R_WE_ITEM_SERVICE_LIST_NO_ITEMS}    //*[@id="tbody_no_items"]/tr/td
## Item Discount
${R_WE_ITEM_DISCOUNT_LIST_ROW_1_COL_1}    //*[@id="tbody_item"]/tr[1]/td[1]
${R_WE_ITEM_DISCOUNT_LIST_ROW_1_COL_2}    //*[@id="tbody_item"]/tr[1]/td[2]
${R_WE_ITEM_DISCOUNT_LIST_ROW_1_COL_3}    //*[@id="tbody_item"]/tr[1]/td[3]
${R_WE_ITEM_DISCOUNT_LIST_ROW_2_COL_1}    //*[@id="tbody_item"]/tr[2]/td[1]
${R_WE_ITEM_DISCOUNT_LIST_ROW_2_COL_2}    //*[@id="tbody_item"]/tr[2]/td[2]
${R_WE_ITEM_DISCOUNT_LIST_ROW_2_COL_3}    //*[@id="tbody_item"]/tr[2]/td[3]
${R_WE_ITEM_DISCOUNT_LIST_ROW_3_COL_1}    //*[@id="tbody_item"]/tr[3]/td[1]
${R_WE_ITEM_DISCOUNT_LIST_ROW_3_COL_2}    //*[@id="tbody_item"]/tr[3]/td[2]
${R_WE_ITEM_DISCOUNT_LIST_ROW_3_COL_3}    //*[@id="tbody_item"]/tr[3]/td[3]
${R_WE_ITEM_DISCOUNT_LIST_NO_ITEMS}    //*[@id="tbody_no_items"]/tr/td

*** Keywords ***
Create_item
    [Arguments]    ${request_body}    ${expected_result}    ${endpoint_item}    ${path}    ${partner_id}    ${x_roles}
    ...    ${http_method}
    ${response}=    HttpRequest    ${request_body}    ${expected_result}    ${endpoint_item}    ${path}    ${partner_id}
    ...    ${x_roles}    ${http_method}
    log    ${response}
    [Return]    ${response}

Prepare item mock data
    [Arguments]    ${template_file}=${R_TEMPLATE_ITEM}
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${template_file}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_DESCRIPTION    Test by automation script
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRICE    50.25
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PREFERRED    true
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_HEIGHT    3.50005
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_LENGTH    5.60005
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WEIGHT    4.70005
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WIDTH    7.80005
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_STANDARD_EXPIRY_TIME    30
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_STORAGE_REQUIREMENT    Cool_Room
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_FULFILLMENT_PATTERN    FIFO
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IS_SERIAL_TRACKED    true
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IS_BATCH_TRACKED    true
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_QC    5
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_UOM    EA
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTIVE    true
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_GROUP    Test item group
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_RSP    98
    Set Global Variable    ${G_REQUEST_BODY}

Verify inventory detail
    [Arguments]    ${item_description}    ${item_id}    ${partner}    ${partner_id}    ${date_created}    ${last_modified}
    ...    ${updated_by}    ${item_width}    ${item_height}    ${item_length}    ${item_weight}    ${storage}
    ...    ${fulfillment}    ${uom}    ${qc}    ${upc}    ${item_group}    ${rsp}
    Log   ${R_WE_INV_DETAIL_DESC}
    Log   ${item_description}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_DESC}    ${item_description}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_ITEM_ID}    ${item_id}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_PARTNER}    ${partner}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_PARTNER_ITEM_ID}    ${partner_id}
    Element Should Contain    ${R_WE_INV_DETAIL_DATE_CREATED}    ${date_created}
    Element Should Contain    ${R_WE_INV_DETAIL_LAST_MODIFIED}    ${last_modified}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_UPDATED_BY}    ${updated_by}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_WIDTH}    ${item_width}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_HEIGHT}    ${item_height}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_LENGTH}    ${item_length}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_WEIGHT}    ${item_weight}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_STORAGE}    ${storage}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_FULFILLMENT}    ${fulfillment}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_UOM}    ${uom}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_QC}    ${qc}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_UPC}    ${upc}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_ITEM_GROUP}    ${item_group}
    Wait Until Keyword Succeeds    3x    3s   Element Text Should Be    ${R_WE_INV_DETAIL_RSP}    ${rsp}

Verify inventory detail item price tab
    [Arguments]    ${supplier_name}    ${supplier_code}    ${supplier_price}    ${supplier_currency}
    Wait Until Page Contains Element Override    ${R_WE_INV_DETAIL_ITEM_PRICE_SUPPLIER_NAME}
    Element Text Should Be    ${R_WE_INV_DETAIL_ITEM_PRICE_SUPPLIER_NAME}    ${supplier_name}
    Element Text Should Be    ${R_WE_INV_DETAIL_ITEM_PRICE_SUPPLIER_CODE}    ${supplier_code}
    Element Text Should Be    ${R_WE_INV_DETAIL_ITEM_PRICE_SUPPLIER_PRICE}    ${supplier_price}
    Element Text Should Be    ${R_WE_INV_DETAIL_ITEM_PRICE_SUPPLIER_CURRENCY}    ${supplier_currency}

Teardown item master method
    Close all browsers
    Sleep    ${R_SLEEP_1_S}
    Remove File    ${R_TEST_DATA_ITEM_GENERATE}*.*

Drop file and verify import history
    [Arguments]    ${item_list_path}    ${item_import_hist_path}    ${csv_file}    ${expected_result}    ${error_message}    ${error_reason}
    ...    ${user}
    Login to admin    ${item_list_path}
    Choose File    ${R_WE_INV_ITEM_IMPORT_BUTTON}    ${EXECDIR}${/}${R_TEST_DATA_ITEM_GENERATE}${csv_file}
    Sleep    ${R_SLEEP_15_S}
    Go To    ${item_import_hist_path}
    Element Text Should Be    ${R_WE_IMPORT_HIST_ROW_1_COL_1}    Drop File
    Element Text Should Be    ${R_WE_IMPORT_HIST_ROW_1_COL_2_DIV_2}    ${csv_file}
    Element Text Should Be    ${R_WE_IMPORT_HIST_ROW_1_COL_3}    ${error_message}
    Element Text Should Be    ${R_WE_IMPORT_HIST_ROW_1_COL_6}    ${user}
    Element Text Should Be    ${R_WE_IMPORT_HIST_ROW_1_COL_7}    ${expected_result}
    Run Keyword If    "${expected_result}"=="Failed"    Click Element    ${R_WE_IMPORT_HIST_ROW_1_COL_2_DIV_2}
    Run Keyword If    "${expected_result}"=="Failed"    Sleep    ${R_SLEEP_2_S}
    Run Keyword If    "${expected_result}"=="Failed"    Verify import history detail    ${csv_file}    ${expected_result}    ${error_message}    ${error_reason}

Verify import history detail
    [Arguments]    ${csv_file}    ${expected_result}    ${error_mesaage}    ${error_reason}    ${method}=Drop File
    Element Text Should Be    ${R_WE_IMPORT_HIST_DETAIL_FILE_NAME}    ${csv_file}
    Element Text Should Be    ${R_WE_IMPORT_HIST_DETAIL_INPUT_METHOD}    ${method}
    Element Text Should Be    ${R_WE_IMPORT_HIST_DETAIL_STATUS}    ${expected_result}
    Element Text Should Be    ${R_WE_IMPORT_HIST_DETAIL_REASON}    ${error_mesaage}
    #####    Use page should contain because this table will be change order later.    #####
    Run Keyword If    "${error_mesaage}"=="Has 1 line error."    Page Should Contain    ${error_reason}

Create Item Service via API
    [Arguments]     ${partner_id}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${expected_status}  ${expected_response}=${EMPTY}
    #####    Partner URL
    ${R_PATH_ITEM_SERVICES_SMF}=    Replace String    ${R_PATH_ITEM_SERVICES_SMF}    <CONFIG_PARTNER_ID>    ${partner_id}
    Log     ${G_REQUEST_BODY}
    #####    Send Http request    #####
    ${response}=     Create_item    ${G_REQUEST_BODY}  ${expected_status}   ${R_ENDPOINT_ITEM}   ${R_PATH_ITEM_SERVICES_SMF}    ${partner_id}    ${R_X_ROLES_NS_6}  ${R_HTTP_POST}
    Sleep          ${R_SLEEP_10_S}
    Run Keyword If    '${expected_status}'=='400'    Run Keyword
    ...    Should Contain    ${response}    ${expected_response}
    Run Keyword If    '${expected_status}'=='200'    Run Keyword
    ...    Log    200 OK

Create Item Discount via API
    [Arguments]     ${partner_id}  ${partner_item_id}  ${description}  ${G_REQUEST_BODY}  ${expected_status}  ${expected_response}=${EMPTY}
    #####    Partner URL
    ${R_PATH_ITEM_DISCOUNTS_SMF}=    Replace String    ${R_PATH_ITEM_DISCOUNTS_SMF}    <CONFIG_PARTNER_ID>    ${partner_id}
    Log     ${G_REQUEST_BODY}
    #####    Send Http request    #####
    ${response}=     Create_item    ${G_REQUEST_BODY}  ${expected_status}   ${R_ENDPOINT_ITEM}   ${R_PATH_ITEM_DISCOUNTS_SMF}    ${partner_id}    ${R_X_ROLES_NS_6}  ${R_HTTP_POST}
    Sleep          ${R_SLEEP_10_S}
    Run Keyword If    '${expected_status}'=='400'    Run Keyword
    ...    Should Contain    ${response}    ${expected_response}
    Run Keyword If    '${expected_status}'=='200'    Run Keyword
    ...    Log    200 OK

Verify Item master via API
    [Arguments]   ${expected_status_code}    ${path}    ${partner_item_id}
    log    ${path}
    log    ${partner_item_id}
    Create Http Context   ${R_ENDPOINT_ITEM}    http
    Set Request Header    Content-Type          ${R_CONTENT_TYPE}
    Next Request May Not Succeed
    GET    ${path}${partner_item_id}/
    ${response_status}=   Get Response Status
    Log   ${response_status}
    Response Status Code Should Equal    ${expected_status_code}
    ${response}=    Get Response Body
    Sleep   1.5s
    [Return]    ${response}
