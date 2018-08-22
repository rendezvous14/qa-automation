*** Settings ***
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
SO_SEARCH_001_SEARCH_SAMEDAY_NONCOD_LAZTH_INPROGRESS_FFRESERVED
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    SAME_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    NON_COD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    Comment    ########## Test Search ##########
    Login to admin    ${SO_ENDPOINT_SALE_ORDER_LIST}/
    sleep    ${SLEEP_2_S}
    Wait Until Page Contains Element    //*[@id="advanceSearchBtn"]
    Click Element    //*[@id="advanceSearchBtn"]
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by invalid accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}X
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Next day) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(NON COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Dialogs.Pause Execution
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(NON COD) and Sale channel(Lazada Thailand) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(NON COD) and Sale channel(Mataharimall) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Mataharimall"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(NON COD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(NON COD) and Sale channel(Lazada Thailand) and Order status(CANCELLED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-CANCELLED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(NON COD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) and FF status(RESERVED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="leadingFulfillStatusSelect"]
    Click Element    //*[@id="ffo_status-RESERVED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    Shipping status
    Comment    Date create
    Comment    Last modified
    [Teardown]    Clean data    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'    ${so_key}    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}' | ${so_key}

SO_SEARCH_002_SEARCH_SAMEDAY_NONCOD_LAZTH_INPROGRESS_FFXXX
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    15
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    30
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    SAME_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    NON_COD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    Comment    ########## Test Search ##########
    Login to admin    ${SO_ENDPOINT_SALE_ORDER_LIST}/
    sleep    ${SLEEP_2_S}
    Wait Until Page Contains Element    //*[@id="advanceSearchBtn"]
    Click Element    //*[@id="advanceSearchBtn"]
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    NEW
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by invalid accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}X
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    NEW
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Next day) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(NON COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    NEW
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Dialogs.Pause Execution
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(NON COD) and Sale channel(Lazada Thailand) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    NEW
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(NON COD) and Sale channel(Mataharimall) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Mataharimall"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(NON COD) and Sale channel(Lazada Thailand) and Order status(NEW) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(NON COD) and Sale channel(Lazada Thailand) and Order status(CANCELLED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-CANCELLED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(NON COD) and Sale channel(Lazada Thailand) and Order status(NEW) and FF status(RESERVED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="leadingFulfillStatusSelect"]
    Click Element    //*[@id="ffo_status-RESERVED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    Shipping status
    Comment    Date create
    Comment    Last modified
    [Teardown]    Clean data    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'    ${so_key}    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}' | ${so_key}

SO_SEARCH_003_SEARCH_SAMEDAY_COD_LAZTH_INPROGRESS_FFRESERVED
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    SAME_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    COD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    Comment    ########## Test Search ##########
    Login to admin    ${SO_ENDPOINT_SALE_ORDER_LIST}/
    sleep    ${SLEEP_2_S}
    Wait Until Page Contains Element    //*[@id="advanceSearchBtn"]
    Click Element    //*[@id="advanceSearchBtn"]
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by invalid accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}X
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Next day) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(NON_COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Dialogs.Pause Execution
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) and Sale channel(Lazada Thailand) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) and Sale channel(Mataharimall) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Mataharimall"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) and Sale channel(Lazada Thailand) and Order status(CANCELLED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-CANCELLED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) and FF status(RESERVED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="leadingFulfillStatusSelect"]
    Click Element    //*[@id="ffo_status-RESERVED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    Shipping status
    Comment    Date create
    Comment    Last modified
    [Teardown]    Clean data    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'    ${so_key}    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}' | ${so_key}

SO_SEARCH_004_SEARCH_SAMEDAY_COD_LAZTH_INPROGRESS_FFXXX
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    SAME_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    COD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    Comment    ########## Test Search ##########
    Login to admin    ${SO_ENDPOINT_SALE_ORDER_LIST}/
    sleep    ${SLEEP_2_S}
    Wait Until Page Contains Element    //*[@id="advanceSearchBtn"]
    Click Element    //*[@id="advanceSearchBtn"]
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by invalid accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}X
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Next day) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(NON_COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Dialogs.Pause Execution
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) and Sale channel(Lazada Thailand) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) and Sale channel(Mataharimall) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Mataharimall"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) and Sale channel(Lazada Thailand) and Order status(CANCELLED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-CANCELLED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) and FF status(RESERVED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="leadingFulfillStatusSelect"]
    Click Element    //*[@id="ffo_status-RESERVED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    Shipping status
    Comment    Date create
    Comment    Last modified
    [Teardown]    Clean data    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'    ${so_key}    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}' | ${so_key}

SO_SEARCH_005_SEARCH_SAMEDAY_CCOD_LAZTH_INPROGRESS_FFRESERVED
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    SAME_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    CCOD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    Comment    ########## Test Search ##########
    Login to admin    ${SO_ENDPOINT_SALE_ORDER_LIST}/
    sleep    ${SLEEP_2_S}
    Wait Until Page Contains Element    //*[@id="advanceSearchBtn"]
    Click Element    //*[@id="advanceSearchBtn"]
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by invalid accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}X
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Next day) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(CCOD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Dialogs.Pause Execution
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(CCOD) and Sale channel(Lazada Thailand) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(CCOD) and Sale channel(Mataharimall) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Mataharimall"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(CCOD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(CCOD) and Sale channel(Lazada Thailand) and Order status(CANCELLED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-CANCELLED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(CCOD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) and FF status(RESERVED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="leadingFulfillStatusSelect"]
    Click Element    //*[@id="ffo_status-RESERVED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    Shipping status
    Comment    Date create
    Comment    Last modified
    [Teardown]    Clean data    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'    ${so_key}    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}' | ${so_key}

SO_SEARCH_006_SEARCH_SAMEDAY_CCOD_LAZTH_INPROGRESS_FFXXX
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    SAME_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    CCOD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    Comment    ########## Test Search ##########
    Login to admin    ${SO_ENDPOINT_SALE_ORDER_LIST}/
    sleep    ${SLEEP_2_S}
    Wait Until Page Contains Element    //*[@id="advanceSearchBtn"]
    Click Element    //*[@id="advanceSearchBtn"]
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by invalid accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}X
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Next day) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(CCOD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Dialogs.Pause Execution
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(CCOD) and Sale channel(Lazada Thailand) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(CCOD) and Sale channel(Mataharimall) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Mataharimall"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(CCOD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    SAME_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(CCOD) and Sale channel(Lazada Thailand) and Order status(CANCELLED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-CANCELLED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) and Payment type(CCOD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) and FF status(RESERVED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="leadingFulfillStatusSelect"]
    Click Element    //*[@id="ffo_status-RESERVED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    Shipping status
    Comment    Date create
    Comment    Last modified
    [Teardown]    Clean data    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'    ${so_key}    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}' | ${so_key}

SO_SEARCH_007_SEARCH_NEXTDAY_NONCOD_LAZTH_INPROGRESS_FFRESERVED
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    NEXT_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    NON_COD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    Comment    ########## Test Search ##########
    Login to admin    ${SO_ENDPOINT_SALE_ORDER_LIST}/
    sleep    ${SLEEP_2_S}
    Wait Until Page Contains Element    //*[@id="advanceSearchBtn"]
    Click Element    //*[@id="advanceSearchBtn"]
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by invalid accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}X
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Next day) ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Next day) and Payment type(NON COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Next day) and Payment type(COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Dialogs.Pause Execution
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Next day) and Payment type(NON COD) and Sale channel(Lazada Thailand) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Next day) and Payment type(NON COD) and Sale channel(Mataharimall) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Mataharimall"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Next day) and Payment type(NON COD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Next day) and Payment type(NON COD) and Sale channel(Lazada Thailand) and Order status(CANCELLED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-CANCELLED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Next day) and Payment type(NON COD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) and FF status(RESERVED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="leadingFulfillStatusSelect"]
    Click Element    //*[@id="ffo_status-RESERVED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    Shipping status
    Comment    Date create
    Comment    Last modified
    [Teardown]    Clean data    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'    ${so_key}    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}' | ${so_key}

SO_SEARCH_008_SEARCH_NEXTDAY_NONCOD_LAZTH_INPROGRESS_FFXXX
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    15
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    30
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    NEXT_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    NON_COD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    Comment    ########## Test Search ##########
    Login to admin    ${SO_ENDPOINT_SALE_ORDER_LIST}/
    sleep    ${SLEEP_2_S}
    Wait Until Page Contains Element    //*[@id="advanceSearchBtn"]
    Click Element    //*[@id="advanceSearchBtn"]
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    NEW
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by invalid accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}X
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Next day) ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    NEW
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Next day) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Next day) and Payment type(NON COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    NEW
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Next day) and Payment type(COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Dialogs.Pause Execution
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Next day) and Payment type(NON COD) and Sale channel(Lazada Thailand) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    NEW
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Next day) and Payment type(NON COD) and Sale channel(Mataharimall) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Mataharimall"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Next day) and Payment type(NON COD) and Sale channel(Lazada Thailand) and Order status(NEW) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    NON_COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Next day) and Payment type(NON COD) and Sale channel(Lazada Thailand) and Order status(CANCELLED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-CANCELLED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Next day) and Payment type(NON COD) and Sale channel(Lazada Thailand) and Order status(NEW) and FF status(RESERVED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="leadingFulfillStatusSelect"]
    Click Element    //*[@id="ffo_status-RESERVED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    Shipping status
    Comment    Date create
    Comment    Last modified
    [Teardown]    Clean data    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'    ${so_key}    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}' | ${so_key}

SO_SEARCH_009_SEARCH_NEXTDAY_COD_LAZTH_INPROGRESS_FFRESERVED
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    NEXT_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    COD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    Comment    ########## Test Search ##########
    Login to admin    ${SO_ENDPOINT_SALE_ORDER_LIST}/
    sleep    ${SLEEP_2_S}
    Wait Until Page Contains Element    //*[@id="advanceSearchBtn"]
    Click Element    //*[@id="advanceSearchBtn"]
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by invalid accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}X
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(NON_COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Dialogs.Pause Execution
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(COD) and Sale channel(Lazada Thailand) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(COD) and Sale channel(Mataharimall) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Mataharimall"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(COD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(COD) and Sale channel(Lazada Thailand) and Order status(CANCELLED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-CANCELLED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(COD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) and FF status(RESERVED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="leadingFulfillStatusSelect"]
    Click Element    //*[@id="ffo_status-RESERVED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    Shipping status
    Comment    Date create
    Comment    Last modified
    [Teardown]    Clean data    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'    ${so_key}    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}' | ${so_key}

SO_SEARCH_010_SEARCH_NEXTDAY_COD_LAZTH_INPROGRESS_FFXXX
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    NEXT_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    COD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    Comment    ########## Test Search ##########
    Login to admin    ${SO_ENDPOINT_SALE_ORDER_LIST}/
    sleep    ${SLEEP_2_S}
    Wait Until Page Contains Element    //*[@id="advanceSearchBtn"]
    Click Element    //*[@id="advanceSearchBtn"]
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by invalid accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}X
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(Same day) ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(NON_COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-NON_COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Dialogs.Pause Execution
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(COD) and Sale channel(Lazada Thailand) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(COD) and Sale channel(Mataharimall) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Mataharimall"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(COD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    COD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(COD) and Sale channel(Lazada Thailand) and Order status(CANCELLED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-CANCELLED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(COD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) and FF status(RESERVED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="leadingFulfillStatusSelect"]
    Click Element    //*[@id="ffo_status-RESERVED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    Shipping status
    Comment    Date create
    Comment    Last modified
    [Teardown]    Clean data    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'    ${so_key}    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}' | ${so_key}

SO_SEARCH_011_SEARCH_NEXTDAY_CCOD_LAZTH_INPROGRESS_FFRESERVED
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    NEXT_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    CCOD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    NEXT_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    CCOD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    Comment    ########## Test Search ##########
    Login to admin    ${SO_ENDPOINT_SALE_ORDER_LIST}/
    sleep    ${SLEEP_2_S}
    Wait Until Page Contains Element    //*[@id="advanceSearchBtn"]
    Click Element    //*[@id="advanceSearchBtn"]
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by invalid accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}X
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(CCOD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Dialogs.Pause Execution
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(CCOD) and Sale channel(Lazada Thailand) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(CCOD) and Sale channel(Mataharimall) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Mataharimall"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(CCOD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(CCOD) and Sale channel(Lazada Thailand) and Order status(CANCELLED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-CANCELLED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(CCOD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) and FF status(RESERVED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="leadingFulfillStatusSelect"]
    Click Element    //*[@id="ffo_status-RESERVED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    Shipping status
    Comment    Date create
    Comment    Last modified
    [Teardown]    Clean data    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'    ${so_key}    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}' | ${so_key}

SO_SEARCH_012_SEARCH_NEXTDAY_CCOD_LAZTH_INPROGRESS_FFXXX
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    NEXT_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    CCOD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    NEXT_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    CCOD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    Comment    ########## Test Search ##########
    Login to admin    ${SO_ENDPOINT_SALE_ORDER_LIST}/
    sleep    ${SLEEP_2_S}
    Wait Until Page Contains Element    //*[@id="advanceSearchBtn"]
    Click Element    //*[@id="advanceSearchBtn"]
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    sleep    ${SLEEP_2_S}
    Comment    ########## Search by invalid accounting order ID ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}X
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) ##########
    Input Text    //*[@id="accountingOrderIdSearchBox"]    ${so_id}
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(Same day) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-SAME_DAY"]/a
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(CCOD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    sleep    ${SLEEP_2_S}
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(COD) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-COD"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Dialogs.Pause Execution
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(CCOD) and Sale channel(Lazada Thailand) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(CCOD) and Sale channel(Mataharimall) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Mataharimall"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(CCOD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/thead/tr/th[7]/b    Sales Channel
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[2]/a    ${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[3]    ${prefix_upper}${so_id}
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[4]    Order shipment addressee
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[5]    NEXT_DAY
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[6]    CCOD
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[7]    Lazada Thailand
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[8]    200.00 THB
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td[9]    IN_PROGRESS
    Element Text Should Be    //*[@id="main-container"]/app-root/div/sales-order-list/div[2]/div/div/div/div/div[3]/div/app-pagination/div/div/div/div[1]/div/p    Showing 1 to 1 of 1 entries
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(CCOD) and Sale channel(Lazada Thailand) and Order status(CANCELLED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-CANCELLED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    ########## Search by accounting order ID and Shipping type(NEXT_DAY) and Payment type(CCOD) and Sale channel(Lazada Thailand) and Order status(IN_PROGRESS) and FF status(RESERVED) ##########
    Click Element    //*[@id="shippingTypeSelect"]
    Click Element    //*[@id="shipping_type-NEXT_DAY"]/a
    Click Element    //*[@id="paymentTypeSelect"]
    Click Element    //*[@id="payment_type-CCOD"]
    Click Element    //*[@id="salesSubChannelSelect"]
    Click Element    //*[@id="sales_sub_ch-Lazada Thailand"]
    Click Element    //*[@id="orderStatusSelect"]
    Click Element    //*[@id="so_status-IN_PROGRESS"]
    Click Element    //*[@id="leadingFulfillStatusSelect"]
    Click Element    //*[@id="ffo_status-RESERVED"]
    Click Element    //*[@id="sales-order-search-form"]/div/div/div/div/div[4]/div/button
    Element Text Should Be    //*[@id="element_list"]/tbody/tr/td    No orders.
    Comment    Shipping status
    Comment    Date create
    Comment    Last modified
    [Teardown]    Clean data    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'    ${so_key}    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}' | ${so_key}
