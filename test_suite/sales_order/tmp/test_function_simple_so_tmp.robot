*** Settings ***
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
SO_SIMPLE_001_[General][FIFO] Create single item, line and no serial number
    # Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}'
    # Comment    ###### Create PO ######
    # Prepare po for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    # ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    # ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    # ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    # ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    # ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    # ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID    ${ITEM_QA2_G_FIFO_001}
    # ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    # ...    ${SO_X_ROLE}
    # ${po_key}    Replace String    ${response}    "    ${EMPTY}
    # log    ${po_key}
    # sleep    ${SLEEP_2_S}
    # Comment    ########## Simulate Putaway message from Scale ##########
    # ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    # ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    # Putaway Complete Upload    ${putaway_body}
    # sleep    ${SLEEP_2_S}
    # Comment    ###### Simulate GRN message from Scale ######
    # ${grn_body}=    Prepare grn mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}
    # ...    10.00000
    # Grn Upload    ${grn_body}
    # sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${ITEM_QA2_G_FIFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    # log    ${response}
    # ${so_key}=    Get Json Value    ${response}    /key
    # ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    # log    ${so_key}
    # sleep    ${SLEEP_5_S}
    # ###    monitor_order_status
    # ###    so_status_monitor
    # ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    # ...    ${SO_X_ROLE}    ${HTTP_GET}
    # log    ${response}
    # ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    # ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    # log    ${fo_key}
    # Comment    ###### Simulate Picking pending ######
    # Prepare picking pending for scale
    # ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    # ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    # ff_allocate_upload    ${REQUEST_BODY}
    # sleep    ${SLEEP_2_S}
    # ###    so_prism_status_monitor
    # Comment    ###### Simulate Order confirm ######
    # Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM}
    # ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    # ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    # ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_G_FIFO_001_KEY}
    # ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    # ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-General
    # order_confirm_upload    ${REQUEST_BODY}
    # sleep    ${SLEEP_2_S}
    # [Teardown]    Clean data    '${ITEM_QA2_G_FIFO_001_KEY}'    ${so_key}

SO_SIMPLE_002_[HIGH][FIFO] Create single item, line and no serial number
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}'
    Comment    ###### Create PO ######
    Prepare po for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID    ${ITEM_QA2_H_FIFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}
    ...    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${ITEM_QA2_H_FIFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_H_FIFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-High Value
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    Clean data    '${ITEM_QA2_H_FIFO_001_KEY}'    ${so_key}

SO_SIMPLE_003_[COOL][FIFO] Create single item, line and no serial number
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FIFO_001_KEY}'
    Comment    ###### Create PO ######
    Prepare po for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID    ${ITEM_QA2_C_FIFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}
    ...    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${ITEM_QA2_C_FIFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_C_FIFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-Cool Room
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    Clean data    '${ITEM_QA2_C_FIFO_001_KEY}'    ${so_key}

SO_SIMPLE_004_[General][FEFO] Create single item, line and no serial number
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FEFO_001_KEY}'
    Comment    ###### Create PO ######
    Prepare po for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID    ${ITEM_QA2_G_FEFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FEFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn mock data    ${po_key}    ${ITEM_QA2_G_FEFO_001_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}
    ...    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${ITEM_QA2_G_FEFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_G_FEFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-General
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    Clean data    '${ITEM_QA2_G_FEFO_001_KEY}'    ${so_key}

SO_SIMPLE_005_[HIGH][FEFO] Create single item, line and no serial number
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FEFO_001_KEY}'
    Comment    ###### Create PO ######
    Prepare po for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID    ${ITEM_QA2_H_FEFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FEFO_001_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn mock data    ${po_key}    ${ITEM_QA2_H_FEFO_001_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}
    ...    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${ITEM_QA2_H_FEFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_H_FEFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-High Value
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    Clean data    '${ITEM_QA2_H_FEFO_001_KEY}'    ${so_key}

SO_SIMPLE_006_[COOL][FEFO] Create single item, line and no serial number
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FEFO_001_KEY}'
    Comment    ###### Create PO ######
    Prepare po for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID    ${ITEM_QA2_C_FEFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FEFO_001_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn mock data    ${po_key}    ${ITEM_QA2_C_FEFO_001_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}
    ...    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${ITEM_QA2_C_FEFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_C_FEFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-Cool Room
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    Clean data    '${ITEM_QA2_C_FEFO_001_KEY}'    ${so_key}

SO_SIMPLE_007_[GENERAL][FIFO] Create single item, line and Serial Track Item (multiple qty)
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}'
    Comment    ###### Create PO ######
    Prepare po for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID    ${ITEM_QA2_G_FIFO_001}
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
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}
    ...    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${ITEM_QA2_G_FIFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_WITH_3_SN}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_G_FIFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_1    SN_${date_time}_1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_2    SN_${date_time}_2
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_3    SN_${date_time}_3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-General
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}' | ${so_key}

SO_SIMPLE_008_[HIGH][FIFO] Create single item, line and Serial Track Item (multiple qty)
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}'
    Comment    ###### Create PO ######
    Prepare po for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID    ${ITEM_QA2_H_FIFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}
    ...    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${ITEM_QA2_H_FIFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_WITH_3_SN}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_H_FIFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_1    SN_${date_time}_1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_2    SN_${date_time}_2
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_3    SN_${date_time}_3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-High Value
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    # Clean data | '${ITEM_QA2_H_FIFO_001_KEY}' | ${so_key}

SO_SIMPLE_009_[COOL][FIFO] Create single item, line and Serial Track Item (multiple qty)
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FIFO_001_KEY}'
    Comment    ###### Create PO ######
    Prepare po for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID    ${ITEM_QA2_C_FIFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}
    ...    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${ITEM_QA2_C_FIFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_WITH_3_SN}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_C_FIFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_1    SN_${date_time}_1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_2    SN_${date_time}_2
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_3    SN_${date_time}_3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-Cool Room
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    # Clean data | '${ITEM_QA2_C_FIFO_001_KEY}' | ${so_key}

SO_SIMPLE_010_[GENERAL][FEFO] Create single item, line and Serial Track Item (multiple qty)
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FEFO_001_KEY}'
    Comment    ###### Create PO ######
    Prepare po for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID    ${ITEM_QA2_G_FEFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FEFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn mock data    ${po_key}    ${ITEM_QA2_G_FEFO_001_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}
    ...    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${ITEM_QA2_G_FEFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_WITH_3_SN}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_G_FEFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_1    SN_${date_time}_1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_2    SN_${date_time}_2
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_3    SN_${date_time}_3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-General
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    # Clean data | '${ITEM_QA2_G_FEFO_001_KEY}' | ${so_key}

SO_SIMPLE_011_[HIGH][FEFO] Create single item, line and Serial Track Item (multiple qty)
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FEFO_001_KEY}'
    Comment    ###### Create PO ######
    Prepare po for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID    ${ITEM_QA2_H_FEFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FEFO_001_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn mock data    ${po_key}    ${ITEM_QA2_H_FEFO_001_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}
    ...    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${ITEM_QA2_H_FEFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_WITH_3_SN}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_H_FEFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_1    SN_${date_time}_1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_2    SN_${date_time}_2
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_3    SN_${date_time}_3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-High Value
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    # Clean data | '${ITEM_QA2_H_FEFO_001_KEY}' | ${so_key}

SO_SIMPLE_012_[COOL][FEFO] Create single item, line and Serial Track Item (multiple qty)
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FEFO_001_KEY}'
    Comment    ###### Create PO ######
    Prepare po for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID    ${ITEM_QA2_C_FEFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FEFO_001_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn mock data    ${po_key}    ${ITEM_QA2_C_FEFO_001_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}
    ...    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID    ${ITEM_QA2_C_FEFO_001}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_WITH_3_SN}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_C_FEFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_1    SN_${date_time}_1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_2    SN_${date_time}_2
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SN_3    SN_${date_time}_3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-Cool Room
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    # Clean data | '${ITEM_QA2_C_FEFO_001_KEY}' | ${so_key}

SO_SIMPLE_013_[GENERAL][FIFO] Create single item,multi line and No Serial Track Item (multiple qty)
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
    Prepare so with two product for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_TWO_ITEM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_G_FIFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-General
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2    ${ITEM_QA2_G_FIFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_2    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-General
    log    ${REQUEST_BODY}
    Comment    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    Comment    Login to admin    ${ENDPOINT_SALE_ORDER}/${so_key}
    Comment    Wait Until Page Contains Element    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4
    Comment    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4    Status : IN_PROGRESS
    Comment    ${REQUEST_BODY}    Get File    ${TEMPLATE_CANCEL_REASON}
    Comment    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    /os/item-sales-orders/${so_key}/cancel/
    ...    ${SO_PARTNER_ID}    ${SO_X_ROLE}    ${HTTP_POST}
    Comment    log    ${response}
    Comment    sleep    ${SLEEP_2_S}
    Comment    Goto    ${ENDPOINT_SALE_ORDER}/${so_key}
    Comment    Wait Until Page Contains Element    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4
    Comment    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4    Status : Cancelling...
    [Teardown]    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}' | ${so_key}

SO_SIMPLE_014_[HIGH][FIFO] Create single item,multi line and No Serial Track Item (multiple qty)
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_H_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_H_FIFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so with two product for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_H_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_H_FIFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_TWO_ITEM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_H_FIFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-High Value
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2    ${ITEM_QA2_H_FIFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_2    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-High Value
    log    ${REQUEST_BODY}
    Comment    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    Comment    Login to admin    ${ENDPOINT_SALE_ORDER}/${so_key}
    Comment    Wait Until Page Contains Element    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4
    Comment    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4    Status : IN_PROGRESS
    Comment    ${REQUEST_BODY}    Get File    ${TEMPLATE_CANCEL_REASON}
    Comment    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    /os/item-sales-orders/${so_key}/cancel/
    ...    ${SO_PARTNER_ID}    ${SO_X_ROLE}    ${HTTP_POST}
    Comment    log    ${response}
    Comment    sleep    ${SLEEP_2_S}
    Comment    Goto    ${ENDPOINT_SALE_ORDER}/${so_key}
    Comment    Wait Until Page Contains Element    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4
    Comment    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4    Status : Cancelling...
    [Teardown]    # Clean data | '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}' | ${so_key}

SO_SIMPLE_015_[COOL][FIFO] Create single item,multi line and No Serial Track Item (multiple qty)
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_C_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_C_FIFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so with two product for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_C_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_C_FIFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_TWO_ITEM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_C_FIFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-Cool Room
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2    ${ITEM_QA2_C_FIFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_2    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-Cool Room
    log    ${REQUEST_BODY}
    Comment    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    Comment    Login to admin    ${ENDPOINT_SALE_ORDER}/${so_key}
    Comment    Wait Until Page Contains Element    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4
    Comment    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4    Status : IN_PROGRESS
    Comment    ${REQUEST_BODY}    Get File    ${TEMPLATE_CANCEL_REASON}
    Comment    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    /os/item-sales-orders/${so_key}/cancel/
    ...    ${SO_PARTNER_ID}    ${SO_X_ROLE}    ${HTTP_POST}
    Comment    log    ${response}
    Comment    sleep    ${SLEEP_2_S}
    Comment    Goto    ${ENDPOINT_SALE_ORDER}/${so_key}
    Comment    Wait Until Page Contains Element    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4
    Comment    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4    Status : Cancelling...
    [Teardown]    # Clean data | '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}' | ${so_key}

SO_SIMPLE_016_[GENERAL][FEFO] Create single item,multi line and No Serial Track Item (multiple qty)
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FEFO_001_KEY}','${ITEM_QA2_G_FEFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FEFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FEFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FEFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FEFO_001_KEY}    ${ITEM_QA2_G_FEFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so with two product for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FEFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_TWO_ITEM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_G_FEFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-General
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2    ${ITEM_QA2_G_FEFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_2    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-General
    log    ${REQUEST_BODY}
    Comment    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    Comment    Login to admin    ${ENDPOINT_SALE_ORDER}/${so_key}
    Comment    Wait Until Page Contains Element    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4
    Comment    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4    Status : IN_PROGRESS
    Comment    ${REQUEST_BODY}    Get File    ${TEMPLATE_CANCEL_REASON}
    Comment    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    /os/item-sales-orders/${so_key}/cancel/
    ...    ${SO_PARTNER_ID}    ${SO_X_ROLE}    ${HTTP_POST}
    Comment    log    ${response}
    Comment    sleep    ${SLEEP_2_S}
    Comment    Goto    ${ENDPOINT_SALE_ORDER}/${so_key}
    Comment    Wait Until Page Contains Element    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4
    Comment    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4    Status : Cancelling...
    [Teardown]    # Clean data | '${ITEM_QA2_G_FEFO_001_KEY}','${ITEM_QA2_G_FEFO_002_KEY}' | ${so_key}

SO_SIMPLE_017_[HIGH][FEFO] Create single item,multi line and No Serial Track Item (multiple qty)
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FEFO_001_KEY}','${ITEM_QA2_H_FEFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_H_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_H_FEFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FEFO_001_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FEFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FEFO_001_KEY}    ${ITEM_QA2_H_FEFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so with two product for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_H_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_H_FEFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_TWO_ITEM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_H_FEFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-High Value
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2    ${ITEM_QA2_H_FEFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_2    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-High Value
    log    ${REQUEST_BODY}
    Comment    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    Comment    Login to admin    ${ENDPOINT_SALE_ORDER}/${so_key}
    Comment    Wait Until Page Contains Element    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4
    Comment    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4    Status : IN_PROGRESS
    Comment    ${REQUEST_BODY}    Get File    ${TEMPLATE_CANCEL_REASON}
    Comment    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    /os/item-sales-orders/${so_key}/cancel/
    ...    ${SO_PARTNER_ID}    ${SO_X_ROLE}    ${HTTP_POST}
    Comment    log    ${response}
    Comment    sleep    ${SLEEP_2_S}
    Comment    Goto    ${ENDPOINT_SALE_ORDER}/${so_key}
    Comment    Wait Until Page Contains Element    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4
    Comment    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4    Status : Cancelling...
    [Teardown]    # Clean data | '${ITEM_QA2_H_FEFO_001_KEY}','${ITEM_QA2_H_FEFO_002_KEY}' | ${so_key}

SO_SIMPLE_018_[COOL][FEFO] Create single item,multi line and No Serial Track Item (multiple qty)
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FEFO_001_KEY}','${ITEM_QA2_C_FEFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 2 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_C_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_C_FEFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FEFO_001_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FEFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_C_FEFO_001_KEY}    ${ITEM_QA2_C_FEFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare so with two product for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_C_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_C_FEFO_002}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    sleep    ${SLEEP_5_S}
    ###    monitor_order_status
    ###    so_status_monitor
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_TWO_ITEM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_C_FEFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-Cool Room
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2    ${ITEM_QA2_C_FEFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_2    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-Cool Room
    log    ${REQUEST_BODY}
    Comment    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    Comment    Login to admin    ${ENDPOINT_SALE_ORDER}/${so_key}
    Comment    Wait Until Page Contains Element    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4
    Comment    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4    Status : IN_PROGRESS
    Comment    ${REQUEST_BODY}    Get File    ${TEMPLATE_CANCEL_REASON}
    Comment    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    /os/item-sales-orders/${so_key}/cancel/
    ...    ${SO_PARTNER_ID}    ${SO_X_ROLE}    ${HTTP_POST}
    Comment    log    ${response}
    Comment    sleep    ${SLEEP_2_S}
    Comment    Goto    ${ENDPOINT_SALE_ORDER}/${so_key}
    Comment    Wait Until Page Contains Element    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4
    Comment    Element Text Should Be    //*[@id="main-container"]/app-root/div/app-sales-order-detail/div[2]/div/div/div/div[1]/div[2]/h4    Status : Cancelling...
    [Teardown]    # Clean data | '${ITEM_QA2_C_FEFO_001_KEY}','${ITEM_QA2_C_FEFO_002_KEY}' | ${so_key}

SO_SIMPLE_019_[GENERAL][FIFO][FEFO] Create so with 2 products 2 item
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}','${ITEM_QA2_G_FEFO_001_KEY}','${ITEM_QA2_G_FEFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 4 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_3    ${ITEM_QA2_G_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_4    ${ITEM_QA2_G_FEFO_002}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FEFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    3.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FEFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    4.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 4 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    ${ITEM_QA2_G_FEFO_001_KEY}    ${ITEM_QA2_G_FEFO_002_KEY}
    ...    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}    10.00000    10.00000    10.00000
    ...    10.00000
    log    ${grn_body}
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so    ${TEMPLATE_SO_TWO_PRODUCT_TWO_ITEM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1_2    ${ITEM_QA2_G_FIFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2_2    ${ITEM_QA2_G_FEFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    SAME_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    NON_COD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_AMOUNT_1    75
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_AMOUNT_2    105
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_TOTAL    180
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_COLLECTION_AMOUNT    500
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    sleep    ${SLEEP_5_S}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_TWO_PRODUCT}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1_1    ${ITEM_QA2_G_FIFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_G_FIFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-General
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2_2    ${ITEM_QA2_G_FEFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2    ${ITEM_QA2_G_FEFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_2    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-General
    log    ${REQUEST_BODY}
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}','${ITEM_QA2_G_FEFO_001_KEY}','${ITEM_QA2_G_FEFO_002_KEY}' | ${so_key}

SO_SIMPLE_020_[HIGH][FIFO][FEFO] Create so with 2 products 2 item
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}','${ITEM_QA2_H_FEFO_001_KEY}','${ITEM_QA2_H_FEFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 4 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_H_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_H_FIFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_3    ${ITEM_QA2_H_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_4    ${ITEM_QA2_H_FEFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FEFO_001_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    3.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FEFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    4.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 4 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    ${ITEM_QA2_H_FEFO_001_KEY}    ${ITEM_QA2_H_FEFO_002_KEY}
    ...    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}    10.00000    10.00000    10.00000
    ...    10.00000
    log    ${grn_body}
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so    ${TEMPLATE_SO_TWO_PRODUCT_TWO_ITEM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1_2    ${ITEM_QA2_H_FIFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_H_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2_2    ${ITEM_QA2_H_FEFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_H_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    SAME_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    NON_COD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_AMOUNT_1    75
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_AMOUNT_2    105
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_TOTAL    180
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_COLLECTION_AMOUNT    500
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    sleep    ${SLEEP_5_S}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_TWO_PRODUCT}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1_1    ${ITEM_QA2_H_FIFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_H_FIFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-High Value
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2_2    ${ITEM_QA2_H_FEFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2    ${ITEM_QA2_H_FEFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_2    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-High Value
    log    ${REQUEST_BODY}
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    # Clean data | '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}','${ITEM_QA2_H_FEFO_001_KEY}','${ITEM_QA2_H_FEFO_002_KEY}' | ${so_key}

SO_SIMPLE_021_[COOL][FIFO][FEFO] Create so with 2 products 2 item
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}','${ITEM_QA2_C_FEFO_001_KEY}','${ITEM_QA2_C_FEFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 4 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_C_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_C_FIFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_3    ${ITEM_QA2_C_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_4    ${ITEM_QA2_C_FEFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FEFO_001_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    3.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FEFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    4.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 4 item mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    ${ITEM_QA2_C_FIFO_002_KEY}    ${ITEM_QA2_C_FEFO_001_KEY}    ${ITEM_QA2_C_FEFO_002_KEY}
    ...    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}    10.00000    10.00000    10.00000
    ...    10.00000
    log    ${grn_body}
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so    ${TEMPLATE_SO_TWO_PRODUCT_TWO_ITEM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1_2    ${ITEM_QA2_C_FIFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_C_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2_2    ${ITEM_QA2_C_FEFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_C_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    SAME_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    NON_COD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_AMOUNT_1    75
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_AMOUNT_2    105
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_TOTAL    180
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_COLLECTION_AMOUNT    500
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    sleep    ${SLEEP_5_S}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_TWO_PRODUCT}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1_1    ${ITEM_QA2_C_FIFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_C_FIFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-Cool Room
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2_2    ${ITEM_QA2_C_FEFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2    ${ITEM_QA2_C_FEFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_2    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-Cool Room
    log    ${REQUEST_BODY}
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    # Clean data | '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}','${ITEM_QA2_C_FEFO_001_KEY}','${ITEM_QA2_C_FEFO_002_KEY}' | ${so_key}

SO_SIMPLE_022_[GENERAL][HIGH][FIFO][FEFO] Create so with 2 products 2 item
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}','${ITEM_QA2_H_FEFO_001_KEY}','${ITEM_QA2_H_FEFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 4 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_3    ${ITEM_QA2_H_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_4    ${ITEM_QA2_H_FEFO_002}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FEFO_001_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    3.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FEFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    4.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 4 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    ${ITEM_QA2_H_FEFO_001_KEY}    ${ITEM_QA2_H_FEFO_002_KEY}
    ...    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}    10.00000    10.00000    10.00000
    ...    10.00000
    log    ${grn_body}
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so    ${TEMPLATE_SO_TWO_PRODUCT_TWO_ITEM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1_2    ${ITEM_QA2_G_FIFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2_2    ${ITEM_QA2_H_FEFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_H_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    SAME_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    NON_COD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_AMOUNT_1    75
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_AMOUNT_2    105
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_TOTAL    180
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_COLLECTION_AMOUNT    500
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    sleep    ${SLEEP_5_S}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_TWO_PRODUCT}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1_1    ${ITEM_QA2_G_FIFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_G_FIFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-General
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2_2    ${ITEM_QA2_H_FEFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2    ${ITEM_QA2_H_FEFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_2    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-High Value
    log    ${REQUEST_BODY}
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}','${ITEM_QA2_H_FEFO_001_KEY}','${ITEM_QA2_H_FEFO_002_KEY}' | ${so_key}

SO_SIMPLE_022_[GENERAL][COOL][FIFO][FEFO] Create so with 2 products 2 item
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}','${ITEM_QA2_C_FEFO_001_KEY}','${ITEM_QA2_C_FEFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 4 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_G_FIFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_3    ${ITEM_QA2_C_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_4    ${ITEM_QA2_C_FEFO_002}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FEFO_001_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    3.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FEFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    4.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 4 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    ${ITEM_QA2_C_FEFO_001_KEY}    ${ITEM_QA2_C_FEFO_002_KEY}
    ...    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}    10.00000    10.00000    10.00000
    ...    10.00000
    log    ${grn_body}
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so    ${TEMPLATE_SO_TWO_PRODUCT_TWO_ITEM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1_2    ${ITEM_QA2_G_FIFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_G_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2_2    ${ITEM_QA2_C_FEFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_C_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    SAME_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    NON_COD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_AMOUNT_1    75
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_AMOUNT_2    105
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_TOTAL    180
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_COLLECTION_AMOUNT    500
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    sleep    ${SLEEP_5_S}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_TWO_PRODUCT}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1_1    ${ITEM_QA2_G_FIFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_G_FIFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-General
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2_2    ${ITEM_QA2_C_FEFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2    ${ITEM_QA2_C_FEFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_2    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-Cool Room
    log    ${REQUEST_BODY}
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    # Clean data | '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}','${ITEM_QA2_C_FEFO_001_KEY}','${ITEM_QA2_C_FEFO_002_KEY}' | ${so_key}

SO_SIMPLE_023_[HIGH][COOL][FIFO][FEFO] Create so with 2 products 2 item
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}','${ITEM_QA2_C_FEFO_001_KEY}','${ITEM_QA2_C_FEFO_002_KEY}'
    Comment    ###### Create PO ######
    Prepare po 4 item for scale
    ${date_time}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${current_date_sub}=    Get Substring    ${G_CURRENT_DATE}    0    10
    ${expected_date_sub}=    Get Substring    ${G_EXPECTED_RECEIVED_DATE}    0    10
    ${partner_po_id_gen}=    Set Variable    PO_${date_time}
    ${so_id}=    Set Variable    SO_${date_time}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PO_ID    ${partner_po_id_gen}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_1    ${ITEM_QA2_H_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_2    ${ITEM_QA2_H_FIFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_3    ${ITEM_QA2_C_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_PARTNER_ITEM_ID_4    ${ITEM_QA2_C_FEFO_002}
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_PO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    ${po_key}    Replace String    ${response}    "    ${EMPTY}
    log    ${po_key}
    sleep    ${SLEEP_2_S}
    Comment    ########## Simulate Putaway message from Scale ##########
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    1.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    2.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FEFO_001_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    3.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FEFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    4.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 4 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    ${ITEM_QA2_C_FEFO_001_KEY}    ${ITEM_QA2_C_FEFO_002_KEY}
    ...    REC_${date_time}    ${SO_PARTNER_SLUG}    ${SO_WAREHOUSE_CODE}    10.00000    10.00000    10.00000
    ...    10.00000
    log    ${grn_body}
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate SO ######
    Prepare template so    ${TEMPLATE_SO_TWO_PRODUCT_TWO_ITEM}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_EXT_SO_ID    ${so_id}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_1    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1_2    ${ITEM_QA2_H_FIFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_1    ${ITEM_QA2_H_FIFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_1    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PRODUCT_QTY_2    3
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2_2    ${ITEM_QA2_C_FEFO_002}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_ITEM_ID_2    ${ITEM_QA2_C_FEFO_001}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_QTY_2    1
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_SHIPPING_TYPE    SAME_DAY
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_PARTNER_PAYMENT_TYPE    NON_COD
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_SUB_CH_NAME    Lazada Thailand
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_TYPE    e-Marketplace
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SALE_CH_ID    LAZ
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_AMOUNT_1    75
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_AMOUNT_2    105
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_GROSS_TOTAL    180
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_COLLECTION_AMOUNT    500
    log    ${REQUEST_BODY}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_201_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_SO_PATH}    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}
    log    ${response}
    ${so_key}=    Get Json Value    ${response}    /key
    ${so_key}    Replace String    ${so_key}    "    ${EMPTY}
    log    ${so_key}
    ${prefix_upper}    Convert To Uppercase    ${SO_PREFIX}
    sleep    ${SLEEP_5_S}
    ${response}=    HttpRequest    ${REQUEST_BODY}    ${EXPECTED_STATUS_200_OK}    ${SO_ORDER_STORE_ENDPOINT}    ${SO_GET_FO_KEY}/${so_key}/    ${SO_PARTNER_ID}
    ...    ${SO_X_ROLE}    ${HTTP_GET}
    log    ${response}
    ${fo_key}=    Get Json Value    ${response}    /state/fulfillmentOrders/0/key
    ${fo_key}    Replace String    ${fo_key}    "    ${EMPTY}
    log    ${fo_key}
    Comment    ###### Simulate Picking pending ######
    Prepare picking pending for scale
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ff_allocate_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    ###    so_prism_status_monitor
    Comment    ###### Simulate Order confirm ######
    Prepare order confirm for scale    ${TEMPLATE_ORDER_CONFIRM_TWO_PRODUCT}
    ${REQUEST_BODY}=    Set Variable    ${G_REQUEST_BODY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_SHIPMENT_ID    ${fo_key}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1_1    ${ITEM_QA2_H_FIFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_1    ${ITEM_QA2_H_FIFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_1    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_1    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-High Value
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2_2    ${ITEM_QA2_C_FEFO_002_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_ITEM_KEY_2    ${ITEM_QA2_C_FEFO_001_KEY}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_LOT_ID_2    LOT_${current_date_sub}
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_QTY_2    3.00000
    ${REQUEST_BODY}    Replace String    ${REQUEST_BODY}    VAR_FROM_LOCATION_ZONE_1    W-Cool Room
    log    ${REQUEST_BODY}
    order_confirm_upload    ${REQUEST_BODY}
    sleep    ${SLEEP_2_S}
    [Teardown]    # Clean data | '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}','${ITEM_QA2_C_FEFO_001_KEY}','${ITEM_QA2_C_FEFO_002_KEY}' | ${so_key}
