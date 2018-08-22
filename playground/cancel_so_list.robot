*** Settings ***
Library    HttpLibrary.HTTP
Library    DateTime
Library    OperatingSystem
Library    String
Library    Collections
Resource   ../test_suite/resource/group_vars/${env}/global_resource.robot
Library   ../libs/mongodb/mongodb.py

*** Variable ***
${partnerId}             4086
${endpoint_orderstore}   order-store-qa.acommercedev.service
# ${endpoint_orderstore}   order-store-staging.acommercedev.service
# ${endpoint_orderstore}   order-store.acommerce.service
${order_store_path}      /os/item-sales-orders/
${cancel_sales_order_path}    /os/item-sales-orders/<so key>/cancel/
${reason_code_payload}   { "reason": "Duplicate Delivery", "reasonCode": "A05"}

*** Test Cases ***
Cancel SO
    ${request_body}=   Set Variable    ${reason_code_payload}
    ###------------ Query Order Store DB to get soKey ------------###
    ${soKeyList}=   Prepare list of sales order key to be cancelled  ${partnerId}
    ###------------ Request SO cancel API ------------###
    ${loop_no}=   Evaluate    len(${soKeyList})
    : FOR    ${INDEX}    IN RANGE    1    ${loop_no}
    \    Log To Console   ${INDEX}/${loop_no}
    \    ${soKey}=  Evaluate  ${soKeyList}[${INDEX}]
    \    ${cancel_sales_order_path}   Replace String    ${cancel_sales_order_path}    <so key>    ${soKey}
    \    Cancel Sales Order via api  ${cancel_sales_order_path}  ${reason_code_payload}
    \    ${cancel_sales_order_path}   Replace String    ${cancel_sales_order_path}    ${soKey}    <so key>
    Log    For loop is over

*** Keywords ***
Cancel Sales Order via api
    [Arguments]  ${cancel_sales_order_path}  ${request_body}
    ##### HTTP Request
    Create Http Context     ${endpoint_orderstore}    http
    Set Request Header      Content-Type   application/json
    Set Request Body        ${request_body}
    POST                    ${cancel_sales_order_path}
    Response Status Code Should Equal    200

Connnect To Order Store DB
    connect_to_DB  ${ORDER_STORE_MONGO_USER}  ${ORDER_STORE_MONGO_PASSWORD}  ${ORDER_STORE_MONGO_HOST}  ${ORDER_STORE_MONGO_DB_NAME}

Prepare list of sales order key to be cancelled
    [Arguments]  ${partnerId}
    ###### search fields #######
    ${query}=             Set Variable    { "info.partners.partnerId":"${partnerId}", "state.orderStatus.status": { "$ne" :"CANCELLED" }, "state.shipmentStatus.status": { "$nin" : ["IN_TRANSIT","FAILED_TO_DELIVER","COMPLETED"] }}
    ${connection_name}=   Set Variable    ${SALES_ORDER_COLLECTION}
    ${mongoDBProjection}=  Set Variable   {"key":1, "_id":0}
    ##### query on mongoDB #####
    Connnect To Order Store DB
    ${query_results}=   get_one_from_collection  ${connection_name}  ${query}   ${mongoDBProjection}
    Log  ${query_results}
    ##### Extract JSON to get only soKey
    ${query_results}=  Replace String    ${query_results}   "key":  ${EMPTY}
    ${query_results}=  Replace String    ${query_results}   "       '
    ${query_results}=  Replace String    ${query_results}   {       (
    ${query_results}=  Replace String    ${query_results}   }       )
    Log    ${query_results}
    [Return]    ${query_results}
