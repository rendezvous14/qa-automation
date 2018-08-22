*** Settings ***
Documentation     Create item with new field
Resource          ../resource/group_vars/${env}/global_resource.robot
Resource          ../resource/resource_item_master_method.robot
Resource          ../resource/resource_portal.robot
Resource          ../resource/resource_mongoDB_method.robot
Resource          ../resource/resource_netsuite.robot
#Resource          ../resource/resource_rabbitmq_method.robot
#Test Setup        Initial Queue

*** Variables ***
${partner_id}           ${PARTNER_ID_SC_TH}
${partner_name}         ${PARTNER_NAME_SC_TH}
${partner_slug}         ${PARTNER_SLUG_SC_TH}
${partner_prefix}       ${PARTNER_PREFIX_SC_TH}
${item_master_template}       ${SO_TEST_DATA}/json/item_master_template.json
${purchase_order_template}    ${SO_TEST_DATA}/json/purchase_order_template.json
${productLineItem_template}   ${SO_TEST_DATA}/json/productLineItems_template.json
${sales_order_template}       ${SO_TEST_DATA}/json/sales_order_template.json
${bundle_productLineItems_template}   ${SO_TEST_DATA}/json/bundle_productLineItems_template.json
${lineItems_template}       ${SO_TEST_DATA}/json/LineItems_template.json

*** Test Cases ***
ITEM_GDPMDS_001
    [Documentation]   Verify item has been created successfully with isGDPMDS field that have default value on NS and display on UI

    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}

    comment  -------- Prepare Inventory Items --------
    ### General
    ${partnerItemId}=   Prepare Inventory Items   ${item_master_template}  ${partner_id}  ${STATUS_200}   General   FIFO  false   false
    ${itemKey}=  Set Variable   ${g_ItemKey}
    ${partnerItemId_General}=  Set Variable   ${partnerItemId}
    Verify Item on portal    ${partner_id}  ${partnerItemId_General}  Beehive QA automation
    Verify Item on NS        ${partner_id}  ${partnerItemId_General}  Beehive QA automation
    Verify Item on DB  ${itemKey}  partnerItemId  ${partnerItemId_General}
    Verify Item on DB  ${itemKey}  description  Beehive QA automation
    Verify Item on DB  ${itemKey}  isGDPMDS  false

ITEM_GDPMDS_002
    [Documentation]   Verify item has been created successfully with isGDPMDS field is false value on NS and display on UI

    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}

    comment  -------- Prepare Inventory Items --------
    ### General
    ${partnerItemId}=   Prepare Inventory Items   ${item_master_template}  ${partner_id}  ${STATUS_200}   General   FIFO  false   false   false
    ${itemKey}=  Set Variable   ${g_ItemKey}
    ${partnerItemId_General}=  Set Variable   ${partnerItemId}
    Verify Item on portal    ${partner_id}  ${partnerItemId_General}  Beehive QA automation
    Verify Item on NS        ${partner_id}  ${partnerItemId_General}  Beehive QA automation
    Verify Item on DB  ${itemKey}  partnerItemId  ${partnerItemId_General}
    Verify Item on DB  ${itemKey}  description  Beehive QA automation
    Verify Item on DB  ${itemKey}  isGDPMDS  false

ITEM_GDPMDS_003
    [Documentation]   Verify item has been created successfully with isGDPMDS field is true value on NS and display on UI

    comment  -------- Defined Variables --------
    ${current_date}  Get Current Date
    ${random_id}     Convert date   ${current_date}  result_format=%Y%m%d%H%M%S
    Set Global Variable    ${g_current_date}    ${current_date}
    Set Global Variable    ${g_random_id}    ${random_id}

    comment  -------- Prepare Inventory Items --------
    ### General
    ${partnerItemId}=   Prepare Inventory Items   ${item_master_template}  ${partner_id}  ${STATUS_200}   General   FIFO  false   false   true
    ${itemKey}=  Set Variable   ${g_ItemKey}
    ${partnerItemId_General}=  Set Variable   ${partnerItemId}
    Verify Item on portal    ${partner_id}  ${partnerItemId_General}  Beehive QA automation
    Verify Item on NS        ${partner_id}  ${partnerItemId_General}  Beehive QA automation
    Verify Item on DB  ${itemKey}  partnerItemId  ${partnerItemId_General}
    Verify Item on DB  ${itemKey}  description  Beehive QA automation
    Verify Item on DB  ${itemKey}  isGDPMDS  true