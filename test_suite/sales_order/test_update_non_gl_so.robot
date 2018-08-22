*** Settings ***
Documentation     BEEH-1562 So update for non GL impact fields
Resource          ../resource/group_vars/${env}/global_resource.robot
Resource          ../resource/resource_sale_order_method.robot
Resource          ../resource/resource_item_master_method.robot
Resource          ../resource/resource_purchase_order_method.robot
Resource          ../resource/resource_portal.robot
Resource          ../resource/resource_mongoDB_method.robot
Resource          ../resource/resource_rabbitmq_method.robot
Test Setup        Initial Queue

*** Variable ***
${partner_id}                           ${PARTNER_ID_SC_TH}
${item_master_template}                 ${SO_TEST_DATA}/json/item_master_template.json
${purchase_order_template}              ${SO_TEST_DATA}/json/purchase_order_template.json
${productLineItem_template}             ${SO_TEST_DATA}/json/productLineItems_template.json
${sales_order_template}                 ${SO_TEST_DATA}/json/sales_order_template.json
${bundle_productLineItems_template}     ${SO_TEST_DATA}/json/bundle_productLineItems_template.json
${lineItems_template}                   ${SO_TEST_DATA}/json/LineItems_template.json
${template_so_non_gl_customerInfo}                 ${SO_TEST_DATA}/json/Non-GL/update_customerInfo.json
${template_so_non_gl_orderShipmentInfo}            ${SO_TEST_DATA}/json/Non-GL/update_orderShipmentInfo.json
${template_so_non_gl_orderBillingInfo}             ${SO_TEST_DATA}/json/Non-GL/update_orderBillingInfo.json
${template_so_non_gl_shippingType}                 ${SO_TEST_DATA}/json/Non-GL/update_shippingType.json
${template_so_non_gl_all}                          ${SO_TEST_DATA}/json/Non-GL/update_all_non_gl.json

*** Test Cases ***
SO_NON_GL_001
    [Documentation]  Verify that customerInfo for Sales Order can be updated successfully
    [Tags]   Sales Order Update
    ############# Preparation ###############
    Prepare Simple SO for update
    ############# Test Data #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_customerInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_DISTICT      เขตวัฒนา1
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_EMAIL        bs1@acommerce.asia
    Log   ${update_non_gl_body}
    comment  -------- Update the Sales Order for Non GL fields --------
    Update Sales Order for Non GL   ${soKey}   ${partner_id}   ${update_non_gl_body}   ${STATUS_200} 
    comment  -------- Sales Order Updated on Order Exchange  --------
    Verify the Messages for Sales Order Updated on Order Exchange 
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

SO_NON_GL_002
    [Documentation]  Verify that orderBillingInfo for Sales Order can be updated successfully
    [Tags]   Sales Order Update
    ############# Preparation ###############
    Prepare Simple SO for update
    ############# Test Data #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_orderShipmentInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESSEE    Dominic Torretto orderBillingInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_EMAIL        bs1@acommerce.asia
    Log   ${update_non_gl_body}
    comment  -------- Update the Sales Order for Non GL fields --------
    Update Sales Order for Non GL   ${soKey}   ${partner_id}   ${update_non_gl_body}   ${STATUS_200} 
    comment  -------- Sales Order Updated on Order Exchange  --------
    Verify the Messages for Sales Order Updated on Order Exchange 
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

SO_NON_GL_003
    [Documentation]  Verify that orderShipmentInfo for Sales Order can be updated successfully
    [Tags]   Sales Order Update
    ############# Preparation ###############
    Prepare Simple SO for update
    ############# Test Data #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_orderShipmentInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESSEE    Dominic Torretto orderShipmentInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_EMAIL        bs1@acommerce.asia
    Log   ${update_non_gl_body}
    comment  -------- Update the Sales Order for Non GL fields --------
    Update Sales Order for Non GL   ${soKey}   ${partner_id}   ${update_non_gl_body}   ${STATUS_200} 
    comment  -------- Sales Order Updated on Order Exchange  --------
    Verify the Messages for Sales Order Updated on Order Exchange 
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

SO_NON_GL_004
    [Documentation]  Verify that shippingType for Sales Order can be updated successfully
    [Tags]   Sales Order Update  test
    ############# Preparation ###############
    Prepare Simple SO for update
    ############# Test Data #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_shippingType}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_SHIPPING_TYPE    STANDARD_2_4_DAYS
    Log   ${update_non_gl_body}
    comment  -------- Update the Sales Order for Non GL fields --------
    Update Sales Order for Non GL   ${soKey}   ${partner_id}   ${update_non_gl_body}   ${STATUS_200} 
    comment  -------- Sales Order Updated on Order Exchange  --------
    Verify the Messages for Sales Order Updated on Order Exchange 
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

SO_NON_GL_005
    [Documentation]  Verify that all non gl for Sales Order can be updated successfully
    [Tags]   Sales Order Update
    ############# Preparation ###############
    Prepare Simple SO for update
    ############# Test Data #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_all}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_EMAIL        bs1@acommerce.asia
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESSEE    Dominic Torretto orderBillingInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_EMAIL        bs1@acommerce.asia
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESSEE    Dominic Torretto orderShipmentInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_EMAIL        bs1@acommerce.asia
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_SHIPPING_TYPE    STANDARD_2_4_DAYS
    Log   ${update_non_gl_body}
    comment  -------- Update the Sales Order for Non GL fields --------
    Update Sales Order for Non GL   ${soKey}   ${partner_id}   ${update_non_gl_body}   ${STATUS_200} 
    comment  -------- Sales Order Updated on Order Exchange  --------
    Verify the Messages for Sales Order Updated on Order Exchange 
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

SO_NON_GL_006
    [Documentation]  Verify that updating customerInfo for Sales Order required mandatory fields
    [Tags]   Sales Order Update
    ############# Preparation ###############
    Prepare Simple SO for update
    ############# Test Data 1.1 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_customerInfo}
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "addressee": "VAR_CUSTOMER_INFO_ADDRESSEE",  ${EMPTY}
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field is required."
    ############# Test Data 1.2 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_customerInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESSEE    Dominic Torretto customerInfo
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "address1": "VAR_CUSTOMER_INFO_ADDRESS1",   ${EMPTY}
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field is required."  
    ############# Test Data 1.3 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_customerInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PROVINCE     กรุงเทพ
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "postalCode": "VAR_CUSTOMER_INFO_POSTALCODE",   ${EMPTY}
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field is required."
    ############# Test Data 1.4 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_customerInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_POSTALCODE   10110
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "country": "VAR_CUSTOMER_INFO_COUNTRY",   ${EMPTY}
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field is required."
    ############# Test Data 1.5 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_customerInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_COUNTRY      Thailand
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "phone": "VAR_CUSTOMER_INFO_PHONE",   ${EMPTY}
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field is required."
    ############# Test Data 1.6 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_customerInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_CUSTOMER_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "address2": "VAR_CUSTOMER_INFO_ADDRESS2",   ${EMPTY}
    Log   ${update_non_gl_body}
    comment  -------- Update the Sales Order for Non GL fields --------
    Update Sales Order for Non GL   ${soKey}   ${partner_id}   ${update_non_gl_body}   ${STATUS_200} 
    comment  -------- Sales Order Updated on Order Exchange  --------
    Verify the Messages for Sales Order Updated on Order Exchange 
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

SO_NON_GL_007
    [Documentation]  Verify that updating orderBillingInfo for Sales Order required mandatory fields
    [Tags]   Sales Order Update
    ############# Preparation ###############
    Prepare Simple SO for update
    ############# Test Data 1.1 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_orderBillingInfo}
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "addressee": "VAR_ORDER_BILLING_INFO_ADDRESSEE",  ${EMPTY}
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field is required."
    ############# Test Data 1.2 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_orderBillingInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESSEE    Dominic Torretto customerInfo
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "address1": "VAR_ORDER_BILLING_INFO_ADDRESS1",   ${EMPTY}
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field is required."
    ############# Test Data 1.3 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_orderBillingInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PROVINCE     กรุงเทพ
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "postalCode": "VAR_ORDER_BILLING_INFO_POSTALCODE",   ${EMPTY}
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field is required."
    ############# Test Data 1.4 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_orderBillingInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_POSTALCODE   10110
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "country": "VAR_ORDER_BILLING_INFO_COUNTRY",   ${EMPTY}
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field is required."
    ############# Test Data 1.5 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_orderBillingInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_COUNTRY      Thailand
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "phone": "VAR_ORDER_BILLING_INFO_PHONE",   ${EMPTY}
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field is required."
    ############# Test Data 1.6 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_orderBillingInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_PHONE        0841234567
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_BILLING_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "phone": "0841234567",   "phone": "0841234567"
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "email": "VAR_ORDER_BILLING_INFO_EMAIL"   ${EMPTY}
    Log   ${update_non_gl_body}
    comment  -------- Update the Sales Order for Non GL fields --------
    Update Sales Order for Non GL   ${soKey}   ${partner_id}   ${update_non_gl_body}   ${STATUS_200} 
    comment  -------- Sales Order Updated on Order Exchange  --------
    Verify the Messages for Sales Order Updated on Order Exchange 
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

SO_NON_GL_008
    [Documentation]  Verify that updating orderShipmentInfo for Sales Order required mandatory fields
    [Tags]   Sales Order Update
    ############# Preparation ###############
    Prepare Simple SO for update
    ############# Test Data 1.1 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_orderShipmentInfo}
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "addressee": "VAR_ORDER_SHIPMENT_INFO_ADDRESSEE",  ${EMPTY}
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field is required."
    ############# Test Data 1.2 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_orderShipmentInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESSEE    Dominic Torretto customerInfo
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "address1": "VAR_ORDER_SHIPMENT_INFO_ADDRESS1",   ${EMPTY}
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field is required."
    ############# Test Data 1.3 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_orderShipmentInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESSEE    Dominic Torretto customerInfo
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PROVINCE     กรุงเทพ
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "postalCode": "VAR_ORDER_SHIPMENT_INFO_POSTALCODE",   ${EMPTY}
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field is required."
    ############# Test Data 1.4 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_orderShipmentInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_POSTALCODE   10110
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "country": "VAR_ORDER_SHIPMENT_INFO_COUNTRY",   ${EMPTY}
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field is required."
    ############# Test Data 1.5 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_orderShipmentInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_COUNTRY      Thailand
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "phone": "VAR_ORDER_SHIPMENT_INFO_PHONE",   ${EMPTY}
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field is required."
    ############# Test Data 1.6 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_orderShipmentInfo}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESSEE    Dominic Torretto customerInfo
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS1     47/641 โคงการ 11 ซ.2 หมู่บ้านเคซี การ์เด้น โฮม ถนนนิตใหม่
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_ADDRESS2     ชั้น 33 ถนนสุขุมวิท
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_SUBDISTICT   แขวงคลองตันเหนือ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_DISTICT      เขตวัฒนา
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_CITY         กรุงเทพมหานคร/ Bangkok
    # ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PROVINCE     กรุงเทพ
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_POSTALCODE   10110
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_COUNTRY      Thailand
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_PHONE        0841234567
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_ORDER_SHIPMENT_INFO_EMAIL        bs1@acommerce.asia
    ## Remove mandatory fields
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "province": "VAR_ORDER_SHIPMENT_INFO_PROVINCE",   ${EMPTY}
    Log   ${update_non_gl_body}
    comment  -------- Update the Sales Order for Non GL fields --------
    Update Sales Order for Non GL   ${soKey}   ${partner_id}   ${update_non_gl_body}   ${STATUS_200} 
    comment  -------- Sales Order Updated on Order Exchange  --------
    Verify the Messages for Sales Order Updated on Order Exchange 
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

SO_NON_GL_009
    [Documentation]  Verify that shippingType for Sales Order cannot be unknown type
    [Tags]   Sales Order Update
    ############# Preparation ###############
    Prepare Simple SO for update
    ############# Test Data 1.1 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_shippingType}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_SHIPPING_TYPE    UNKNOWN
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "Invalid shippingType"
    ############# Test Data 1.2 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_shippingType}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_SHIPPING_TYPE    STANDARD_2_4_DAY
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "Invalid shippingType"
    ############# Test Data 1.3 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_shippingType}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_SHIPPING_TYPE    next_day
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "Invalid shippingType"
    ############# Test Data 1.4 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_shippingType}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  VAR_SHIPPING_TYPE    NEXT DAY
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "Invalid shippingType"
    ############# Test Data 1.5 #################
    ${update_non_gl_body}=  Get File    ${template_so_non_gl_shippingType}
    ${update_non_gl_body}=  Replace String   ${update_non_gl_body}  "VAR_SHIPPING_TYPE"    null
    Log   ${update_non_gl_body}
    Unable to update Sales Order with error    ${soKey}    ${partner_id}   ${update_non_gl_body}  "This field may not be null."

*** Keywords ***
##### Locally 
Prepare Simple SO for update
    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}
    comment  -------- Test Data --------
    ${externalSalesOrderId}=    Set Variable     PACKED_${partner_id}_${g_random_id}
    Log to console   "Sales Order Id = ${externalSalesOrderId}"

    comment  -------- Prepare Inventory Items --------
    ### General
    ${partnerItemId}=   Prepare Inventory Items   ${item_master_template}  ${partner_id}  ${STATUS_200}   General     FIFO  false   false
    ${partnerItemId_General}=  Set Variable   ${partnerItemId}
    ${partnerPurchaseItemId}=   Prepare Purchase Order TH   ${purchase_order_template}  ${partner_id}  ${STATUS_201}  ${partnerItemId}   10
    ### Cool Room
    ${partnerItemId}=   Prepare Inventory Items   ${item_master_template}  ${partner_id}  ${STATUS_200}   Cool Room   FIFO  false   false
    ${partnerItemId_CoolRoom}=  Set Variable   ${partnerItemId}
    ${partnerPurchaseItemId}=   Prepare Purchase Order TH   ${purchase_order_template}  ${partner_id}  ${STATUS_201}  ${partnerItemId}   10
    ### High Value
    ${partnerItemId}=   Prepare Inventory Items   ${item_master_template}  ${partner_id}  ${STATUS_200}   High Value  FIFO  false   false
    ${partnerItemId_HighValue}=  Set Variable   ${partnerItemId}
    ${partnerPurchaseItemId}=   Prepare Purchase Order TH   ${purchase_order_template}  ${partner_id}  ${STATUS_201}  ${partnerItemId}   10

    comment  -------- Prepare Line Product item --------
    ${productLineItems_General}=  Create Product Line Items  ${productLineItem_template}  ${partner_id}  ${partnerItemId_General}   1   1  1
    ${productLineItems_CoolRoom}=  Create Product Line Items  ${productLineItem_template}  ${partner_id}  ${partnerItemId_CoolRoom}   2  1  1
    ${productLineItems_HighValue}=  Create Product Line Items  ${productLineItem_template}  ${partner_id}  ${partnerItemId_HighValue}  3  1  1
    ${productLineItemsList}=  Catenate  ${productLineItems_General}  ${COMMA}  ${productLineItems_CoolRoom}   ${COMMA}  ${productLineItems_HighValue}
    comment  -------- Create Sales Order --------
    ${soKey}=  Prepare Sales Order    
    ...           ${sales_order_template}
    ...           ${externalSalesOrderId}
    ...           ${partner_id}
    ...           ${STATUS_201}
    ...           ${productLineItemsList}
    ...           ${SHIPPING_TYPE_STANDARD_2_4_DAYS}
    ...           ${PAYMENT_TYPE_COD}
    Log To Console  "soKey = ${soKey}"

    comment  -------- Sales Order Create on Order Exchange  --------
    Verify the Messages for Sales Order Create on Order Exchange  
    ...   ${soKey}
    ...   ${headerPublisherId}
    ...   ${partnerId}
    ...   ${externalSalesOrderId}
    ...   ${salesChannelId}
    ...   ${paymentType}
    ...   ${shippingType}
    ...   ${partnerItemId_General}
    ...   ${partnerItemId_CoolRoom}
    ...   ${partnerItemId_HighValue}

    Set Global Variable   ${soKey}   ${soKey}
    Set Global Variable   ${externalSalesOrderId}  ${externalSalesOrderId}
    Set Global Variable   ${salesChannelId}  ${salesChannelId}
    Set Global Variable   ${paymentType}  ${paymentType}
    Set Global Variable   ${shippingType}  ${shippingType}
    Set Global Variable   ${partnerItemId_General}  ${partnerItemId_General}
    Set Global Variable   ${partnerItemId_CoolRoom}  ${partnerItemId_CoolRoom}
    Set Global Variable   ${partnerItemId_HighValue}  ${partnerItemId_HighValue}
