*** Settings ***
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
TEST_0001_BEEH-440_INV_AVAI_BORROWING_TO_COOL
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_BORROWING
    ${result_2}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_C_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_BORROWING
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_C_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Borrowing
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Cool Room
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_borrowing,qty_coolroom    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_BORROWING
    Should Be Equal    4    ${result_3[2]}    ###QTY_COOLROOM
    [Teardown]    Clean data inventory item    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'

TEST_0002_BEEH-440_INV_AVAI_BORROWING_TO_DAMAGE
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_BORROWING
    ${result_2}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_BORROWING
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Borrowing
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Damage
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_borrowing,qty_damage    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_BORROWING
    Should Be Equal    4    ${result_3[2]}    ###QTY_DAMAGE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0003_BEEH-440_INV_AVAI_BORROWING_TO_EXPIRED
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_BORROWING
    ${result_2}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_BORROWING
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Borrowing
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Expired
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_borrowing,qty_expired    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_BORROWING
    Should Be Equal    4    ${result_3[2]}    ###QTY_EXPIRED
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0004_BEEH-440_INV_AVAI_BORROWING_TO_FOOD
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_BORROWING
    ${result_2}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_BORROWING
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Borrowing
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Food
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_borrowing,qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_BORROWING
    Should Be Equal    4    ${result_3[2]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0005_BEEH-440_INV_AVAI_BORROWING_TO_GENERAL
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_BORROWING
    ${result_2}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_BORROWING
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Borrowing
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_borrowing,qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_BORROWING
    Should Be Equal    4    ${result_3[2]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0006_BEEH-440_INV_AVAI_BORROWING_TO_LIQUID
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_BORROWING
    ${result_2}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_BORROWING
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Borrowing
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Liquid
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_borrowing,qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_BORROWING
    Should Be Equal    4    ${result_3[2]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0007_BEEH-440_INV_AVAI_BORROWING_TO_MAL
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_BORROWING
    ${result_2}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_BORROWING
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Borrowing
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Malfunction
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_borrowing,qty_malfunction    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_BORROWING
    Should Be Equal    4    ${result_3[2]}    ###QTY_MALFUNCTION
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0008_BEEH-440_INV_AVAI_BORROWING_TO_PET
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_BORROWING
    ${result_2}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_BORROWING
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Borrowing
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Pet Food
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_borrowing,qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_BORROWING
    Should Be Equal    4    ${result_3[2]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0009_BEEH-440_INV_AVAI_BORROWING_TO_HIGH
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_BORROWING
    ${result_2}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_H_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_BORROWING
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_H_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Borrowing
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-High Value
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_borrowing,qty_highvalue    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Dialogs.Pause Execution
    Should Be Equal    6    ${result_3[1]}    ###QTY_BORROWING
    Should Be Equal    4    ${result_3[2]}    ###QTY_HIGVALUE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'

TEST_0010_BEEH-440_INV_AVAI_BORROWING_TO_QUA
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_BORROWING
    ${result_2}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_BORROWING
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Borrowing
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Quarantine
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_borrowing,qty_quarantine    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_BORROWING
    Should Be Equal    4    ${result_3[2]}    ###QTY_QUARANTINE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0011_BEEH-440_INV_AVAI_BORROWING_TO_RED
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_BORROWING
    ${result_2}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_BORROWING
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Borrowing
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Red Zone
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_borrowing,qty_redzone    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_BORROWING
    Should Be Equal    4    ${result_3[2]}    ###QTY_REDZONE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0012_BEEH-440_INV_AVAI_BORROWING_TO_RMA
    log    Wait RMA design

TEST_0013_BEEH-440_INV_AVAI_COOL_TO_BORROWING
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_COOLROOM
    ${result_2}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_COOLROOM
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_C_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Cool Room
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Borrowing
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_coolroom,qty_borrowing    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_COOLROOM
    Should Be Equal    4    ${result_3[2]}    ###QTY_BORROWING
    [Teardown]    Clean data inventory item    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'

TEST_0014_BEEH-440_INV_AVAI_COOL_TO_DAMAGE
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_COOLROOM
    ${result_2}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_COOLROOM
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_C_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Cool Room
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Damage
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_coolroom,qty_damage    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_COOLROOM
    Should Be Equal    4    ${result_3[2]}    ###QTY_DAMAGE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'

TEST_0015_BEEH-440_INV_AVAI_COOL_TO_EXPIRED
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_COOLROOM
    ${result_2}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_COOLROOM
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_C_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Cool Room
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Expired
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_coolroom,qty_expired    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_COOLROOM
    Should Be Equal    4    ${result_3[2]}    ###QTY_EXPIRED
    [Teardown]    Clean data inventory item    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'

TEST_0016_BEEH-440_INV_AVAI_COOL_TO_FOOD
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_COOLROOM
    ${result_2}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_COOLROOM
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_C_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Cool Room
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Food
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_coolroom,qty_general    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_COOLROOM
    Should Be Equal    4    ${result_3[2]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'

TEST_0017_BEEH-440_INV_AVAI_COOL_TO_GENERAL
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_COOLROOM
    ${result_2}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_COOLROOM
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_C_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Cool Room
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_coolroom,qty_general    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_COOLROOM
    Should Be Equal    4    ${result_3[2]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'

TEST_0018_BEEH-440_INV_AVAI_COOL_TO_LIQUID
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_COOLROOM
    ${result_2}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_COOLROOM
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_C_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Cool Room
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Liquid
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_coolroom,qty_general    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_COOLROOM
    Should Be Equal    4    ${result_3[2]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'

TEST_0019_BEEH-440_INV_AVAI_COOL_TO_MAL
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_COOLROOM
    ${result_2}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_COOLROOM
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_C_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Cool Room
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Malfunction
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_coolroom,qty_malfunction    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_COOLROOM
    Should Be Equal    4    ${result_3[2]}    ###QTY_MALFUNCTION
    [Teardown]    Clean data inventory item    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'

TEST_0020_BEEH-440_INV_AVAI_COOL_TO_PET
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_COOLROOM
    ${result_2}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_COOLROOM
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_C_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Cool Room
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Pet Food
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_coolroom,qty_general    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_COOLROOM
    Should Be Equal    4    ${result_3[2]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'

TEST_0021_BEEH-440_INV_AVAI_COOL_TO_HIGH
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_COOLROOM
    ${result_2}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_H_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_COOLROOM
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_H_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Cool Room
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-High Value
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_coolroom,qty_highvalue    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Dialogs.Pause Execution
    Should Be Equal    6    ${result_3[1]}    ###QTY_COOLROOM
    Should Be Equal    4    ${result_3[2]}    ###QTY_HIGVALUE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'

TEST_0022_BEEH-440_INV_AVAI_COOL_TO_QUA
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_COOLROOM
    ${result_2}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_COOLROOM
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_C_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Cool Room
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Quarantine
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_coolroom,qty_quarantine    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_COOLROOM
    Should Be Equal    4    ${result_3[2]}    ###QTY_QUARANTINE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'

TEST_0023_BEEH-440_INV_AVAI_COOL_TO_RED
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_C_FIFO_001_KEY}    ${ITEM_QA2_C_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_COOLROOM
    ${result_2}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_C_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_COOLROOM
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_C_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Cool Room
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Red Zone
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_coolroom,qty_redzone    '${ITEM_QA2_C_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_COOLROOM
    Should Be Equal    4    ${result_3[2]}    ###QTY_REDZONE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_C_FIFO_001_KEY}','${ITEM_QA2_C_FIFO_002_KEY}'

TEST_0024_BEEH-440_INV_AVAI_COOL_TO_RMA
    log    Wait RMA design

TEST_0025_BEEH-440_INV_AVAI_GENERAL_TO_BORROWING
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Borrowing
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general,qty_borrowing    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_GENERAL
    Should Be Equal    4    ${result_3[2]}    ###QTY_BORROWING
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0026_BEEH-440_INV_AVAI_GENERAL_TO_DAMAGE
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Damage
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general,qty_damage    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_GENERAL
    Should Be Equal    4    ${result_3[2]}    ###QTY_DAMAGE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0027_BEEH-440_INV_AVAI_GENERAL_TO_EXPIRED
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Expired
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general,qty_expired    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_GENERAL
    Should Be Equal    4    ${result_3[2]}    ###QTY_EXPIRED
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0028_BEEH-440_INV_AVAI_GENERAL_TO_FOOD
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Food
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_3[1]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0029_BEEH-440_INV_AVAI_GENERAL_TO_COOLROOM
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Cool Room
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general,qty_coolroom    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_GENERAL
    Should Be Equal    4    ${result_3[2]}    ###QTY_COOLROOM
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0030_BEEH-440_INV_AVAI_GENERAL_TO_LIQUID
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Liquid
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_3[1]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0031_BEEH-440_INV_AVAI_GENERAL_TO_MAL
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Malfunction
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general,qty_malfunction    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_GENERAL
    Should Be Equal    4    ${result_3[2]}    ###QTY_MALFUNCTION
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0032_BEEH-440_INV_AVAI_GENERAL_TO_PET
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Pet Food
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general,qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_3[1]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0033_BEEH-440_INV_AVAI_GENERAL_TO_HIGH
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-General    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_H_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_H_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-High Value
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general,qty_highvalue    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_GENERAL
    Should Be Equal    4    ${result_3[2]}    ###QTY_HIGVALUE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'

TEST_0034_BEEH-440_INV_AVAI_GENERAL_TO_QUA
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Quarantine
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general,qty_quarantine    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_GENERAL
    Should Be Equal    4    ${result_3[2]}    ###QTY_QUARANTINE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0035_BEEH-440_INV_AVAI_GENERAL_TO_RED
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Red Zone
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general,qty_redzone    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_GENERAL
    Should Be Equal    4    ${result_3[2]}    ###QTY_REDZONE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0036_BEEH-440_INV_AVAI_GENERAL_TO_RMA
    log    Wait RMA design

TEST_0037_BEEH-440_INV_AVAI_HIGH_TO_BORROWING
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_HIGHVALUE
    ${result_2}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_HIGHVALUE
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_H_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-High Value
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Borrowing
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_highvalue,qty_borrowing    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_HIGHVALUE
    Should Be Equal    4    ${result_3[2]}    ###QTY_BORROWING
    [Teardown]    Clean data inventory item    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'

TEST_0038_BEEH-440_INV_AVAI_HIGH_TO_DAMAGE
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_HIGHVALUE
    ${result_2}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_HIGHVALUE
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_H_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-High Value
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Damage
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_highvalue,qty_damage    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_HIGHVALUE
    Should Be Equal    4    ${result_3[2]}    ###QTY_DAMAGE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'

TEST_0039_BEEH-440_INV_AVAI_HIGH_TO_EXPIRED
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_HIGHVALUE
    ${result_2}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_HIGHVALUE
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_H_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-High Value
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Expired
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_highvalue,qty_expired    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_HIGHVALUE
    Should Be Equal    4    ${result_3[2]}    ###QTY_EXPIRED
    [Teardown]    Clean data inventory item    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'

TEST_0040_BEEH-440_INV_AVAI_HIGH_TO_FOOD
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_HIGHVALUE
    ${result_2}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_HIGHVALUE
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_H_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-High Value
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Food
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_highvalue,qty_general    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_HIGHVALUE
    Should Be Equal    4    ${result_3[2]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'

TEST_0041_BEEH-440_INV_AVAI_HIGH_TO_COOLROOM
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_HIGHVALUE
    ${result_2}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_HIGHVALUE
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_H_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-High Value
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Cool Room
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_highvalue,qty_coolroom    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_HIGHVALUE
    Should Be Equal    4    ${result_3[2]}    ###QTY_COOLROOM
    [Teardown]    Clean data inventory item    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'

TEST_0042_BEEH-440_INV_AVAI_HIGH_TO_LIQUID
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_HIGHVALUE
    ${result_2}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_HIGHVALUE
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_H_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-High Value
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Liquid
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_highvalue,qty_general    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_HIGHVALUE
    Should Be Equal    4    ${result_3[2]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'

TEST_0043_BEEH-440_INV_AVAI_HIGH_TO_MAL
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_HIGHVALUE
    ${result_2}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_HIGHVALUE
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_H_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-High Value
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Malfunction
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_highvalue,qty_malfunction    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_HIGHVALUE
    Should Be Equal    4    ${result_3[2]}    ###QTY_MALFUNCTION
    [Teardown]    Clean data inventory item    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'

TEST_0044_BEEH-440_INV_AVAI_HIGH_TO_PET
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_HIGHVALUE
    ${result_2}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_HIGHVALUE
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_H_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-High Value
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Pet Food
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_highvalue,qty_general    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_HIGHVALUE
    Should Be Equal    4    ${result_3[2]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'

TEST_0045_BEEH-440_INV_AVAI_HIGH_TO_GENERAL
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_HIGHVALUE
    ${result_2}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_HIGHVALUE
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_H_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-High Value
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_highvalue,qty_general    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_HIGHVALUE
    Should Be Equal    4    ${result_3[2]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'

TEST_0046_BEEH-440_INV_AVAI_HIGH_TO_QUA
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_HIGHVALUE
    ${result_2}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_HIGHVALUE
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_H_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-High Value
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Quarantine
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_highvalue,qty_quarantine    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_HIGHVALUE
    Should Be Equal    4    ${result_3[2]}    ###QTY_QUARANTINE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'

TEST_0047_BEEH-440_INV_AVAI_HIGH_TO_RED
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_H_FIFO_001_KEY}    ${ITEM_QA2_H_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_HIGHVALUE
    ${result_2}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_H_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_HIGHVALUE
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_H_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-High Value
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Red Zone
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_highvalue,qty_redzone    '${ITEM_QA2_H_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    ${result_3[2]}    Convert To String    ${result_3[2]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    6    ${result_3[1]}    ###QTY_HIGHVALUE
    Should Be Equal    4    ${result_3[2]}    ###QTY_REDZONE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_H_FIFO_001_KEY}','${ITEM_QA2_H_FIFO_002_KEY}'

TEST_0048_BEEH-440_INV_AVAI_HIGH_TO_RMA
    log    Wait RMA design

TEST_0049_BEEH-440_INV_AVAI_GENERAL_TO_GENERAL
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-General
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_3[1]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0050_BEEH-440_INV_AVAI_FOOD_TO_PET
    [Documentation]    Location Move
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Food    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Food    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Avilable message from Scale ##########
    ${inv_avi}=    Get File    ${R_TEMPLATE_ADJ_AVI_LOCATION_MOVE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_CURRENT_DATE    ${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_avi}    Replace String    ${inv_avi}    VAY_QTY    4
    ${inv_avi}    Replace String    ${inv_avi}    VAR_FROM_LOCATION_ZONE    W-Food
    ${inv_avi}    Replace String    ${inv_avi}    VAR_TO_LOCATION_ZONE    W-Pet Food
    ${inv_avi}    Replace String    ${inv_avi}    VAR_SN    SN_${date_time}
    ${inv_avi}    Replace String    ${inv_avi}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_avi}
    Inventory Avai Upload    ${inv_avi}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    10    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_3[1]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0051_BEEH-440_INV_ONHAND_POS_NEG_CY_BORROWING
    [Documentation]    (+/-/cycle count) Adjustment
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Borrowing    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_BORROWING
    ${result_2}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_BORROWING
    Comment    ########## Simulate Inventory Adjustment Onhand message from Scale ##########
    Comment    ##### POSITIVE #####
    ${inv_onh}=    Get File    ${SO_ADJ_ONHAND_POSITIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Borrowing
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    15    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    15    ${result_3[1]}    ###QTY_BORROWING
    Comment    ##### NEGATIVE #####
    ${inv_onh}=    Get File    ${SO_ADJ_ONHAND_NEGATIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Borrowing
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_4}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_4[0]}    Convert To String    ${result_4[0]}
    ${result_4[1]}    Convert To String    ${result_4[1]}
    Should Be Equal    12    ${result_4[0]}    ###QTY_ONHAND
    Should Be Equal    12    ${result_4[1]}    ###QTY_BORROWING
    Comment    ##### CYCLECOUNT #####
    ${inv_onh}=    Get File    ${SO_ADJ_ONHAND_CYCLECOUNT}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Borrowing
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_5}=    Query Inventory Warehouseitem    qty_borrowing    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_5[0]}    Convert To String    ${result_5[0]}
    ${result_5[1]}    Convert To String    ${result_5[1]}
    Should Be Equal    13    ${result_5[0]}    ###QTY_ONHAND
    Should Be Equal    13    ${result_5[1]}    ###QTY_BORROWING
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0052_BEEH-440_INV_ONHAND_POS_NEG_CY_COOL
    [Documentation]    (+/-/cycle count) Adjustment
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Cool Room    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_COOLROOM
    ${result_2}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_COOLROOM
    Comment    ########## Simulate Inventory Adjustment Onhand message from Scale ##########
    Comment    ##### POSITIVE #####
    ${inv_onh}=    Get File    ${SO_ADJ_ONHAND_POSITIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Cool Room
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    15    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    15    ${result_3[1]}    ###QTY_COOLROOM
    Comment    ##### NEGATIVE #####
    ${inv_onh}=    Get File    ${SO_ADJ_ONHAND_NEGATIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Cool Room
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_4}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_4[0]}    Convert To String    ${result_4[0]}
    ${result_4[1]}    Convert To String    ${result_4[1]}
    Should Be Equal    12    ${result_4[0]}    ###QTY_ONHAND
    Should Be Equal    12    ${result_4[1]}    ###QTY_COOLROOM
    Comment    ##### CYCLECOUNT #####
    ${inv_onh}=    Get File    ${SO_ADJ_ONHAND_CYCLECOUNT}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Cool Room
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_5}=    Query Inventory Warehouseitem    qty_coolroom    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_5[0]}    Convert To String    ${result_5[0]}
    ${result_5[1]}    Convert To String    ${result_5[1]}
    Should Be Equal    13    ${result_5[0]}    ###QTY_ONHAND
    Should Be Equal    13    ${result_5[1]}    ###QTY_COOLROOM
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0053_BEEH-440_INV_ONHAND_POS_NEG_CY_DAMAGE
    [Documentation]    (+/-/cycle count) Adjustment
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Damage    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Damage    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_damage    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_DAMAGE
    ${result_2}=    Query Inventory Warehouseitem    qty_damage    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_DAMAGE
    Comment    ########## Simulate Inventory Adjustment Onhand message from Scale ##########
    Comment    ##### POSITIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_POSITIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Damage
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_damage    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    15    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    15    ${result_3[1]}    ###QTY_DAMAGE
    Comment    ##### NEGATIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_NEGATIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Damage
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_4}=    Query Inventory Warehouseitem    qty_damage    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_4[0]}    Convert To String    ${result_4[0]}
    ${result_4[1]}    Convert To String    ${result_4[1]}
    Should Be Equal    12    ${result_4[0]}    ###QTY_ONHAND
    Should Be Equal    12    ${result_4[1]}    ###QTY_DAMAGE
    Comment    ##### CYCLECOUNT #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_CYCLECOUNT}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Damage
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_5}=    Query Inventory Warehouseitem    qty_damage    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_5[0]}    Convert To String    ${result_5[0]}
    ${result_5[1]}    Convert To String    ${result_5[1]}
    Should Be Equal    13    ${result_5[0]}    ###QTY_ONHAND
    Should Be Equal    13    ${result_5[1]}    ###QTY_DAMAGE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0054_BEEH-440_INV_ONHAND_POS_NEG_CY_EXPIRED
    [Documentation]    (+/-/cycle count) Adjustment
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Expired    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Expired    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_expired    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_EXPIRED
    ${result_2}=    Query Inventory Warehouseitem    qty_expired    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_EXPIRED
    Comment    ########## Simulate Inventory Adjustment Onhand message from Scale ##########
    Comment    ##### POSITIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_POSITIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Expired
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_expired    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    15    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    15    ${result_3[1]}    ###QTY_EXPIRED
    Comment    ##### NEGATIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_NEGATIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Expired
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_4}=    Query Inventory Warehouseitem    qty_expired    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_4[0]}    Convert To String    ${result_4[0]}
    ${result_4[1]}    Convert To String    ${result_4[1]}
    Should Be Equal    12    ${result_4[0]}    ###QTY_ONHAND
    Should Be Equal    12    ${result_4[1]}    ###QTY_EXPIRED
    Comment    ##### CYCLECOUNT #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_CYCLECOUNT}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Expired
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_5}=    Query Inventory Warehouseitem    qty_expired    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_5[0]}    Convert To String    ${result_5[0]}
    ${result_5[1]}    Convert To String    ${result_5[1]}
    Should Be Equal    13    ${result_5[0]}    ###QTY_ONHAND
    Should Be Equal    13    ${result_5[1]}    ###QTY_EXPIRED
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0055_BEEH-440_INV_ONHAND_POS_NEG_CY_FOOD
    [Documentation]    (+/-/cycle count) Adjustment
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Food    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Food    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Onhand message from Scale ##########
    Comment    ##### POSITIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_POSITIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Food
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    15    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    15    ${result_3[1]}    ###QTY_GENERAL
    Comment    ##### NEGATIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_NEGATIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Food
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_4}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_4[0]}    Convert To String    ${result_4[0]}
    ${result_4[1]}    Convert To String    ${result_4[1]}
    Should Be Equal    12    ${result_4[0]}    ###QTY_ONHAND
    Should Be Equal    12    ${result_4[1]}    ###QTY_GENERAL
    Comment    ##### CYCLECOUNT #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_CYCLECOUNT}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Food
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_5}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_5[0]}    Convert To String    ${result_5[0]}
    ${result_5[1]}    Convert To String    ${result_5[1]}
    Should Be Equal    13    ${result_5[0]}    ###QTY_ONHAND
    Should Be Equal    13    ${result_5[1]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0056_BEEH-440_INV_ONHAND_POS_NEG_CY_GENERAL
    [Documentation]    (+/-/cycle count) Adjustment
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Onhand message from Scale ##########
    Comment    ##### POSITIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_POSITIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-General
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    15    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    15    ${result_3[1]}    ###QTY_GENERAL
    Comment    ##### NEGATIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_NEGATIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-General
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_4}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_4[0]}    Convert To String    ${result_4[0]}
    ${result_4[1]}    Convert To String    ${result_4[1]}
    Should Be Equal    12    ${result_4[0]}    ###QTY_ONHAND
    Should Be Equal    12    ${result_4[1]}    ###QTY_GENERAL
    Comment    ##### CYCLECOUNT #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_CYCLECOUNT}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-General
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_5}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_5[0]}    Convert To String    ${result_5[0]}
    ${result_5[1]}    Convert To String    ${result_5[1]}
    Should Be Equal    13    ${result_5[0]}    ###QTY_ONHAND
    Should Be Equal    13    ${result_5[1]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0057_BEEH-440_INV_ONHAND_POS_NEG_CY_LIQUID
    [Documentation]    (+/-/cycle count) Adjustment
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Liquid    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Liquid    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_GENERAL
    Comment    ########## Simulate Inventory Adjustment Onhand message from Scale ##########
    Comment    ##### POSITIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_POSITIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Liquid
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    15    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    15    ${result_3[1]}    ###QTY_GENERAL
    Comment    ##### NEGATIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_NEGATIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Liquid
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_4}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_4[0]}    Convert To String    ${result_4[0]}
    ${result_4[1]}    Convert To String    ${result_4[1]}
    Should Be Equal    12    ${result_4[0]}    ###QTY_ONHAND
    Should Be Equal    12    ${result_4[1]}    ###QTY_GENERAL
    Comment    ##### CYCLECOUNT #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_CYCLECOUNT}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Liquid
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_5}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_5[0]}    Convert To String    ${result_5[0]}
    ${result_5[1]}    Convert To String    ${result_5[1]}
    Should Be Equal    13    ${result_5[0]}    ###QTY_ONHAND
    Should Be Equal    13    ${result_5[1]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0058_BEEH-440_INV_ONHAND_POS_NEG_CY_MAL
    [Documentation]    (+/-/cycle count) Adjustment
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Malfunction    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Malfunction    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_malfunction    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_MALFUNCTION
    ${result_2}=    Query Inventory Warehouseitem    qty_malfunction    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_MALFUNCTION
    Comment    ########## Simulate Inventory Adjustment Onhand message from Scale ##########
    Comment    ##### POSITIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_POSITIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Malfunction
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_malfunction    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    15    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    15    ${result_3[1]}    ###QTY_MALFUNCTION
    Comment    ##### NEGATIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_NEGATIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Malfunction
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_4}=    Query Inventory Warehouseitem    qty_malfunction    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_4[0]}    Convert To String    ${result_4[0]}
    ${result_4[1]}    Convert To String    ${result_4[1]}
    Should Be Equal    12    ${result_4[0]}    ###QTY_ONHAND
    Should Be Equal    12    ${result_4[1]}    ###QTY_MALFUNCTION
    Comment    ##### CYCLECOUNT #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_CYCLECOUNT}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Malfunction
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_5}=    Query Inventory Warehouseitem    qty_malfunction    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_5[0]}    Convert To String    ${result_5[0]}
    ${result_5[1]}    Convert To String    ${result_5[1]}
    Should Be Equal    13    ${result_5[0]}    ###QTY_ONHAND
    Should Be Equal    13    ${result_5[1]}    ###QTY_MALFUNCTION
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0059_BEEH-440_INV_ONHAND_POS_NEG_CY_PET
    [Documentation]    (+/-/cycle count) Adjustment
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Pet Food    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Pet Food    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_GENERAL
    ${result_2}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_BORROWING
    Comment    ########## Simulate Inventory Adjustment Onhand message from Scale ##########
    Comment    ##### POSITIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_POSITIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Pet Food
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    15    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    15    ${result_3[1]}    ###QTY_GENERAL
    Comment    ##### NEGATIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_NEGATIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Pet Food
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_4}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_4[0]}    Convert To String    ${result_4[0]}
    ${result_4[1]}    Convert To String    ${result_4[1]}
    Should Be Equal    12    ${result_4[0]}    ###QTY_ONHAND
    Should Be Equal    12    ${result_4[1]}    ###QTY_GENERAL
    Comment    ##### CYCLECOUNT #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_CYCLECOUNT}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Pet Food
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_5}=    Query Inventory Warehouseitem    qty_general    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_5[0]}    Convert To String    ${result_5[0]}
    ${result_5[1]}    Convert To String    ${result_5[1]}
    Should Be Equal    13    ${result_5[0]}    ###QTY_ONHAND
    Should Be Equal    13    ${result_5[1]}    ###QTY_GENERAL
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0060_BEEH-440_INV_ONHAND_POS_NEG_CY_HIGH
    [Documentation]    (+/-/cycle count) Adjustment
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-High Value    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_HIGHVALUE
    ${result_2}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_HIGHVALUE
    Comment    ########## Simulate Inventory Adjustment Onhand message from Scale ##########
    Comment    ##### POSITIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_POSITIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-High Value
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    15    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    15    ${result_3[1]}    ###QTY_HIGHVALUE
    Comment    ##### NEGATIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_NEGATIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-High Value
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_4}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_4[0]}    Convert To String    ${result_4[0]}
    ${result_4[1]}    Convert To String    ${result_4[1]}
    Should Be Equal    12    ${result_4[0]}    ###QTY_ONHAND
    Should Be Equal    12    ${result_4[1]}    ###QTY_HIGHVALUE
    Comment    ##### CYCLECOUNT #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_CYCLECOUNT}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-High Value
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_5}=    Query Inventory Warehouseitem    qty_highvalue    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_5[0]}    Convert To String    ${result_5[0]}
    ${result_5[1]}    Convert To String    ${result_5[1]}
    Should Be Equal    13    ${result_5[0]}    ###QTY_ONHAND
    Should Be Equal    13    ${result_5[1]}    ###QTY_HIGHVALUE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0061_BEEH-440_INV_ONHAND_POS_NEG_CY_QUA
    [Documentation]    (+/-/cycle count) Adjustment
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Quarantine    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Quarantine    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_quarantine    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_QUARANTINE
    ${result_2}=    Query Inventory Warehouseitem    qty_quarantine    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_QUARANTINE
    Comment    ########## Simulate Inventory Adjustment Onhand message from Scale ##########
    Comment    ##### POSITIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_POSITIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Quarantine
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_quarantine    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    15    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    15    ${result_3[1]}    ###QTY_QUARANTINE
    Comment    ##### NEGATIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_NEGATIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Quarantine
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_4}=    Query Inventory Warehouseitem    qty_quarantine    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_4[0]}    Convert To String    ${result_4[0]}
    ${result_4[1]}    Convert To String    ${result_4[1]}
    Should Be Equal    12    ${result_4[0]}    ###QTY_ONHAND
    Should Be Equal    12    ${result_4[1]}    ###QTY_QUARANTINE
    Comment    ##### CYCLECOUNT #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_CYCLECOUNT}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Quarantine
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_5}=    Query Inventory Warehouseitem    qty_quarantine    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_5[0]}    Convert To String    ${result_5[0]}
    ${result_5[1]}    Convert To String    ${result_5[1]}
    Should Be Equal    13    ${result_5[0]}    ###QTY_ONHAND
    Should Be Equal    13    ${result_5[1]}    ###QTY_QUARANTINE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0062_BEEH-440_INV_ONHAND_POS_NEG_CY_RED
    [Documentation]    (+/-/cycle count) Adjustment
    Comment    ###### Clean Data ######
    Delete Data Inventory Warehouseitem    ${SO_PARTNER_ID}    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'
    Comment    Clean "automate_so_status"
    ${msg_so_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_SO_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_so_status}
    Comment    Clean "automate_order_status"
    ${msg_order_status}=    consume_queue_from_rabbitmq    ${USERNAME_RQ}    ${PASSWORD_RQ}    ${HOST_RQ}    ${VHOST_COMMON_RQ}    ${Q_ORDER_STATUS_RQ}
    ...    MULTIPLE
    log    ${msg_order_status}
    Sleep    ${SLEEP_3_S}
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
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    REC_${date_time}    W-Red Zone    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    ${putaway_body}=    Prepare putaway mock data    ${po_key}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    W-Red Zone    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000
    Putaway Complete Upload    ${putaway_body}
    sleep    ${SLEEP_2_S}
    Comment    ###### Simulate GRN message from Scale ######
    ${grn_body}=    Prepare grn with 2 item mock data    ${po_key}    ${ITEM_QA2_G_FIFO_001_KEY}    ${ITEM_QA2_G_FIFO_002_KEY}    REC_${date_time}    ${SO_PARTNER_SLUG}
    ...    ${SO_WAREHOUSE_CODE}    10.00000    10.00000
    Grn Upload    ${grn_body}
    sleep    ${SLEEP_5_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_1}=    Query Inventory Warehouseitem    qty_redzone    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_1[0]}    Convert To String    ${result_1[0]}
    ${result_1[1]}    Convert To String    ${result_1[1]}
    Should Be Equal    10    ${result_1[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_1[1]}    ###QTY_REDZONE
    ${result_2}=    Query Inventory Warehouseitem    qty_redzone    '${ITEM_QA2_G_FIFO_002_KEY}'
    ${result_2[0]}    Convert To String    ${result_2[0]}
    ${result_2[1]}    Convert To String    ${result_2[1]}
    Should Be Equal    10    ${result_2[0]}    ###QTY_ONHAND
    Should Be Equal    10    ${result_2[1]}    ###QTY_REDZONE
    Comment    ########## Simulate Inventory Adjustment Onhand message from Scale ##########
    Comment    ##### POSITIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_POSITIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Red Zone
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_3}=    Query Inventory Warehouseitem    qty_redzone    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_3[0]}    Convert To String    ${result_3[0]}
    ${result_3[1]}    Convert To String    ${result_3[1]}
    Should Be Equal    15    ${result_3[0]}    ###QTY_ONHAND
    Should Be Equal    15    ${result_3[1]}    ###QTY_REDZONE
    Comment    ##### NEGATIVE #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_NEGATIVE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Red Zone
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_4}=    Query Inventory Warehouseitem    qty_redzone    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_4[0]}    Convert To String    ${result_4[0]}
    ${result_4[1]}    Convert To String    ${result_4[1]}
    Should Be Equal    12    ${result_4[0]}    ###QTY_ONHAND
    Should Be Equal    12    ${result_4[1]}    ###QTY_REDZONE
    Comment    ##### CYCLECOUNT #####
    ${inv_onh}=    Get File    ${R_TEMPLATE_ADJ_ONHAND_CYCLECOUNT}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_CURRENT_DATE    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_WAREHOUSE    ${SO_WAREHOUSE_CODE}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_COMPANY    ${SO_PARTNER_SLUG}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_ITEM_KEY    ${ITEM_QA2_G_FIFO_001_KEY}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_SNDATETIME    ${date_time}
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOCATION_ZONE    W-Red Zone
    ${inv_onh}    Replace String    ${inv_onh}    VAR_LOT_ID    LOT_${date_time}
    log    ${inv_onh}
    Inventory Onhand Upload    ${inv_onh}
    sleep    ${SLEEP_2_S}
    Comment    ###### Check Inventory WarehouseItem ######
    ${result_5}=    Query Inventory Warehouseitem    qty_redzone    '${ITEM_QA2_G_FIFO_001_KEY}'
    ${result_5[0]}    Convert To String    ${result_5[0]}
    ${result_5[1]}    Convert To String    ${result_5[1]}
    Should Be Equal    13    ${result_5[0]}    ###QTY_ONHAND
    Should Be Equal    13    ${result_5[1]}    ###QTY_REDZONE
    [Teardown]    Clean data inventory item    '${ITEM_QA2_G_FIFO_001_KEY}','${ITEM_QA2_G_FIFO_002_KEY}'

TEST_0063_BEEH-440_INV_ONHAND_POS_NEG_CY_RMA
    log    Wait RMA design
