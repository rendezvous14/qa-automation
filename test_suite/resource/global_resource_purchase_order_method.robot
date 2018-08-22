*** Settings ***
Resource          All_global_library.robot
Resource          global_resource_testdata_template.robot
Resource          global_resource_api.robot
Resource          global_resource_selenium.robot
Resource          global_resource_metadata.robot
Resource          global_resource_portal.robot

*** Variables ***
${R_WE_PO_LIST_QUICK_SEARCH_TXTBOX}    //*[@id="quick_search_text"]
${R_WE_PO_LIST_QUICK_SEARCH_BUTTON}    //*[@id="quick_search_button"]/i
${R_WE_PO_LIST_ADV_SEARCH_BUTTON}    //*[@id="main-container"]/app-root/div/app-purchase-order-list/div[1]/div[1]/span/a
${R_WE_PO_LIST_ADV_SEARCH_PARTNER_PO}    //*[@id="main-container"]/app-root/div/app-purchase-order-list/div[2]/div/advance-search/div/purchase-order-adv-search/form/div/div/div/div[1]/div[1]/input
${R_WE_PO_LIST_ADV_SEARCH_SUPPLIER_NAME}    //*[@id="main-container"]/app-root/div/app-purchase-order-list/div[2]/div/advance-search/div/purchase-order-adv-search/form/div/div/div/div[2]/div[1]/input
${R_WE_PO_LIST_ADV_SEARCH_ORDER_STATUS}    //*[@id="main-container"]/app-root/div/app-purchase-order-list/div[2]/div/advance-search/div/purchase-order-adv-search/form/div/div/div/div[3]/div[1]/button
${R_WE_PO_LIST_ADV_CREATED_DATE_FROM}    //*[@id="datecreated-from"]
${R_WE_PO_LIST_ADV_CREATED_DATE_TO}    //*[@id="datecreated-to"]
${R_WE_PO_LIST_ADV_MODIFIED_DATE_FROM}    //*[@id="lastmodified-from"]
${R_WE_PO_LIST_ADV_MODIFIED_DATE_TO}    //*[@id="lastmodified-to"]
${R_WE_PO_LIST_ADV_RECEIPT_DATE_FROM}    //*[@id="receiptdate-from"]
${R_WE_PO_LIST_ADV_RECEIPT_DATE_TO}    //*[@id="receiptdate-to"]
${R_WE_PO_LIST_ADV_SEARCH_SUBMIT}    //*[@id="main-container"]/app-root/div/app-purchase-order-list/div[2]/div/advance-search/div/purchase-order-adv-search/form/div/div/div/div[4]/div/button
${R_WE_PO_LIST_ROW_1_COL_1}    //*[@id="tbody_item"]/tr[1]/td[1]/a
${R_WE_PO_LIST_ROW_1_COL_2}    //*[@id="tbody_item"]/tr[1]/td[2]/a
${R_WE_PO_LIST_ROW_1_COL_3}    //*[@id="tbody_item"]/tr[1]/td[3]/a
${R_WE_PO_LIST_ROW_1_COL_4}    //*[@id="tbody_item"]/tr[1]/td[4]/a
${R_WE_PO_LIST_ROW_1_COL_5}    //*[@id="tbody_item"]/tr[1]/td[5]/a
${R_WE_PO_LIST_ROW_1_COL_6}    //*[@id="tbody_item"]/tr[1]/td[6]/a
${R_WE_PO_LIST_ROW_1_COL_7}    //*[@id="tbody_item"]/tr[1]/td[7]/a
${R_WE_PO_LIST_ROW_1_COL_8}    //*[@id="tbody_item"]/tr[1]/td[8]/a
${R_WE_PO_LIST_NO_ITEMS}    //*[@id="tbody_no_items"]/tr/td
${R_WE_PO_LIST_IMPORT_BUTTON}    //*[@id="import_button"]
${R_WE_PO_DETAIL_PO_ID}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[1]/div[2]/h3
${R_WE_PO_DETAIL_PARTNER}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[2]/div/div/div[1]/div[1]/div[2]
${R_WE_PO_DETAIL_SUPPLIER}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[2]/div/div/div[1]/div[2]/div[2]
${R_WE_PO_DETAIL_CURRENCY}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[2]/div/div/div[1]/div[3]/div[2]
${R_WE_PO_DETAIL_WH}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[2]/div/div/div[1]/div[4]/div[2]
${R_WE_PO_DETAIL_DATE}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[2]/div/div/div[1]/div[5]/div[2]
${R_WE_PO_DETAIL_EXPECTED_RECEIVE_DATE}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[2]/div/div/div[1]/div[6]/div[2]
${R_WE_PO_DETAIL_CREATED_DATE}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[2]/div/div/div[1]/div[7]/div[2]
${R_WE_PO_DETAIL_SUMMARY_SUB}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[2]/div/div/div[2]/div/div[2]/div[2]
${R_WE_PO_DETAIL_SUMMARY_TAX}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[2]/div/div/div[2]/div/div[3]/div[2]
${R_WE_PO_DETAIL_SUMMARY_TOTAL}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[2]/div/div/div[2]/div/div[4]/div[2]
${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_1}    //*[@id="element_list"]/tbody/tr/th[1]
${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_2}    //*[@id="element_list"]/tbody/tr/th[2]/a
${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_3}    //*[@id="element_list"]/tbody/tr/th[3]
${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_4}    //*[@id="element_list"]/tbody/tr/th[4]/a
${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_5}    //*[@id="element_list"]/tbody/tr/th[5]
${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_6}    //*[@id="element_list"]/tbody/tr/th[6]
${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_7}    //*[@id="element_list"]/tbody/tr/th[7]
${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_8}    //*[@id="element_list"]/tbody/tr/th[8]
${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_9}    //*[@id="element_list"]/tbody/tr/th[9]
${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_10}    //*[@id="element_list"]/tbody/tr/th[10]
${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_11}    //*[@id="element_list"]/tbody/tr/th[11]
${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_12}    //*[@id="element_list"]/tbody/tr/th[12]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_1_COL_1}    //*[@id="element_list"]/tbody/tr[1]/th[1]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_1_COL_2}    //*[@id="element_list"]/tbody/tr[1]/th[2]/a
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_1_COL_3}    //*[@id="element_list"]/tbody/tr[1]/th[3]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_1_COL_4}    //*[@id="element_list"]/tbody/tr[1]/th[4]/a
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_1_COL_5}    //*[@id="element_list"]/tbody/tr[1]/th[5]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_1_COL_6}    //*[@id="element_list"]/tbody/tr[1]/th[6]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_1_COL_7}    //*[@id="element_list"]/tbody/tr[1]/th[7]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_1_COL_8}    //*[@id="element_list"]/tbody/tr[1]/th[8]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_1_COL_9}    //*[@id="element_list"]/tbody/tr[1]/th[9]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_1_COL_10}    //*[@id="element_list"]/tbody/tr[1]/th[10]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_1_COL_11}    //*[@id="element_list"]/tbody/tr[1]/th[11]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_1_COL_12}    //*[@id="element_list"]/tbody/tr[1]/th[12]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_2_COL_1}    //*[@id="element_list"]/tbody/tr[2]/th[1]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_2_COL_2}    //*[@id="element_list"]/tbody/tr[2]/th[2]/a
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_2_COL_3}    //*[@id="element_list"]/tbody/tr[2]/th[3]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_2_COL_4}    //*[@id="element_list"]/tbody/tr[2]/th[4]/a
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_2_COL_5}    //*[@id="element_list"]/tbody/tr[2]/th[5]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_2_COL_6}    //*[@id="element_list"]/tbody/tr[2]/th[6]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_2_COL_7}    //*[@id="element_list"]/tbody/tr[2]/th[7]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_2_COL_8}    //*[@id="element_list"]/tbody/tr[2]/th[8]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_2_COL_9}    //*[@id="element_list"]/tbody/tr[2]/th[9]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_2_COL_10}    //*[@id="element_list"]/tbody/tr[2]/th[10]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_2_COL_11}    //*[@id="element_list"]/tbody/tr[2]/th[11]
${R_WE_PO_DETAIL_ITEM_TAB_MULTI_ROW_2_COL_12}    //*[@id="element_list"]/tbody/tr[2]/th[12]
${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_ADDRESSEE}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[1]/div[1]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_ADDR1}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[1]/div[2]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_ADDR2}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[1]/div[3]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_DISTRICT}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[1]/div[4]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_SUB_DISTRICT}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[1]/div[5]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_CITY}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[1]/div[6]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_PROVINCE}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[1]/div[7]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_POSTCODE}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[1]/div[8]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_COUNTRY}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[1]/div[9]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_PHONE}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[1]/div[10]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_EMAIL}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[1]/div[11]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_BILLING_ADDRESSEE}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[2]/div[1]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_BILLING_ADDR1}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[2]/div[2]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_BILLING_ADDR2}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[2]/div[3]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_BILLING_DISTRICT}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[2]/div[4]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_BILLING_SUB_DISTRICT}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[2]/div[5]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_BILLING_CITY}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[2]/div[6]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_BILLING_PROVINCE}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[2]/div[7]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_BILLING_POSTCODE}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[2]/div[8]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_BILLING_COUNTRY}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[2]/div[9]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_BILLING_PHONE}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[2]/div[10]/div[2]
${R_WE_PO_DETAIL_ADDR_TAB_BILLING_EMAIL}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[2]/div/div/div[2]/div[11]/div[2]
${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_NAME}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[3]/div/div/div/div[1]/div[2]
${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_ADDRESSEE}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[3]/div/div/div/div[2]/div[2]
${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_ADDR1}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[3]/div/div/div/div[3]/div[2]
${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_ADDR2}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[3]/div/div/div/div[4]/div[2]
${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_DISTRICT}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[3]/div/div/div/div[5]/div[2]
${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_SUB_DISTRICT}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[3]/div/div/div/div[6]/div[2]
${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_CITY}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[3]/div/div/div/div[7]/div[2]
${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_PROVINCE}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[3]/div/div/div/div[8]/div[2]
${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_POSTCODE}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[3]/div/div/div/div[9]/div[2]
${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_COUNTRY}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[3]/div/div/div/div[10]/div[2]
${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_PHONE}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[3]/div/div/div/div[11]/div[2]
${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_EMAIL}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/div/tab[3]/div/div/div/div[12]/div[2]
${R_WE_PO_DETAIL_GRN_TAB_ROW_1_COL_1}    //*[@id="element_list"]/tbody/tr/td[1]
${R_WE_PO_DETAIL_GRN_TAB_ROW_1_COL_2}    //*[@id="element_list"]/tbody/tr/td[2]
${R_WE_PO_DETAIL_GRN_TAB_MULTI_ROW_1_COL_1}    //*[@id="element_list"]/tbody/tr[1]/td[1]
${R_WE_PO_DETAIL_GRN_TAB_MULTI_ROW_1_COL_2}    //*[@id="element_list"]/tbody/tr[1]/td[2]
${R_WE_PO_DETAIL_GRN_TAB_MULTI_ROW_2_COL_1}    //*[@id="element_list"]/tbody/tr[2]/td[1]
${R_WE_PO_DETAIL_GRN_TAB_MULTI_ROW_2_COL_2}    //*[@id="element_list"]/tbody/tr[2]/td[2]
${R_WE_PO_DETAIL_ADDR_TAB}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/ul/li[2]/a/b
${R_WE_PO_DETAIL_SUP_ADDR_TAB}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/ul/li[3]/a/b
${R_WE_PO_DETAIL_GRN_TAB}    //*[@id="main-container"]/app-root/div/app-purchase-order-detail/div[3]/div/tabs/ul/li[4]/a/b

*** Keywords ***
Create_po
    [Arguments]    ${request_body}    ${expected_result}    ${endpoint_item}    ${path}    ${partner_id}    ${x_roles}
    ...    ${http_method}
    ${response}=    HttpRequest    ${request_body}    ${expected_result}    ${endpoint_item}    ${path}    ${partner_id}
    ...    ${x_roles}    ${http_method}
    log    ${response}
    [Return]    ${response}

Prepare po mock data
    [Arguments]    ${template_file}=${R_TEMPLATE_PO_ONE_ITEM}
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${template_file}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    QA-Beehive
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_1    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    15
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    TH-AUTO-NS1
    Set Global Variable    ${G_REQUEST_BODY}
    Set Global Variable    ${G_CURRENT_DATE}
    Set Global Variable    ${G_EXPECTED_RECEIVED_DATE}

Teardown po master method
    Close all browsers
    Sleep    ${R_SLEEP_1_S}
    Remove File    ${R_TEST_DATA_PO_GENERATE}*.*

Verify po detail item tab
    [Arguments]    ${line_no}    ${partner_item_id}    ${supplier_code}    ${item_desc}    ${total_qty}    ${received_qty}
    ...    ${open_qty}    ${unit_price}    ${amount}    ${tax_rate}    ${tax_amount}    ${gross_amount}
    Element Text Should Be    ${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_1}    ${line_no}
    Element Text Should Be    ${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_2}    ${partner_item_id}
    Element Text Should Be    ${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_3}    ${supplier_code}
    Element Text Should Be    ${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_4}    ${item_desc}
    Element Text Should Be    ${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_5}    ${total_qty}
    Element Text Should Be    ${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_6}    ${received_qty}
    Element Text Should Be    ${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_7}    ${open_qty}
    Element Text Should Be    ${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_8}    ${unit_price}
    Element Text Should Be    ${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_9}    ${amount}
    Element Text Should Be    ${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_10}    ${tax_rate}
    Element Text Should Be    ${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_11}    ${tax_amount}
    Element Text Should Be    ${R_WE_PO_DETAIL_ITEM_TAB_ROW_1_COL_12}    ${gross_amount}

Verify po detail address tab
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_ADDRESSEE}    Automate netsuite 1
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_ADDR1}    Address1
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_ADDR2}    Address2
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_DISTRICT}    District
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_SUB_DISTRICT}    subDistrict
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_CITY}    City
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_PROVINCE}    Bangkok
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_POSTCODE}    10260
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_COUNTRY}    TH
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_PHONE}    0888642626
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_SHIPPING_EMAIL}    aphisada@acommerce.asia
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_BILLING_ADDRESSEE}    aCommerce
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_BILLING_ADDR1}    Address1
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_BILLING_ADDR2}    Address2
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_BILLING_DISTRICT}    Bang Rak
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_BILLING_SUB_DISTRICT}    ${EMPTY}
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_BILLING_CITY}    Bangkok
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_BILLING_PROVINCE}    Bangkok
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_BILLING_POSTCODE}    10260
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_BILLING_COUNTRY}    TH
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_BILLING_PHONE}    0888642626
    Element Text Should Be    ${R_WE_PO_DETAIL_ADDR_TAB_BILLING_EMAIL}    admin_aa6@acommerce.asia

Verify po detail supplier address tab
    [Arguments]    ${supplier_name}
    Element Text Should Be    ${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_NAME}    ${supplier_name}
    Element Text Should Be    ${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_ADDRESSEE}    ${supplier_name}
    Element Text Should Be    ${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_ADDR1}    Address1
    Element Text Should Be    ${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_ADDR2}    Address2
    Element Text Should Be    ${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_DISTRICT}    Bangkok
    Element Text Should Be    ${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_SUB_DISTRICT}    Bang Rak
    Element Text Should Be    ${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_CITY}    Bang Rak
    Element Text Should Be    ${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_PROVINCE}    Bangkok
    Element Text Should Be    ${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_POSTCODE}    10260
    Element Text Should Be    ${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_COUNTRY}    TH
    Element Text Should Be    ${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_PHONE}    0888642626
    Element Text Should Be    ${R_WE_PO_DETAIL_SUP_ADDR_TAB_SUP_EMAIL}    admin_aa6@acommerce.asia

Verify po detail grn tab
    [Arguments]    ${date}    ${receipt_no}
    Element Should Contain    ${R_WE_PO_DETAIL_GRN_TAB_ROW_1_COL_1}    ${date}
    Element Text Should Be    ${R_WE_PO_DETAIL_GRN_TAB_ROW_1_COL_2}    ${receipt_no}

Drop po file and verify import history
    [Arguments]    ${po_list_path}    ${po_import_hist_path}    ${csv_file}    ${expected_result}    ${error_message}    ${error_reason}
    ...    ${user}=admin
    Login to admin    ${po_list_path}
    Choose File    ${R_WE_PO_LIST_IMPORT_BUTTON}    ${EXECDIR}${/}${R_TEST_DATA_PO_GENERATE}${csv_file}
    Sleep    ${R_SLEEP_15_S}
    Go To    ${po_import_hist_path}
    Element Text Should Be    ${R_WE_IMPORT_HIST_ROW_1_COL_1}    Drop File
    Element Text Should Be    ${R_WE_IMPORT_HIST_ROW_1_COL_2_DIV_2}    ${csv_file}
    Element Text Should Be    ${R_WE_IMPORT_HIST_ROW_1_COL_3}    ${error_message}
    Element Text Should Be    ${R_WE_IMPORT_HIST_ROW_1_COL_6}    ${user}
    Element Text Should Be    ${R_WE_IMPORT_HIST_ROW_1_COL_7}    ${expected_result}
    Run Keyword If    "${expected_result}"=="Failed"    Click Element    ${R_WE_IMPORT_HIST_ROW_1_COL_2_DIV_2}
    Run Keyword If    "${expected_result}"=="Failed"    Sleep    ${R_SLEEP_2_S}
    Run Keyword If    "${expected_result}"=="Failed"    Verify import history detail    ${csv_file}    ${expected_result}    ${error_message}    ${error_reason}

Prepare grn mock data
    [Arguments]    ${po_key}    ${item_key}    ${receipt_id}    ${partner_slug}    ${warehouse}    ${qty}
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ${G_EXPIRY_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    365 days
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${current_date}=    Replace String    ${G_CURRENT_DATE}    ${SPACE}    T
    ${receipt_date}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}=    0    10
    ${receipt_date}=    Set Variable    ${receipt_date}T00:00:00Z
    ${expire_date}=    Get Substring    ${G_EXPIRY_DATE}    0    10
    ${expire_date}=    Set Variable    ${expire_date}T00:00:00Z
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${TEMPLATE_GRN_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CURRENT_DATE    ${current_date}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_RECEIPT_ID    ${receipt_id}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_COMPANY    ${partner_slug}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WAREHOUSE    ${warehouse}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_RECEIPT_DATE    ${receipt_date}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_ID_KEY    ${po_key}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_KEY    ${item_key}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_OPEN_QTY    0.00000
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPIRE_DATE    ${expire_date}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_LOT    LOT_${current_date_sub}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_QTY    ${qty}
    log    ${G_REQUEST_BODY}
    Set Global Variable    ${G_REQUEST_BODY}
    Set Global Variable    ${G_CURRENT_DATE}
    Set Global Variable    ${G_EXPECTED_RECEIVED_DATE}
    [Return]    ${G_REQUEST_BODY}

Prepare putaway mock data
    [Arguments]    ${po_key}    ${item_key}    ${receipt_id}    ${workzone}    ${partner_slug}    ${warehouse}
    ...    ${qty}    ${line_no}    ${lot_no}=${EMPTY}
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ${G_EXPIRY_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    365 days
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${current_date}=    Replace String    ${G_CURRENT_DATE}    ${SPACE}    T
    ${receipt_date}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}=    0    10
    ${receipt_date}=    Set Variable    ${receipt_date}T00:00:00Z
    ${expire_date}=    Get Substring    ${G_EXPIRY_DATE}    0    10
    ${expire_date}=    Set Variable    ${expire_date}T00:00:00Z
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${TEMPLATE_PUTAWAY_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CURRENT_DATE    ${current_date}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_RECEIPT_ID    ${receipt_id}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_COMPANY    ${partner_slug}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WAREHOUSE    ${warehouse}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_RECEIPT_DATE    ${receipt_date}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPIRE_DATE    ${expire_date}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_LOT    LOT_${current_date_sub}${lot_no}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_QTY    ${qty}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TO_LOCATION_WORKZONE    ${workzone}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_LINE_NO    ${line_no}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_ID_KEY    ${po_key}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_KEY    ${item_key}
    Set Global Variable    ${G_REQUEST_BODY}
    Set Global Variable    ${G_CURRENT_DATE}
    Set Global Variable    ${G_EXPECTED_RECEIVED_DATE}
    [Return]    ${G_REQUEST_BODY}

Prepare grn with 2 item mock data
    [Arguments]    ${po_key}    ${item_key_1}    ${item_key_2}    ${receipt_id}    ${partner_slug}    ${warehouse}
    ...    ${qty_1}    ${qty_2}
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ${G_EXPIRY_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    365 days
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${current_date}=    Replace String    ${G_CURRENT_DATE}    ${SPACE}    T
    ${receipt_date}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}=    0    10
    ${receipt_date}=    Set Variable    ${receipt_date}T00:00:00Z
    ${expire_date}=    Get Substring    ${G_EXPIRY_DATE}    0    10
    ${expire_date}=    Set Variable    ${expire_date}T00:00:00Z
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${TEMPLATE_GRN_TWO_ITEM_ONE_CONTAINERS}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CURRENT_DATE    ${current_date}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_RECEIPT_ID    ${receipt_id}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_COMPANY    ${partner_slug}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WAREHOUSE    ${warehouse}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_RECEIPT_DATE    ${receipt_date}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_ID_KEY    ${po_key}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_KEY_1    ${item_key_1}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_OPEN_QTY_1    0.00000
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_1_EXPIRE_DATE_1    ${expire_date}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_1_LOT_1    LOT_${current_date_sub}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_1_QTY_1    ${qty_1}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_KEY_2    ${item_key_2}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_OPEN_QTY_2    0.00000
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_2_EXPIRE_DATE_1    ${expire_date}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_2_LOT_1    LOT_${current_date_sub}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_2_QTY_1    ${qty_2}
    log    ${G_REQUEST_BODY}
    Set Global Variable    ${G_REQUEST_BODY}
    Set Global Variable    ${G_CURRENT_DATE}
    Set Global Variable    ${G_EXPECTED_RECEIVED_DATE}
    [Return]    ${G_REQUEST_BODY}

Prepare grn with 4 item mock data
    [Arguments]    ${po_key}    ${item_key_1}    ${item_key_1_2}    ${item_key_2}    ${item_key_2_2}    ${receipt_id}
    ...    ${partner_slug}    ${warehouse}    ${qty_1}    ${qty_1_2}    ${qty_2}    ${qty_2_2}
    ...    ${lot_no}=${EMPTY}
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ${G_EXPIRY_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    365 days
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${current_date}=    Replace String    ${G_CURRENT_DATE}    ${SPACE}    T
    ${receipt_date}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}=    0    10
    ${receipt_date}=    Set Variable    ${receipt_date}T00:00:00Z
    ${expire_date}=    Get Substring    ${G_EXPIRY_DATE}    0    10
    ${expire_date}=    Set Variable    ${expire_date}T00:00:00Z
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${TEMPLATE_GRN_FOUR_ITEM_ONE_CONTAINERS}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CURRENT_DATE    ${current_date}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_RECEIPT_ID    ${receipt_id}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_COMPANY    ${partner_slug}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WAREHOUSE    ${warehouse}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_RECEIPT_DATE    ${receipt_date}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_ID_KEY    ${po_key}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_KEY_1_2    ${item_key_1_2}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_OPEN_QTY_1_2    0.00000
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_KEY_1    ${item_key_1}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_OPEN_QTY_1    0.00000
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_1_EXPIRE_DATE_1    ${expire_date}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_1_LOT_1    LOT_${current_date_sub}${lot_no}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_1_QTY_1_2    ${qty_1_2}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_1_QTY_1    ${qty_1}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_KEY_2_2    ${item_key_2_2}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_OPEN_QTY_2_2    0.00000
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_KEY_2    ${item_key_2}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_OPEN_QTY_2    0.00000
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_2_EXPIRE_DATE_1    ${expire_date}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_2_LOT_1    LOT_${current_date_sub}${lot_no}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_2_QTY_1_2    ${qty_2_2}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_2_QTY_1    ${qty_2}
    log    ${G_REQUEST_BODY}
    Set Global Variable    ${G_REQUEST_BODY}
    Set Global Variable    ${G_CURRENT_DATE}
    Set Global Variable    ${G_EXPECTED_RECEIVED_DATE}
    [Return]    ${G_REQUEST_BODY}
