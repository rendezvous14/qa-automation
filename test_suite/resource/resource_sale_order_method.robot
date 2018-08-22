*** Settings ***
Library           HttpLibrary.HTTP
Library           OperatingSystem
Library           DateTime
Library           String
Library           ../../libs/sales_order/so_library.py

*** Variables ***

*** Keywords ***
Create Product Line Items
    [Arguments]  ${template_file}  ${partner_id}  ${partnerItemId}   ${lineNumber}   ${qtyPerProduct}  ${qtyPerItem}  ${grossAmount}=100.00
    ${request_body}  Get File  ${template_file}
    ${request_body}  Replace String    ${request_body}    VAR_LINE_NUNBER    ${lineNumber}
    ${request_body}  Replace String    ${request_body}    VAR_PARTNER_ID     ${partner_id}
    ${request_body}  Replace String    ${request_body}    VAR_PARTNER_ITEM_ID     ${partnerItemId}
    ${request_body}  Replace String    ${request_body}    VAR_PRODUCT_QTY     ${qtyPerProduct}
    ${request_body}  Replace String    ${request_body}    VAR_GROSS_AMOUNT    ${grossAmount}
    ${request_body}  Replace String    ${request_body}    VAR_ITEM_QTY        ${qtyPerItem}
    Log  ${request_body}
    [Return]  ${request_body}

Create Line Items for Bundle
    [Arguments]  ${template_file}  ${partner_id}   ${partnerItemId}   ${qtyPerItem}
    ${request_body}  Get File  ${template_file}
    ${request_body}  Replace String    ${request_body}    VAR_PARTNER_ID        ${partner_id}
    ${request_body}  Replace String    ${request_body}    VAR_PARTNER_ITEM_ID   ${partnerItemId}
    ${request_body}  Replace String    ${request_body}    VAR_ITEM_QTY          ${qtyPerItem}
    Log  ${request_body}
    [Return]  ${request_body}

Create Bundle Product Items  
    [Arguments]  ${template_file}  ${partner_id}  ${bundle_product_title}  ${productLineItemsList}  ${lineNumber}   ${qtyPerProduct}   ${grossAmount}=100.00
    ${request_body}  Get File  ${template_file}
    ${request_body}  Replace String    ${request_body}    VAR_LINE_NUNBER       ${lineNumber}
    ${request_body}  Replace String    ${request_body}    VAR_PARTNER_ID        ${partner_id}
    ${request_body}  Replace String    ${request_body}    VAR_PARTNER_ITEM_ID   ${bundle_product_title}
    ${request_body}  Replace String    ${request_body}    VAR_PRODUCT_QTY       ${qtyPerProduct}
    ${request_body}  Replace String    ${request_body}    VAR_GROSS_AMOUNT      ${grossAmount}
    ${request_body}  Replace String    ${request_body}    PRODUCT_LINE_ITEMS    ${productLineItemsList}
    Log  ${request_body}
    [Return]  ${request_body}   

Prepare Sales Order
    [Arguments]    ${template_file}   ${externalSalesOrderId}  ${partner_id}  ${expected_response}  ${productLineItemsList}  ${shipping_type}  ${payment_type}
    ${request_body}=   Create Sales Order Payload  ${template_file}  ${externalSalesOrderId}  ${partner_id}  ${productLineItemsList}  ${shipping_type}  ${payment_type}
    ${soKey}=   POST Sales Order via API   ${partner_id}  ${request_body}  ${expected_response}
    [Return]  ${soKey}

Create Sales Order Payload
    [Arguments]    ${template_file}  ${externalSalesOrderId}  ${partner_id}  ${productLineItemsList}  ${shipping_type}  ${payment_type}
    ##########    Get current date    ##########
    # ${externalSalesOrderId}=    Set Variable        SO_${partner_id}_${g_random_id}
    ${expected_receive_date}=   Add Time To Date    ${g_current_date}    1 days
    ##########    Set request body    ##########
    ${request_body}=    Get File   ${template_file}
    ${request_body}=    Replace String    ${request_body}    VAR_EXT_SO_ID      ${externalSalesOrderId}
    ${request_body}=    Replace String    ${request_body}    VAR_ORDER_DATE     ${g_current_date}
    ${request_body}=    Replace String    ${request_body}    VAR_INVOICE_DATE   ${expected_receive_date}
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_SHIPPING_TYPE       ${shipping_type}
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_PAYMENT_TYPE        ${payment_type}
    ${request_body}=    Replace String    ${request_body}    VAR_SUB_TOTAL              100.00
    ${request_body}=    Replace String    ${request_body}    VAR_GROSS_TOTAL            400
    ${request_body}=    Replace String    ${request_body}    VAR_GROSS_AMOUNT           400
    ${request_body}=    Replace String    ${request_body}    VAR_COLLECTION_AMOUNT      500
    ${request_body}=    Replace String    ${request_body}    VAR_INSURANCE_DECLARED_VALUE    600
    ${request_body}=    Replace String    ${request_body}    VAR_CURRENCY_UNIT           THB
    ${request_body}=    Replace String    ${request_body}    VAR_ORDER_NOTE              Beehive QA Testing
    ${request_body}=    Replace String    ${request_body}    VAR_SHIPPING_NOTE           Beehive QA Testing
    ${request_body}=    Replace String    ${request_body}    VAR_SALE_SUB_CH_NAME        Company Website
    ${request_body}=    Replace String    ${request_body}    VAR_SALE_CH_TYPE            Online
    ${request_body}=    Replace String    ${request_body}    VAR_SALE_CH_ID              Company Website
    ${request_body}=    Replace String    ${request_body}    VAR_CUSTOMER_TAX_ID         acommerce_TAX_0001
    ${request_body}=    Replace String    ${request_body}    VAR_CUSTOMER_TAX_TYPE       acommerce_TAX_TYPE_0001
    ${request_body}=    Replace String    ${request_body}    VAR_CUSTOMER_BRANCH_CODE    Company Website
    ${request_body}=    Replace String    ${request_body}    VAR_PRODUCT_LINE_ITEMS      ${productLineItemsList}
    Log  ${request_body}
    [Return]   ${request_body}

POST Sales Order via API
    [Arguments]   ${partner_id}  ${request_body}  ${expected_response}
    ##### HTTP Request
    Create Http Context   ${ORDER_STORE_URL}    http
    Set Request Header    Content-Type          ${CONTENT_TYPE}
    Set Request Header    X-User-Name           ${X_USER_NAME}
    Set Request Header    X-Roles               bo_${partner_id}
    Set Request Body      ${request_body}
    Next Request May Not Succeed
    POST                  ${ITEM_SALES_ORDER_PATH}
    ${response_status}=   Get Response Status
    Response Status Code Should Equal   ${expected_response}
    ${response_msg}=      Get Response Body
    Log   ${response_msg}
    ${getsoKey}=          Get Json Value    ${response_msg}   /key
    ${getsoKey}=          Remove String     ${getsoKey}       "
    [Return]    ${getsoKey}

Verify Inventory Items on IMS
    [Arguments]   ${partner_item_id}  ${expected_qty_ats}  ${expected_qty_onhand}
    ...                                 ${expected_qty_coolroom}
    ...                                 ${expected_qty_highvalue}
    ...                                 ${expected_qty_general}
    ...                                 ${expected_qty_quanrantine}
    ...                                 ${expected_qty_return}
    ${database_env}=  Connect to Inventory database
    Log  ${expected_qty_coolroom}
    ${return}=   Wait Until Keyword Succeeds  10x  5s	
    ...          query_inventory_item   ${database_env}  ${partner_id}  ${partner_item_id}
    ...                                 ${expected_qty_ats}  ${expected_qty_onhand}
    ...                                 ${expected_qty_coolroom}
    ...                                 ${expected_qty_highvalue}
    ...                                 ${expected_qty_general}
    ...                                 ${expected_qty_quanrantine}
    ...                                 ${expected_qty_return}
    Should Be Equal    '${return}'   '0'

Connect to Inventory database
    ${database_env}=  Get Connection String  ${IMS_DB_HOST}  ${IMS_DB_NAME}  ${IMS_DB_USER}  ${IMS_DB_PASSWORD}
    [Return]    ${database_env}

Wait until Fulfillment Order Status is PACKED
    Sleep  20s

Update Sales Order for Non GL
    [Arguments]   ${soKey}   ${partner_id}   ${update_non_gl_body}  ${expected_response}
    ${ISO_NON_GL_PATH}=  Replace String   ${ISO_NON_GL_PATH}  <CONFIG_PARTNER_ID>  ${partner_id}
    ${ISO_NON_GL_PATH}=  Replace String   ${ISO_NON_GL_PATH}  <SO_KEY>    ${soKey}

    ##### HTTP Request
    Create Http Context   ${ORDER_STORE_URL}    http
    Set Request Header    Content-Type          ${CONTENT_TYPE}
    Set Request Body      ${update_non_gl_body}
    Next Request May Not Succeed
    POST                  ${ISO_NON_GL_PATH}
    ${response_status}=   Get Response Status
    Response Status Code Should Equal   ${expected_response}
    ${response_msg}=      Get Response Body
    Should Be Equal    "success"  ${response_msg}

Unable to update Sales Order with error
    [Arguments]   ${soKey}   ${partner_id}   ${update_non_gl_body}  ${expected_response_msg}
    ${ISO_NON_GL_PATH}=  Replace String   ${ISO_NON_GL_PATH}  <CONFIG_PARTNER_ID>  ${partner_id}
    ${ISO_NON_GL_PATH}=  Replace String   ${ISO_NON_GL_PATH}  <SO_KEY>    ${soKey}

    ##### HTTP Request
    Create Http Context   ${ORDER_STORE_URL}    http
    Set Request Header    Content-Type          ${CONTENT_TYPE}
    Set Request Body      ${update_non_gl_body}
    Next Request May Not Succeed
    POST                  ${ISO_NON_GL_PATH}
    ${response_status}=   Get Response Status
    Response Status Code Should Equal   ${STATUS_400}
    ${response_msg}=      Get Response Body
    Should Contain       ${response_msg}   ${expected_response_msg}


Prepare Sales Order for max lenght
    [Arguments]    ${template_file}   
    ...            ${externalSalesOrderId}  
    ...            ${partner_id}  
    ...            ${expected_response}  
    ...            ${productLineItemsList}  
    ...            ${shipping_type}  
    ...            ${payment_type}
    ...            ${expected_shipment_addressee}
    ...            ${expected_shipment_address1}
    ...            ${expected_shipment_city}
    ...            ${expected_shipment_postalcode}
    ...            ${expected_shipment_country}

    ${request_body}=   Create Sales Order Payload for shipping address  ${template_file}  ${externalSalesOrderId}  ${partner_id}  
    ...            ${productLineItemsList}  ${shipping_type}  ${payment_type}
    ...            ${expected_shipment_addressee}
    ...            ${expected_shipment_address1}
    ...            ${expected_shipment_city}
    ...            ${expected_shipment_postalcode}
    ...            ${expected_shipment_country}  

    ${soKey}=   POST Sales Order via API   ${partner_id}  ${request_body}  ${expected_response}
    [Return]  ${soKey}

Create Sales Order Payload for shipping address
    [Arguments]    ${template_file}   
    ...            ${externalSalesOrderId}  
    ...            ${partner_id}  
    ...            ${productLineItemsList}  
    ...            ${shipping_type}  
    ...            ${payment_type}
    ...            ${expected_shipment_addressee}
    ...            ${expected_shipment_address1}
    ...            ${expected_shipment_city}
    ...            ${expected_shipment_postalcode}
    ...            ${expected_shipment_country}

    ##########    Get current date    ##########
    ${expected_receive_date}=   Add Time To Date    ${g_current_date}    1 days
    ##########    Set request body    ##########
    ${request_body}=    Get File   ${template_file}
    ${request_body}=    Replace String    ${request_body}    VAR_EXT_SO_ID      ${externalSalesOrderId}
    ${request_body}=    Replace String    ${request_body}    VAR_ORDER_DATE     ${g_current_date}
    ${request_body}=    Replace String    ${request_body}    VAR_INVOICE_DATE   ${expected_receive_date}
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_SHIPPING_TYPE       ${shipping_type}
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_PAYMENT_TYPE        ${payment_type}
    ${request_body}=    Replace String    ${request_body}    VAR_SUB_TOTAL              100.00
    ${request_body}=    Replace String    ${request_body}    VAR_GROSS_TOTAL            400
    ${request_body}=    Replace String    ${request_body}    VAR_GROSS_AMOUNT           400
    ${request_body}=    Replace String    ${request_body}    VAR_COLLECTION_AMOUNT      500
    ${request_body}=    Replace String    ${request_body}    VAR_INSURANCE_DECLARED_VALUE    600
    ${request_body}=    Replace String    ${request_body}    VAR_CURRENCY_UNIT           THB
    ${request_body}=    Replace String    ${request_body}    VAR_ORDER_NOTE              Beehive QA Testing
    ${request_body}=    Replace String    ${request_body}    VAR_SHIPPING_NOTE           Beehive QA Testing
    ${request_body}=    Replace String    ${request_body}    VAR_SALE_SUB_CH_NAME        Company Website
    ${request_body}=    Replace String    ${request_body}    VAR_SALE_CH_TYPE            Online
    ${request_body}=    Replace String    ${request_body}    VAR_SALE_CH_ID              Company Website
    ${request_body}=    Replace String    ${request_body}    VAR_CUSTOMER_TAX_ID         acommerce_TAX_0001
    ${request_body}=    Replace String    ${request_body}    VAR_CUSTOMER_TAX_TYPE       acommerce_TAX_TYPE_0001
    ${request_body}=    Replace String    ${request_body}    VAR_CUSTOMER_BRANCH_CODE    Company Website
    ${request_body}=    Replace String    ${request_body}    VAR_PRODUCT_LINE_ITEMS      ${productLineItemsList}
    ${request_body}=    Replace String    ${request_body}    VAR_SHIPMENT_ADDRESSEE      ${expected_shipment_addressee}
    ${request_body}=    Replace String    ${request_body}    VAR_SHIPMENT_ADDRESS1       ${expected_shipment_address1}
    ${request_body}=    Replace String    ${request_body}    VAR_SHIPMENT_CITY           ${expected_shipment_city}
    ${request_body}=    Replace String    ${request_body}    VAR_SHIPMENT_POSTALCODE     ${expected_shipment_postalcode}
    ${request_body}=    Replace String    ${request_body}    VAR_SHIPMENT_COUNTRY        ${expected_shipment_country}
    Log  ${request_body}
    [Return]   ${request_body}

Cancel Sales Order
    [Arguments]    ${template_file}   ${cancel_soKey}  ${reason}  ${reason_code}    ${expected_response}
    ${request_body}=   Create Cancel Sales Order Payload  ${template_file}  ${cancel_soKey}  ${reason}  ${reason_code}
    POST Cancel Sales Order via API   ${cancel_soKey}  ${request_body}  ${expected_response}

Create Cancel Sales Order Payload
    [Arguments]    ${template_file}   ${cancel_soKey}  ${reason}  ${reason_code}
    ##########    Set request body    ##########
    ${request_body}=    Get File   ${template_file}
    ${request_body}=    Replace String    ${request_body}    VAR_REASON         ${reason}
    ${request_body}=    Replace String    ${request_body}    VAR_CODE           ${reason_code}
    Log  ${request_body}
    [Return]   ${request_body}

POST Cancel Sales Order via API
    [Arguments]   ${cancel_soKey}  ${request_body}  ${expected_response}
    # Replace global resource variable
    ${CANCEL_ITEM_SALES_ORDER_PATH}=   Replace String   ${CANCEL_ITEM_SALES_ORDER_PATH}  <SO_KEY>    ${cancel_soKey}
    ##### HTTP Request
    Create Http Context   ${ORDER_STORE_URL}    http
    Set Request Header    Content-Type          ${CONTENT_TYPE}
    Set Request Header    X-User-Name           ${X_USER_NAME}
    Set Request Header    X-Roles               bo_${partner_id}
    Set Request Body      ${request_body}
    Next Request May Not Succeed
    POST                  ${CANCEL_ITEM_SALES_ORDER_PATH}
    ${response_status}=   Get Response Status
    Response Status Code Should Equal   ${expected_response}
    # ${response_msg}=      Get Response Body
    # Log   ${response_msg}
    # ${getsoKey}=          Get Json Value    ${response_msg}   /key
    # ${getsoKey}=          Remove String     ${getsoKey}       "
    # [Return]    ${getsoKey}

Verify RMA API
    [Arguments]   ${cancel_soKey}  ${request_body}  ${expected_response}
    # Replace global resource variable
    ${CANCEL_ITEM_SALES_ORDER_PATH}=   Replace String   ${CANCEL_ITEM_SALES_ORDER_PATH}  <SO_KEY>    ${cancel_soKey}
    ##### HTTP Request
    Create Http Context   ${ORDER_STORE_URL}    http
    Set Request Header    Content-Type          ${CONTENT_TYPE}
    Set Request Header    X-User-Name           ${X_USER_NAME}
    Set Request Header    X-Roles               bo_${partner_id}
    Set Request Body      ${request_body}
    Next Request May Not Succeed
    POST                  ${CANCEL_ITEM_SALES_ORDER_PATH}
    ${response_status}=   Get Response Status
    Response Status Code Should Equal   ${expected_response}