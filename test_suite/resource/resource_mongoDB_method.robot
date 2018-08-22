*** Settings ***
Library           HttpLibrary.HTTP
Library           Collections
Library           ../../libs/sales_order/so_library.py
Library           ../../libs/mongodb/mongodb.py

*** Variables ***

*** Keywords ***
Connnect To Order Store DB
    connect_to_DB  ${ORDER_STORE_MONGO_USER}  ${ORDER_STORE_MONGO_PASSWORD}  ${ORDER_STORE_MONGO_HOST}  ${ORDER_STORE_MONGO_DB_NAME}

Connnect To Item Master DB
    connect_to_DB  ${ITEM_MASTER_MONGO_USER}  ${ITEM_MASTER_MONGO_PASSWORD}  ${ITEM_MASTER_MONGO_HOST}  ${ITEM_MASTER_MONGO_DB_NAME}

Verify Sales Order on DB
    [Arguments]  ${soKey}  ${field_name}  ${expected_results}  ${lineNumber}=n/a
    ###### search fields #######
    ${query}=             Set Variable    {"key":"${soKey}"}
    ${connection_name}=   Set Variable    ${SALES_ORDER_COLLECTION}
    ##### Product sequence
    ${product_index}=  Run Keyword If    '${lineNumber}'!='n/a'   Evaluate    ${lineNumber} - 1
    Log  ${product_index}
    
    #####
    ${jsonExtractPath}=   Run Keyword If  '${field_name}'=='orderStatus'  Set Variable  /0/state/orderStatus/status
    ...    ELSE IF   '${field_name}'=='shipmentStatus'   Set Variable   /0/state/shipmentStatus/status
    ...    ELSE IF   '${field_name}'=='backorder'   Set Variable   /0/state/backorder
    ...    ELSE IF   '${field_name}'=='onCancel'    Set Variable   /0/state/onCancel
    ...    ELSE IF   '${field_name}'=='deleted'     Set Variable   /0/deleted
    ...    ELSE IF   '${field_name}'=='products'    Set Variable   /0/order/products/${product_index}
    #####
    ${mongoDBProjection}=   Run Keyword If  '${field_name}'=='orderStatus'  Set Variable  {"state":1}
    ...    ELSE IF   '${field_name}'=='shipmentStatus'   Set Variable   {"state":1}
    ...    ELSE IF   '${field_name}'=='backorder'   Set Variable   {"state":1}
    ...    ELSE IF   '${field_name}'=='onCancel'    Set Variable   {"state":1}
    ...    ELSE IF   '${field_name}'=='deleted'     Set Variable   n/a
    ...    ELSE IF   '${field_name}'=='products'    Set Variable   {"order.products":1}

    ##### query on mongoDB #####
    Connnect To Order Store DB
    ${query_results}=   get_one_from_collection  ${connection_name}  ${query}   ${mongoDBProjection}

    ##### Verify query result for Products ###
    ${getlineNumberResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/lineNumber
    ${getproductIdResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/productId
    ${getpartnerItemIdResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/items/0/partnerItemId
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getlineNumberResults}      ${lineNumber}
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getproductIdResults}       "${expected_results}"
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getpartnerItemIdResults}   "${expected_results}"

    ##### Verify query result for others ###
    ${getResults}=  Run Keyword Unless  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}
    Run Keyword Unless  '${field_name}'=='products'
    ...         Should Contain   ${getResults}   ${expected_results}

Verify Partner Item Id on Sales Order on DB
    [Arguments]  ${soKey}   ${field_name}   ${expected_results}  ${lineNumber}=n/a   ${expected_qtyPerLine}=1   ${expected_grossAmount}=100.00
    ###### search fields #######
    ${query}=             Set Variable    {"key":"${soKey}"}
    ${connection_name}=   Set Variable    ${SALES_ORDER_COLLECTION}
    ##### Product sequence
    ${product_index}=  Run Keyword If    '${lineNumber}'!='n/a'   Evaluate    ${lineNumber} - 1
    Log  ${product_index}
    
    #####
    ${jsonExtractPath}=   Run Keyword If   '${field_name}'=='products'    Set Variable    /0/order/products/${product_index}
    #####
    ${mongoDBProjection}=   Run Keyword If  '${field_name}'=='products'    Set Variable   {"order.products":1}

    ##### query on mongoDB #####
    Connnect To Order Store DB
    ${query_results}=   get_one_from_collection  ${connection_name}  ${query}   ${mongoDBProjection}
    ##### Verify query result for Products ###
    ${getlineNumberResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/lineNumber
    ${getproductIdResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/productId
    ${getpartnerItemIdResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/items/0/partnerItemId
    ${getqtyResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/qty
    ${getgrossAmountResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/grossAmount
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getlineNumberResults}      ${lineNumber}
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getproductIdResults}       "${expected_results}"
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getpartnerItemIdResults}   "${expected_results}"
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getqtyResults}             ${expected_qtyPerLine}
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getgrossAmountResults}     ${expected_grossAmount}

Verify History of Sales Order on DB
    [Arguments]  ${soKey}  ${field_name}  ${expected_results}  ${history_index}=1
    ###### search fields #######
    ${query}=             Set Variable    {"key":"${soKey}"}
    ${connection_name}=   Set Variable    ${SALES_ORDER_COLLECTION}

    ##### historical level
    ${history_index}=  Run Keyword If    '${history_index}'!='${EMPTY}'  Evaluate    ${history_index} - 1
    Log  ${history_index}

    #####
    ${jsonExtractPath}=   Run Keyword If  '${field_name}'=='orderStatus'  Set Variable  /0/history/state/${history_index}/orderStatus/status
    ...    ELSE IF   '${field_name}'=='shipmentStatus'  Set Variable  /0/history/state/${history_index}/shipmentStatus/status
    ...    ELSE IF   '${field_name}'=='backorder'   Set Variable   /0/history/state/${history_index}/backorder
    ...    ELSE IF   '${field_name}'=='onCancel'    Set Variable   /0/history/state/${history_index}/onCancel
    ...    ELSE IF   '${field_name}'=='deleted'     Set Variable   /0/history/deleted
    #####
    ${mongoDBProjection}=   Run Keyword If  '${field_name}'=='orderStatus'  Set Variable  {"history.state":1}
    ...    ELSE IF   '${field_name}'=='shipmentStatus'   Set Variable   {"history.state":1}
    ...    ELSE IF   '${field_name}'=='backorder'   Set Variable   {"history.state":1}
    ...    ELSE IF   '${field_name}'=='onCancel'    Set Variable   {"history.state":1}
    ...    ELSE IF   '${field_name}'=='deleted'     Set Variable   {"history":1}

    ##### query on mongoDB #####
    Connnect To Order Store DB
    ${query_results}=   get_one_from_collection  ${connection_name}  ${query}   ${mongoDBProjection}
    Log   ${query_results}
    ##### Verify query result for others ###
    ${getResults}=  Run Keyword Unless  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}
    Run Keyword Unless  '${field_name}'=='products'
    ...         Should Contain   ${getResults}   ${expected_results}

Verify Fulfillment Order on DB
    [Arguments]  ${soKey}  ${field_name}  ${expected_results}  ${lineNumber}=n/a
    ###### search fields #######
    ${query}=             Set Variable    {"info.soKey":"${soKey}"}
    ${connection_name}=   Set Variable    ${FULFILLMENT_ORDER_COLLECTION}

    ##### Product sequence
    ${product_index}=  Run Keyword If    '${lineNumber}'!='n/a'   Evaluate    ${lineNumber} - 1
    Log  ${product_index}

    #####
    ${jsonExtractPath}=   Run Keyword If  '${field_name}'=='fulfillmentStatus'  Set Variable  /0/state/fulfillmentStatus/status
    ...    ELSE IF   '${field_name}'=='products'          Set Variable   /0/order/products/${product_index}
    ...    ELSE IF   '${field_name}'=='internalStatus'    Set Variable   /0/internalStatus
    #####
    ${mongoDBProjection}=   Run Keyword If  '${field_name}'=='fulfillmentStatus'  Set Variable  {"state":1}
    ...    ELSE IF   '${field_name}'=='products'          Set Variable   {"order.products":1}
    ...    ELSE IF   '${field_name}'=='internalStatus'    Set Variable   {"internalStatus":1}

    ##### query on mongoDB #####
    Connnect To Order Store DB
    ${query_results}=   get_one_from_collection  ${connection_name}  ${query}   ${mongoDBProjection}

    ##### Verify query result for Products ###
    ${getlineNumberResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/lineNumber
    ${getproductIdResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/productId
    ${getpartnerItemIdResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/items/0/partnerItemId
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getlineNumberResults}      ${lineNumber}
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getproductIdResults}       "${expected_results}"
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getpartnerItemIdResults}   "${expected_results}"

    ##### Verify query result for others ###
    ${getResults}=  Run Keyword Unless  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}
    Run Keyword Unless  '${field_name}'=='products'
    ...         Should Contain   ${getResults}   ${expected_results}

Verify Partner Item Id on Fulfillment Order on DB
    [Arguments]  ${soKey}  ${field_name}  ${expected_results}   ${lineNumber}=n/a   ${expected_qtyPerLine}=1   ${expected_grossAmount}=100.00
    ###### search fields #######
    ${query}=             Set Variable    {"info.soKey":"${soKey}"}
    ${connection_name}=   Set Variable    ${FULFILLMENT_ORDER_COLLECTION}

    ##### Product sequence
    ${product_index}=  Run Keyword If    '${lineNumber}'!='n/a'   Evaluate    ${lineNumber} - 1
    Log  ${product_index}

    #####
    ${jsonExtractPath}=   Run Keyword If  '${field_name}'=='products'    Set Variable   /0/order/products/${product_index}
    #####
    ${mongoDBProjection}=   Run Keyword If  '${field_name}'=='products'    Set Variable   {"order.products":1}

    ##### query on mongoDB #####
    Connnect To Order Store DB
    ${query_results}=   get_one_from_collection  ${connection_name}  ${query}   ${mongoDBProjection}

    # ##### Verify query result for Products ###
    # ${getlineNumberResults}=  Run Keyword If  '${field_name}'=='products'
    # ...         Get Json Value    ${query_results}   ${jsonExtractPath}/lineNumber
    # ${getproductIdResults}=  Run Keyword If  '${field_name}'=='products'
    # ...         Get Json Value    ${query_results}   ${jsonExtractPath}/productId
    # ${getpartnerItemIdResults}=  Run Keyword If  '${field_name}'=='products'
    # ...         Get Json Value    ${query_results}   ${jsonExtractPath}/items/0/partnerItemId
    # Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getlineNumberResults}      ${lineNumber}
    # Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getproductIdResults}       "${expected_results}"
    # Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getpartnerItemIdResults}   "${expected_results}"

    ##### Verify query result for Products ###
    ${getlineNumberResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/lineNumber
    ${getproductIdResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/productId
    ${getpartnerItemIdResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/items/0/partnerItemId
    ${getqtyResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/qty
    ${getgrossAmountResults}=  Run Keyword If  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/grossAmount
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getlineNumberResults}      ${lineNumber}
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getproductIdResults}       "${expected_results}"
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getpartnerItemIdResults}   "${expected_results}"
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getqtyResults}             ${expected_qtyPerLine}
    Run Keyword If   '${field_name}'=='products'  Should Be Equal   ${getgrossAmountResults}     ${expected_grossAmount}

Verify History of Fulfillment Order on DB
    [Arguments]  ${soKey}  ${field_name}  ${expected_results}  ${history_index}=n/a
    ###### search fields #######
    ${query}=             Set Variable    {"info.soKey":"${soKey}"}
    ${connection_name}=   Set Variable    ${FULFILLMENT_ORDER_COLLECTION}

    ##### historical level
    ${history_index}=  Run Keyword If    '${history_index}'!='${EMPTY}'  Evaluate    ${history_index} - 1
    Log  ${history_index}

    #####
    ${jsonExtractPath}=   Run Keyword If  '${field_name}'=='fulfillmentStatus'  Set Variable  /0/history/state/${history_index}/fulfillmentStatus/status
    ...    ELSE IF   '${field_name}'=='internalStatus'  Set Variable  /0/history/internalStatus/${history_index}/status

    #####
    ${mongoDBProjection}=   Run Keyword If  '${field_name}'=='fulfillmentStatus'  Set Variable  {"history.state":1}
    ...    ELSE IF   '${field_name}'=='internalStatus'  Set Variable  {"history.internalStatus":1}

    ##### query on mongoDB #####
    Connnect To Order Store DB
    ${query_results}=   get_one_from_collection  ${connection_name}  ${query}   ${mongoDBProjection}
    ##### Verify query result for others ###
    ${getResults}=  Run Keyword Unless  '${field_name}'=='products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}
    Run Keyword Unless  '${field_name}'=='products'
    ...         Should Contain   ${getResults}   ${expected_results}

Get Fulfillment Order Key on DB
    [Arguments]   ${soKey}
    ###### search fields #######
    ${query}=             Set Variable    {"info.soKey":"${soKey}"}
    ${connection_name}=   Set Variable    ${FULFILLMENT_ORDER_COLLECTION}
    ######
    ${mongoDBProjection}=  Set Variable  {"key":1}
    ##### query on mongoDB #####
    Connnect To Order Store DB
    ${query_results}=   get_one_from_collection  ${connection_name}  ${query}   ${mongoDBProjection}
    ##### Verify query result for others ###
    ${get_foKey}=  Get Json Value    ${query_results}   /0/key
    ${fokey}=   Remove String   ${get_foKey}   "  
    [Return]   ${fokey}

Verify Bundle items on Sales Order DB
    [Arguments]   ${soKey}   ${field_name}   ${expected_productId}   ${expected_productLineNumber}   ${expected_itemLineNumber}   ${expected_qty}   ${expected_grossAmount}
    ###### search fields #######
    ${query}=             Set Variable    {"key":"${soKey}"}
    ${connection_name}=   Set Variable    ${SALES_ORDER_COLLECTION}
    ##### Product sequence
    ${product_index}=   Evaluate    ${expected_productLineNumber} - 1
    ${item_index}=      Evaluate    ${expected_itemLineNumber} - 1
    Log  ${product_index}
    Log  ${item_index}
    #####
    ${jsonExtractPath}=   Run Keyword If  '${field_name}'=='bundle_products'    Set Variable   /0/order/products/${product_index}
    ...                          ELSE IF  '${field_name}'=='bundle_items'       Set Variable   /0/order/products/${product_index}/items/${item_index}
    #####
    ${mongoDBProjection}=   Set Variable   {"order.products":1}

    ##### query on mongoDB #####
    Connnect To Order Store DB
    ${query_results}=   get_one_from_collection  ${connection_name}  ${query}   ${mongoDBProjection}

    ##### Verify query result for Bundle Products ###
    ${getlineNumberResults}=  Run Keyword If  '${field_name}'=='bundle_products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/lineNumber
    ${getproductIdResults}=  Run Keyword If  '${field_name}'=='bundle_products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/productId
    ${getqtyResults}=  Run Keyword If  '${field_name}'=='bundle_products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/qty
    ${getgrossAmountResults}=   Run Keyword If  '${field_name}'=='bundle_products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/grossAmount
    Run Keyword If   '${field_name}'=='bundle_products'  Should Be Equal   ${getlineNumberResults}      ${expected_productLineNumber}
    Run Keyword If   '${field_name}'=='bundle_products'  Should Be Equal   ${getproductIdResults}       "${expected_productId}"
    Run Keyword If   '${field_name}'=='bundle_products'  Should Be Equal   ${getqtyResults}             ${expected_qty}
    Run Keyword If   '${field_name}'=='bundle_products'  Should Be Equal   ${getgrossAmountResults}     ${expected_grossAmount}

    ##### Verify query result for Bundle Items ###
    ${getpartnerItemIdResults}=  Run Keyword If  '${field_name}'=='bundle_items'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/partnerItemId
    ${getqtyPerProductResults}=  Run Keyword If  '${field_name}'=='bundle_items'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/qtyPerProduct
    ${getqtyPerLineResults}=  Run Keyword If  '${field_name}'=='bundle_items'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/qtyPerLine
    ${getgrossAmountPerLineResults}=  Run Keyword If  '${field_name}'=='bundle_items'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/grossAmountPerLine
    ${getgrossAmountPerProductResults}=  Run Keyword If  '${field_name}'=='bundle_items'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/grossAmountPerProduct
    Run Keyword If   '${field_name}'=='bundle_items'     Should Be Equal   ${getpartnerItemIdResults}           "${expected_productId}"
    Run Keyword If   '${field_name}'=='bundle_items'     Should Be Equal   ${getqtyPerProductResults}           ${expected_qty}
    Run Keyword If   '${field_name}'=='bundle_items'     Should Be Equal   ${getqtyPerLineResults}              ${expected_qty}
    Run Keyword If   '${field_name}'=='bundle_items'     Should Be Equal   ${getgrossAmountPerLineResults}      ${expected_grossAmount}
    Run Keyword If   '${field_name}'=='bundle_items'     Should Be Equal   ${getgrossAmountPerProductResults}   ${expected_grossAmount}

Verify Bundle items on Fulfillment Order DB
    [Arguments]   ${soKey}   ${field_name}   ${expected_productId}   ${expected_productLineNumber}   ${expected_itemLineNumber}   ${expected_qty}   ${expected_grossAmount}
    ###### search fields #######
    ${query}=             Set Variable    {"info.soKey":"${soKey}"}
    ${connection_name}=   Set Variable    ${FULFILLMENT_ORDER_COLLECTION}
    ##### Product sequence
    ${product_index}=   Evaluate    ${expected_productLineNumber} - 1
    ${item_index}=      Evaluate    ${expected_itemLineNumber} - 1
    Log  ${product_index}
    Log  ${item_index}
    #####
    ${jsonExtractPath}=   Run Keyword If  '${field_name}'=='bundle_products'    Set Variable   /0/order/products/${product_index}
    ...                          ELSE IF  '${field_name}'=='bundle_items'       Set Variable   /0/order/products/${product_index}/items/${item_index}
    #####
    ${mongoDBProjection}=   Set Variable   {"order.products":1}

    ##### query on mongoDB #####
    Connnect To Order Store DB
    ${query_results}=   get_one_from_collection  ${connection_name}  ${query}   ${mongoDBProjection}

    ##### Verify query result for Bundle Products ###
    ${getlineNumberResults}=  Run Keyword If  '${field_name}'=='bundle_products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/lineNumber
    ${getproductIdResults}=  Run Keyword If  '${field_name}'=='bundle_products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/productId
    ${getqtyResults}=  Run Keyword If  '${field_name}'=='bundle_products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/qty
    ${getgrossAmountResults}=   Run Keyword If  '${field_name}'=='bundle_products'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/grossAmount
    Run Keyword If   '${field_name}'=='bundle_products'  Should Be Equal   ${getlineNumberResults}      ${expected_productLineNumber}
    Run Keyword If   '${field_name}'=='bundle_products'  Should Be Equal   ${getproductIdResults}       "${expected_productId}"
    Run Keyword If   '${field_name}'=='bundle_products'  Should Be Equal   ${getqtyResults}             ${expected_qty}
    Run Keyword If   '${field_name}'=='bundle_products'  Should Be Equal   ${getgrossAmountResults}     ${expected_grossAmount}

    ##### Verify query result for Bundle Items ###
    ${getpartnerItemIdResults}=  Run Keyword If  '${field_name}'=='bundle_items'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/partnerItemId
    ${getqtyPerProductResults}=  Run Keyword If  '${field_name}'=='bundle_items'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/qtyPerProduct
    ${getqtyPerLineResults}=  Run Keyword If  '${field_name}'=='bundle_items'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/qtyPerLine
    ${getgrossAmountPerLineResults}=  Run Keyword If  '${field_name}'=='bundle_items'
    ...         Get Json Value    ${query_results}   ${jsonExtractPath}/grossAmountPerLine
    # ${getgrossAmountPerProductResults}=  Run Keyword If  '${field_name}'=='bundle_items'
    # ...         Get Json Value    ${query_results}   ${jsonExtractPath}/grossAmountPerProduct
    Run Keyword If   '${field_name}'=='bundle_items'     Should Be Equal   ${getpartnerItemIdResults}           "${expected_productId}"
    Run Keyword If   '${field_name}'=='bundle_items'     Should Be Equal   ${getqtyPerProductResults}           ${expected_qty}
    Run Keyword If   '${field_name}'=='bundle_items'     Should Be Equal   ${getqtyPerLineResults}              ${expected_qty}
    Run Keyword If   '${field_name}'=='bundle_items'     Should Be Equal   ${getgrossAmountPerLineResults}      ${expected_grossAmount}
    # Run Keyword If   '${field_name}'=='bundle_items'     Should Be Equal   ${getgrossAmountPerProductResults}   ${expected_grossAmount}

Get Order Store eventId from DB
    [Arguments]    ${soKey}   ${collection_name}
    ##### Type of collection
    # ${query}=               Run Keyword If   '${collection_name}'=='sales_order'           Set Variable    {"key":"${soKey}"}
    # ...                     ELSE IF          '${collection_name}'=='fulfillment_order'     Set Variable    {"info.soKey":"${soKey}"}
    # ${connection_name}=     Run Keyword If   '${collection_name}'=='sales_order'           Set Variable    ${SALES_ORDER_COLLECTION}
    # ...                     ELSE IF          '${collection_name}'=='fulfillment_order'     Set Variable    ${FULFILLMENT_ORDER_COLLECTION}
    # #####
    # ${jsonLengthFinding}=   Run Keyword If  '${collection_name}'=='sales_order'         Set Variable  orderStatus
    # ...                     ELSE IF         '${collection_name}'=='fulfillment_order'   Set Variable  fulfillmentStatus
    # ${jsonExtractPath}=     Run Keyword If  '${collection_name}'=='sales_order'         Set Variable  /0/history/orderStatus
    # ...                     ELSE IF         '${collection_name}'=='fulfillment_order'   Set Variable  /0/history/fulfillmentStatus
    # #####
    # ${mongoDBProjection}=   Run Keyword If  '${collection_name}'=='sales_order'         Set Variable  {"history.orderStatus":1}
    # ...                     ELSE IF         '${collection_name}'=='fulfillment_order'   Set Variable  {"history.fulfillmentStatus":1}

    ${query}=   Set Variable   {"history.state.orderStatus.eventId":LUUID\("0e07c247-cbef-436e-8d21-3ad313c4ad97"\)}
    ${connection_name}=  Set Variable   ${SALES_ORDER_COLLECTION}
    ${mongoDBProjection}=  Set Variable   {"history.state.orderStatus":1}
    ##### query on mongoDB #####
    Connnect To Order Store DB
    ${query_results}=   get one from collection  ${connection_name}  ${query}   ${mongoDBProjection}
    Log    ${query_results}

    # #### Get Length of status  ### 
    # ${query_json}=   Get Json Value    ${query_results}      /0/history
    # ${parsed}=   Parse JSON     ${query_json}
    # ${length_str}=   Get Length     ${parsed["${jsonLengthFinding}"]}

    # @{list}   Create List   ${EMPTY}  
    # #### Verify query result for others ###
    # :FOR    ${INDEX}  IN RANGE    0    ${length_str}
    # \       ${getEventId}=    Get Json Value    ${query_results}    ${jsonExtractPath}/${INDEX}/eventId
    # \       Log   ${getEventId}
    # \       Append To List  ${list}   ${getEventId} 
    # Log   ${list}
    [Return]   ${list}

Verify Item on DB
    [Arguments]  ${itemKey}  ${field_name}  ${expected_results}
    ###### search fields #######
    ${query}=             Set Variable    {"key":"${itemKey}"}
    ${connection_name}=   Set Variable    ${ITEM_MASTER_COLLECTION}
    
    #####
    # ${jsonExtractPath}=   Run Keyword If  '${field_name}'=='partnerItemId'  Set Variable  /0/partnerItemId
    # ...    ELSE IF   '${field_name}'=='description'   Set Variable   /0/description
    # ...    ELSE IF   '${field_name}'=='isGDPMDS'   Set Variable   /0/isGDPMDS

    #####
    ${mongoDBProjection}=   Run Keyword If  '${field_name}'=='partnerItemId'  Set Variable  n/a
    ...    ELSE IF   '${field_name}'=='description'   Set Variable   n/a
    ...    ELSE IF   '${field_name}'=='isGDPMDS'   Set Variable   n/a

    ##### query on mongoDB #####
    Connnect To Item Master DB
    ${query_results}=   get_one_from_collection  ${connection_name}  ${query}   ${mongoDBProjection}
    log  ${query_results}

    ##### Verify query result for others ###
    ${getResults}=  Get Json Value  ${query_results}  /0/${field_name}
    ${getResults}=  Remove String   ${getResults}   "
    Should Be Equal  ${getResults}   ${expected_results}