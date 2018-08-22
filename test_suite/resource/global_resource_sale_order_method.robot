*** Settings ***
Library           HttpLibrary.HTTP
Library           SeleniumLibrary

*** Variables ***
${SO_WAREHOUSE_CODE}    TH-ACOM-RM3
${SO_ORDER_STORE_ENDPOINT}    order-store-qa.acommercedev.service
${SO_PO_PATH}     /os/partner/${SO_PARTNER_ID}/submit-purchase-orders/
${SO_X_ROLE}      bo_${SO_PARTNER_ID}
${SO_PARTNER_SLUG}    da2-${SO_PARTNER_ID}
${SO_SO_PATH}     /os/item-sales-orders/
${SO_GET_FO_KEY}    /os/so
${SO_ENDPOINT_SALE_ORDER}    https://admintest.acommercedev.com/beehive/frontend/ui-sales-order/detail/${SO_PARTNER_ID}
${SO_ENDPOINT_CANCEL_SALE_ORDER}    http://order-store-qa.acommercedev.service/os/item-sales-orders
${SO_ADJ_AVI_LOCATION_MOVE}    Beehive\\test_suite\\sale_order\\test_data_adjustment\\Adj_avai_location_move.xml
${SO_ADJ_ONHAND_POSITIVE}    Beehive\\test_suite\\sale_order\\test_data_adjustment\\Adj_onh_positive.xml
${SO_ADJ_ONHAND_NEGATIVE}    Beehive\\test_suite\\sale_order\\test_data_adjustment\\Adj_onh_negative.xml
${SO_ADJ_ONHAND_CYCLECOUNT}    Beehive\\test_suite\\sale_order\\test_data_adjustment\\Adj_onh_cyclecount.xml
${SO_PREFIX}      DA2
${SO_ENDPOINT_SALE_ORDER_LIST}    https://admintest.acommercedev.com/beehive/frontend/ui-sales-order/${SO_PARTNER_ID}
${SO_ENDPOINT_BACK_ORDER_LIST}    https://admintest.acommercedev.com/beehive/frontend/ui-back-order/${SO_PARTNER_ID}
${R_PARTNER_ITEM_ID_SCALE_1}    ${CONFIG_PARTNER_ITEM_ID_SCALE_1}
${R_X_ROLE_SCALE_1}             ${CONFIG_X_ROLE_SCALE_1}
${R_PATH_ISO}                   ${CONFIG_PATH_ISO}
${R_PATH_FFO}                   ${CONFIG_PATH_FFO}

*** Keywords ***
Prepare po for scale
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${TEMPLATE_PO_ONE_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    AUTOMATE
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO    1
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID    ITEM_XXX
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_SUPPLIER_CODE    ${SO_PARTNER_NAME}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE    10.5
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_RECEIVED_STATUS    ${EMPTY}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SUPPLIER_NAME    ${SO_PARTNER_NAME}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    ${SO_WAREHOUSE_CODE}
    Set Global Variable    ${G_REQUEST_BODY}
    Set Global Variable    ${G_CURRENT_DATE}
    Set Global Variable    ${G_EXPECTED_RECEIVED_DATE}

Prepare po 2 item for scale
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${TEMPLATE_PO_TWO_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    AUTOMATE
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ITEM_XXX
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_SUPPLIER_CODE_1    ${SO_PARTNER_NAME}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    10.5
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_2    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_2    2
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ITEM_XXX
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_2    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_SUPPLIER_CODE_2    ${SO_PARTNER_NAME}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_2    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_2    10.5
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_RECEIVED_STATUS    ${EMPTY}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SUPPLIER_NAME    ${SO_PARTNER_NAME}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    ${SO_WAREHOUSE_CODE}
    Set Global Variable    ${G_REQUEST_BODY}
    Set Global Variable    ${G_CURRENT_DATE}
    Set Global Variable    ${G_EXPECTED_RECEIVED_DATE}

Prepare so for scale
    ${SO_PARTNER_ID}=  Set Variable   3904
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${R_TEMPLATE_SO_ONE_ITEM_ONE_LINE_NO_SERIAL}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    STANDARD_2_4_DAYS
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    CCOD
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXT_SO_ID    <INPUT BY TEST CASE>
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ID    ${SO_PARTNER_ID}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRODUCT_ID    PRODUCT_SO
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRODUCT_TITLE    MOCKUP PRODUCT
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRODUCT_QTY    3
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${ITEM_QA2_G_FIFO_001}
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ORDER_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_INVOICE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_GROSS_TOTAL    400
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_COLLECTION_AMOUNT    500
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_INSURANCE_DECLARE_VALUE    600
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CURRENCY_UNIT    THB
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ORDER_NOTE    Test order by Aphisada I.
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SHIPPING_NOTE    Test shipping by Aphisada I.
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    ALIBABA
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SALE_CH_ID    ALI
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CUSTOMER_TAX_ID    ALI_TAX_0001
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CUSTOMER_TAX_TYPE    ALI_TAX_TYPE
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CUSTOMER_BRANCH_CODE    ALI_BRANCH_0001
    Set Global Variable    ${G_REQUEST_BODY}
    Set Global Variable    ${G_CURRENT_DATE}
    Set Global Variable    ${G_EXPECTED_RECEIVED_DATE}
    log    ${G_REQUEST_BODY}

Prepare so with two product for scale
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${TEMPLATE_SO_TWO_PRODUCT}
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    STANDARD_2_4_DAYS
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    EXPRESS_1_2_DAYS
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    CCOD
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXT_SO_ID    <INPUT BY TEST CASE>
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ID_1    ${SO_PARTNER_ID}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRODUCT_ID_1    PRODUCT_SO_1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRODUCT_TITLE_1    MOCKUP PRODUCT 1
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRODUCT_QTY    3
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ID_2    ${SO_PARTNER_ID}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRODUCT_ID_2    PRODUCT_SO_2
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRODUCT_TITLE_2    MOCKUP PRODUCT 2
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRODUCT_QTY    3
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY    1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ORDER_DATE    ${G_CURRENT_DATE}+07
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_INVOICE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_GROSS_TOTAL    400
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_COLLECTION_AMOUNT    500
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_INSURANCE_DECLARED_VALUE    600
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CURRENCY_UNIT    THB
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ORDER_NOTE    Test order by Aphisada I.
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SHIPPING_NOTE    Test shipping by Aphisada I.
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    ALIBABA
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SALE_CH_ID    ALI
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CUSTOMER_TAX_ID    ALI_TAX_0001
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CUSTOMER_TAX_TYPE    ALI_TAX_TYPE
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CUSTOMER_BRANCH_CODE    ALI_BRANCH_0001
    Set Global Variable    ${G_REQUEST_BODY}
    Set Global Variable    ${G_CURRENT_DATE}
    Set Global Variable    ${G_EXPECTED_RECEIVED_DATE}
    log    ${G_REQUEST_BODY}

Prepare picking pending for scale
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${TEMPLATE_PICKING_PENDING}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SHIPMENT_ID
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_DATETIME    ${G_CURRENT_DATE}
    Set Global Variable    ${G_REQUEST_BODY}
    Set Global Variable    ${G_CURRENT_DATE}
    Set Global Variable    ${G_EXPECTED_RECEIVED_DATE}

Prepare order confirm for scale
    [Arguments]    ${template}
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${template}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SHIPMENT_ID
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_DATETIME    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_KEY_1
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_LOT_ID_1
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1
    Set Global Variable    ${G_REQUEST_BODY}
    Set Global Variable    ${G_CURRENT_DATE}
    Set Global Variable    ${G_EXPECTED_RECEIVED_DATE}

Clean data
    [Arguments]    ${item_key}    ${so_key}
    Update Inventory Item    ${item_key}
    Delete Data Inventory Demand    '${so_key}'
    [Teardown]    Close All Browsers

Verify fulfillment orders tab
    [Arguments]    ${fulfillment_order_id}    ${fulfillment_status}    ${shipping_status}    ${shipping_tracking}    ${rma_id}    ${reason_code}
    ...    ${create_date}
    Element Text Should Be    //*[@id="fulfillment_order_list"]/tbody/tr/td[2]/a    ${fulfillment_order_id}
    Element Text Should Be    //*[@id="fulfillment_order_list"]/tbody/tr/td[3]    ${fulfillment_status}
    Element Text Should Be    //*[@id="fulfillment_order_list"]/tbody/tr/td[4]    ${shipping_status}
    Element Text Should Be    //*[@id="fulfillment_order_list"]/tbody/tr/td[5]    ${shipping_tracking}
    Element Text Should Be    //*[@id="fulfillment_order_list"]/tbody/tr/td[6]    ${rma_id}
    Element Text Should Be    //*[@id="fulfillment_order_list"]/tbody/tr/td[7]    ${reason_code}
    Comment    Element Should Contain    //*[@id="fulfillment_order_list"]/tbody/tr/td[8]    ${create_date}    ###WAIT For CM modified

Verify two products tab
    [Arguments]    ${products_id_1}    ${product_name_1}    ${partner_item_id_1}    ${qty_1}    ${products_id_2}    ${product_name_2}
    ...    ${partner_item_id_2}    ${qty_2}
    Element Text Should Be    //*[@id="product_list"]/tbody/tr[1]/td[1]    1
    Element Text Should Be    //*[@id="product_list"]/tbody/tr[1]/td[2]    ${products_id_1}
    Element Text Should Be    //*[@id="product_list"]/tbody/tr[1]/td[3]    ${product_name_1}
    Element Text Should Be    //*[@id="product_list"]/tbody/tr[1]/td[4]    ${partner_item_id_1}
    Element Text Should Be    //*[@id="product_list"]/tbody/tr[1]/td[5]    ${qty_1}
    Element Text Should Be    //*[@id="product_list"]/tbody/tr[2]/td[1]    2
    Element Text Should Be    //*[@id="product_list"]/tbody/tr[2]/td[2]    ${products_id_2}
    Element Text Should Be    //*[@id="product_list"]/tbody/tr[2]/td[3]    ${product_name_2}
    Element Text Should Be    //*[@id="product_list"]/tbody/tr[2]/td[4]    ${partner_item_id_2}
    Element Text Should Be    //*[@id="product_list"]/tbody/tr[2]/td[5]    ${qty_2}

Verify sale order detail
    [Arguments]    ${so_id}    ${partner_order_date}    ${internal_order_id}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[2]/div[1]/div[1]/div[2]    ${SO_PARTNER_NAME}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[2]/div[1]/div[2]/div[2]    ${so_id}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[2]/div[1]/div[3]/div[2]    ${SO_PARTNER_SLUG}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[2]/div[1]/div[4]/div[2]    ${partner_order_date}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[2]/div[1]/div[5]/div[2]    ${internal_order_id}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[2]/div[1]/div[6]/div[2]    ${SO_PREFIX}${so_id}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[2]/div[1]/div[7]/div[2]    ALIBABA
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[2]/div[1]/div[8]/div[2]    THB
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[2]/div[1]/div[9]/div[2]    600.00000
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[2]/div[1]/div[10]/div[2]    500.00000
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[2]/div[1]/div[11]/div[2]    Test order by Aphisada I.

Verify shipping tab
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[3]/div/div/div[2]/div/div[1]/div[2]    CCOD
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[3]/div/div/div[2]/div/div[2]/div[2]    EXPRESS_1_2_DAYS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[3]/div/div/div[4]/div[1]/div[1]/div[2]    Order shipment addressee
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[3]/div/div/div[4]/div[1]/div[2]/div[2]    Order shipment address1
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[3]/div/div/div[4]/div[1]/div[3]/div[2]    Order shipment address2
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[3]/div/div/div[4]/div[1]/div[4]/div[2]    Silom
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[3]/div/div/div[4]/div[1]/div[5]/div[2]    Bangrak
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[3]/div/div/div[4]/div[1]/div[6]/div[2]    Bangkok
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[3]/div/div/div[4]/div[2]/div[1]/div[2]    Bangkok
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[3]/div/div/div[4]/div[2]/div[2]/div[2]    10260
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[3]/div/div/div[4]/div[2]/div[3]/div[2]    TH
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[3]/div/div/div[4]/div[2]/div[4]/div[2]    081-111-2222
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[3]/div/div/div[4]/div[2]/div[5]/div[2]    order_shipment@acommerce.asia

Verify billing tab
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[4]/div/div/div[2]/div/div[1]/div[2]    ALI_TAX_0001
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[4]/div/div/div[2]/div/div[2]/div[2]    ALI_TAX_TYPE
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[4]/div/div/div[2]/div/div[3]/div[2]    ALI_BRANCH_0001
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[4]/div/div/div[4]/div[1]/div[1]/div[2]    Billing Info addressee
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[4]/div/div/div[4]/div[1]/div[2]/div[2]    Billing Info address1
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[4]/div/div/div[4]/div[1]/div[3]/div[2]    Billing Info address2
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[4]/div/div/div[4]/div[1]/div[4]/div[2]    Silom
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[4]/div/div/div[4]/div[1]/div[5]/div[2]    Bangrak
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[4]/div/div/div[4]/div[1]/div[6]/div[2]    Bangkok
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[4]/div/div/div[4]/div[2]/div[1]/div[2]    Bangkok
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[4]/div/div/div[4]/div[2]/div[2]/div[2]    10260
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[4]/div/div/div[4]/div[2]/div[3]/div[2]    TH
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[4]/div/div/div[4]/div[2]/div[4]/div[2]    083-333-4444
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[3]/div/tabs/div/tab[4]/div/div/div[4]/div[2]/div[5]/div[2]    order_billing@acommerce.asia

Verify fulfillment status tab
    [Arguments]    ${ready_to_pick_date}    ${shipment_tracking_id}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-fulfillment-order-detail/div[2]/div/div/div/div[2]/div/tabs/div/tab[2]/div/div/div/div/div[1]/div[1]/div[2]    ${ready_to_pick_date}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-fulfillment-order-detail/div[2]/div/div/div/div[2]/div/tabs/div/tab[2]/div/div/div/div/div[1]/div[3]/div[2]    ${shipment_tracking_id}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-fulfillment-order-detail/div[2]/div/div/div/div[2]/div/tabs/div/tab[2]/div/div/div/div/div[2]/div/div/div[1]/div[1]/strong    RESERVED
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-fulfillment-order-detail/div[2]/div/div/div/div[2]/div/tabs/div/tab[2]/div/div/div/div/div[2]/div/div/div[2]/div[1]/strong    READY_TO_PICK

Verify fulfillment detail
    [Arguments]    ${so_id}    ${partner_order_date}    ${internal_order_id}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-fulfillment-order-detail/div[2]/div/div/div/div[1]/div[1]/div[1]/div[2]    ${SO_PARTNER_NAME}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-fulfillment-order-detail/div[2]/div/div/div/div[1]/div[1]/div[2]/div[2]/a    ${so_id}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-fulfillment-order-detail/div[2]/div/div/div/div[1]/div[1]/div[3]/div[2]    ${SO_PARTNER_SLUG}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-fulfillment-order-detail/div[2]/div/div/div/div[1]/div[1]/div[4]/div[2]    ${partner_order_date}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-fulfillment-order-detail/div[2]/div/div/div/div[1]/div[1]/div[5]/div[2]    ${internal_order_id}
    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-fulfillment-order-detail/div[2]/div/div/div/div[1]/div[1]/div[6]/div[2]    ${SO_PREFIX}${so_id}

Clean data inventory item
    [Arguments]    ${item_key}
    Update Inventory Item    ${item_key}
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    ${item_key}
    [Teardown]    Close All Browsers

Prepare template so
    [Arguments]    ${template}=${TEMPLATE_SO_TWO_PRODUCT}
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${template}
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    EXPRESS_1_2_DAYS    <INPUT BY TEST CASE>
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    CCOD    <INPUT BY TEST CASE>
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXT_SO_ID    <INPUT BY TEST CASE>
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ID_1    ${SO_PARTNER_ID}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRODUCT_ID_1    PRODUCT_SO_1
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRODUCT_TITLE_1    MOCKUP PRODUCT 1
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRODUCT_QTY    3    <INPUT BY TEST CASE>
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY    1    <INPUT BY TEST CASE>
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ID_2    ${SO_PARTNER_ID}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRODUCT_ID_2    PRODUCT_SO_2
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRODUCT_TITLE_2    MOCKUP PRODUCT 2
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PRODUCT_QTY    3    <INPUT BY TEST CASE>
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY    1    <INPUT BY TEST CASE>
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ORDER_DATE    ${G_CURRENT_DATE}+07
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_INVOICE_DATE    ${G_CURRENT_DATE}
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_GROSS_TOTAL    400
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_COLLECTION_AMOUNT    500
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_INSURANCE_DECLARED_VALUE    600
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CURRENCY_UNIT    THB
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ORDER_NOTE    Test order by Aphisada I.
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SHIPPING_NOTE    Test shipping by Aphisada I.
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    ALIBABA    <INPUT BY TEST CASE>
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace    <INPUT BY TEST CASE>
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SALE_CH_ID    ALI    <INPUT BY TEST CASE>
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CUSTOMER_TAX_ID    ALI_TAX_0001
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CUSTOMER_TAX_TYPE    ALI_TAX_TYPE
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CUSTOMER_BRANCH_CODE    ALI_BRANCH_0001
    Set Global Variable    ${G_REQUEST_BODY}
    Set Global Variable    ${G_CURRENT_DATE}
    Set Global Variable    ${G_EXPECTED_RECEIVED_DATE}
    log    ${G_REQUEST_BODY}

Prepare po 4 item for scale
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${TEMPLATE_PO_FOUR_ITEM}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ACTION    create
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_CREATE_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_EXPECTED_RECEIVE_DATE    ${G_EXPECTED_RECEIVED_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_IMPORTED_BY    AUTOMATE
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_1    1
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ITEM_XXX
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_SUPPLIER_CODE_1    ${SO_PARTNER_NAME}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_1    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_1    10.5
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_DESC_2    Item description
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_2    2
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ITEM_XXX
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_2    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_SUPPLIER_CODE_2    ${SO_PARTNER_NAME}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_2    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_2    10.5
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_3    3
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_3    ITEM_XXX
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_3    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_SUPPLIER_CODE_3    ${SO_PARTNER_NAME}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_3    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_3    10.5
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_LINE_NO_4    4
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_4    ITEM_XXX
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_QTY_4    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_SUPPLIER_CODE_4    ${SO_PARTNER_NAME}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_TAX_RATE_4    10
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_ITEM_UNIT_PRICE_4    10.5
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_PO_DATE    ${G_CURRENT_DATE}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_RECEIVED_STATUS    ${EMPTY}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SUPPLIER_NAME    ${SO_PARTNER_NAME}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_TAX_RATE    7
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WH_CODE    ${SO_WAREHOUSE_CODE}
    Set Global Variable    ${G_REQUEST_BODY}
    Set Global Variable    ${G_CURRENT_DATE}
    Set Global Variable    ${G_EXPECTED_RECEIVED_DATE}

Prepare cancel success from scale
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${TEMPLATE_CANCEL_SO_SUCCESS}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SHIPMENT_ID
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_DATETIME    ${G_CURRENT_DATE}
    Set Global Variable    ${G_REQUEST_BODY}
    Set Global Variable    ${G_CURRENT_DATE}
    Set Global Variable    ${G_EXPECTED_RECEIVED_DATE}

Prepare cancel fail from scale
    ##########    Get current date    ##########
    ${G_CURRENT_DATE}=    Get Current Date
    ${G_EXPECTED_RECEIVED_DATE}=    Add Time To Date    ${G_CURRENT_DATE}    1 days
    ##########    Set request body    ##########
    ${G_REQUEST_BODY}    Get File    ${TEMPLATE_CANCEL_SO_FAIL}
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    Comment    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_SHIPMENT_ID
    ${G_REQUEST_BODY}    Replace String    ${G_REQUEST_BODY}    VAR_DATETIME    ${G_CURRENT_DATE}
    Set Global Variable    ${G_REQUEST_BODY}
    Set Global Variable    ${G_CURRENT_DATE}
    Set Global Variable    ${G_EXPECTED_RECEIVED_DATE}

Prepare Simple Sales Order
    [Arguments]   ${g_partner_id}   ${partnerSalesOrderId}  ${partnerItemId}   ${sales_order_qty}
    ####    Send Http request    #####
    ${request_body}=    Prepare Simple Sales Order template   ${R_TEMPLATE_SO_SINGLE_LINE_SINGLE_ITEM}   ${partnerSalesOrderId}
    ####### SO Test Data ########
    ${request_body}=    Replace String    ${request_body}    VAR_CURRENCY_UNIT               THB
    ${request_body}=    Replace String    ${request_body}    VAR_SUB_TOTAL                   100.00
    ${request_body}=    Replace String    ${request_body}    VAR_GROSS_TOTAL                 100.00
    ${request_body}=    Replace String    ${request_body}    VAR_COLLECTION_AMOUNT           100.00
    ${request_body}=    Replace String    ${request_body}    VAR_INSURANCE_DECLARED_VALUE    100.00
    ${request_body}=    Replace String    ${request_body}    VAR_LINE_NUMBER                 1
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_ID                  ${g_partner_id}
    ${request_body}=    Replace String    ${request_body}    VAR_PRODUCT_ID                  ${partnerItemId}
    ${request_body}=    Replace String    ${request_body}    VAR_PRODUCT_TITLE               ${partnerItemId}
    ${request_body}=    Replace String    ${request_body}    VAR_PRODUCT_QTY                 ${sales_order_qty}
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID             ${partnerItemId}
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_ID                  ${g_partner_id}
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_QTY                    1
    ${request_body}=    Replace String    ${request_body}    VAR_GROSS_AMOUNT                100.00
    Log   ${request_body}
    ###### Send HTTP Request #####
    ${resultJSONBody}=  Create Sales Order via API successfully  ${g_partner_id}  ${request_body}
    ${salesOrderKey}=  Get JSON Value   ${resultJSONBody}   /key
    ${salesOrderKey}=  Remove String    ${salesOrderKey}    "
    [Return]     ${salesOrderKey}

Prepare Simple Sales Order template
    [Arguments]   ${template_file}   ${partnerSalesOrderId}
    ${expected_receive_date}=        Add Time To Date    ${g_current_date}    1 days
    ${orderDate}=    Set Variable    ${g_current_date}
    ${inputInvoiceDate}=    Set Variable    ${expected_receive_date}
    ${so_file}    Get File       ${template_file}
    ${request_body}=    Set Variable    ${so_file}
    ${request_body}=    Replace String    ${request_body}    VAR_EXT_SO_ID                ${partnerSalesOrderId}
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_SHIPPING_TYPE    NEXT_DAY
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_PAYMENT_TYPE     COD
    ${request_body}=    Replace String    ${request_body}    VAR_ORDER_DATE               ${orderDate}
    ${request_body}=    Replace String    ${request_body}    VAR_INVOICE_DATE             ${inputInvoiceDate}
    ${request_body}=    Replace String    ${request_body}    VAR_ORDER_NOTE               TESTED BY BH AUTOMATION on ${orderDate}
    ${request_body}=    Replace String    ${request_body}    VAR_SHIPPING_NOTE            TESTED BY BH AUTOMATION on ${orderDate}
    ${request_body}=    Replace String    ${request_body}    VAR_SALE_SUB_CH_NAME         ${R_SO_SCALE_SALE_SUB_CH_NAME_2}
    ${request_body}=    Replace String    ${request_body}    VAR_SALE_CH_TYPE             ${R_SO_SCALE_SALE_CH_TYPE_2}
    ${request_body}=    Replace String    ${request_body}    VAR_SALE_CH_ID               ${R_SO_SCALE_SALE_CH_ID_2}
    ${request_body}=    Replace String    ${request_body}    VAR_CUSTOMER_TAX_ID          ${R_SO_SCALE_CUSTOMER_TAX_ID_2}
    ${request_body}=    Replace String    ${request_body}    VAR_CUSTOMER_TAX_TYPE        ${R_SO_SCALE_CUSTOMER_TAX_TYPE_2}
    ${request_body}=    Replace String    ${request_body}    VAR_CUSTOMER_BRANCH_CODE     ${R_SO_SCALE_CUSTOMER_BRANCH_CODE_2}
    [Return]    ${request_body}

Create Sales Order via API successfully
    [Arguments]    ${partnerId}    ${SO_BODY}
    ##### HTTP Request
    Create Http Context     ${R_ENDPOINT_ORDERSTORE}    http
    Set Request Header      Content-Type   ${R_CONTENT_TYPE}
    Set Request Header      X-roles        bo_${partnerId}
    Set Request Header      X-User-Name    bh_automation
    Set Request Body        ${SO_BODY}
    POST                    ${R_PATH_ISO}
    Response Status Code Should Equal    201
    ${resultJSONBody}=    Get Response Body
    Log Response Body
    [Return]   ${resultJSONBody}

Get Fulfilment Order ID
    [Arguments]    ${so_key}
    ##### HTTP Request
    Create Http Context     ${R_ENDPOINT_ORDERSTORE}    http
    Set Request Header      Content-Type   ${R_CONTENT_TYPE}
    POST                    ${R_PATH_FFO}?salesOrderKey=${so_key}
    Response Status Code Should Equal    200
    ${resultJSONBody}=    Get Response Body
    Log Response Body
    ${ffo_key}=   Get JSON Value   /0/key
    ${ffo_key}=  Remove String    ${ffo_key}    "
    [Return]     ${ffo_key}

Update Sales Order for Non GL
    [Arguments]   ${salesOrderKey}   ${update_non_gl_body}
    ${R_PATH_SO_UPDATE_NON_GL}=  Replace String   ${R_PATH_SO_UPDATE_NON_GL}  <CONFIG_PARTNER_ID>  ${g_partner_id}
    ${R_PATH_SO_UPDATE_NON_GL}=  Replace String   ${R_PATH_SO_UPDATE_NON_GL}  <SALES_ORDER_KEY>    ${salesOrderKey}
    ##### HTTP Request
    Create Http Context     ${R_ENDPOINT_ORDERSTORE}    http
    Set Request Header      Content-Type   ${R_CONTENT_TYPE}
    Set Request Body        ${update_non_gl_body}
    POST                    ${R_PATH_SO_UPDATE_NON_GL}
    Response Status Code Should Equal    200
    ${resultJSONBody}=    Get Response Body
    Should Be Equal    "success"  ${resultJSONBody}

Unable to update Sales Order with error
    [Arguments]   ${salesOrderKey}   ${update_non_gl_body}  ${response_message}
    ${R_PATH_SO_UPDATE_NON_GL}=  Replace String   ${R_PATH_SO_UPDATE_NON_GL}  <CONFIG_PARTNER_ID>  ${g_partner_id}
    ${R_PATH_SO_UPDATE_NON_GL}=  Replace String   ${R_PATH_SO_UPDATE_NON_GL}  <SALES_ORDER_KEY>    ${salesOrderKey}
    ##### HTTP Request
    Create Http Context     ${R_ENDPOINT_ORDERSTORE}    http
    Set Request Header      Content-Type   ${R_CONTENT_TYPE}
    Set Request Body        ${update_non_gl_body}
    Next Request May Not Succeed
    POST                    ${R_PATH_SO_UPDATE_NON_GL}
    # Response Status Code Should Equal    400
    ${responseStatus}=    Get Response Status
    ${resultJSONBody}=    Get Response Body
    Should Contain    ${responseStatus}   400 Bad Request
    Should Contain     ${resultJSONBody}   ${response_message}
