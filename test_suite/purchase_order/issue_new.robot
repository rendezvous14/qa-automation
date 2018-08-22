*** Settings ***
# Suite Setup       Prepare po mock data
# Test Teardown     Teardown po master method
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
PO_ISSUE_001
    [Documentation]   [PO] Cannot create PO on NS when there is duplicated PO Id with SO Id on NS
    ...    - AMP
    ...    - NS
    ...    - 3652   #Partner Agent
    [Tags]    Purchase Order
    ####### Common Variables #########
    ${g_current_date}=    Get Current Date    UTC
    ${g_random_id}=     Convert date    ${g_current_date}  result_format=%Y%m%d_%H%M%S
    ${g_partner_id}=    Set Variable    3652
    Set Global Variable    ${g_current_date}
    Set Global Variable    ${g_random_id}
    Set Global Variable    ${g_partner_id}
    ${partnerSalesOrderId}=   Set Variable    SO_${g_partner_id}_${g_random_id}
    ####### Item master #########
    # ${partner_item_id}=   Prepare Inventory Items for Sales Orders  ${R_TEMPLATE_ITEM_MASTER}   General   false    false
    ####### Purchase Order #########
    ${partner_item_id}=    Set Variable    ITEM_3916_20171207_172058
    # ${partner_purchase_order_id}=   Prepare Purchase Order for Sales Orders  ${R_TEMPLATE_PO_ONE_ITEM}   ${partner_item_id}  100
    ####    Send Http request    #####
    ${request_body}=    Prepare Simple Sales Order template   ${R_TEMPLATE_SO_SINGLE_LINE_SINGLE_ITEM}  ${partnerSalesOrderId}
    ####### SO Test Data ########
    ${request_body}=    Replace String    ${request_body}    VAR_CURRENCY_UNIT               THB
    ${request_body}=    Replace String    ${request_body}    VAR_SUB_TOTAL                   100.00
    ${request_body}=    Replace String    ${request_body}    VAR_GROSS_TOTAL                 100.00
    ${request_body}=    Replace String    ${request_body}    VAR_COLLECTION_AMOUNT           100.00
    ${request_body}=    Replace String    ${request_body}    VAR_INSURANCE_DECLARED_VALUE    100.00
    ${request_body}=    Replace String    ${request_body}    VAR_LINE_NUMBER                 1
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_ID                  ${g_partner_id}
    ${request_body}=    Replace String    ${request_body}    VAR_PRODUCT_ID                  ${partner_item_id}
    ${request_body}=    Replace String    ${request_body}    VAR_PRODUCT_TITLE               ${partner_item_id}
    ${request_body}=    Replace String    ${request_body}    VAR_PRODUCT_QTY                 1
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_ITEM_ID             ${partner_item_id}
    ${request_body}=    Replace String    ${request_body}    VAR_PARTNER_ID                  ${g_partner_id}
    ${request_body}=    Replace String    ${request_body}    VAR_ITEM_QTY                    1
    ${request_body}=    Replace String    ${request_body}    VAR_GROSS_AMOUNT                100.00
    Log   ${request_body}
    ####### Send HTTP Request #####
    # Create Sales Order via API successfully  ${R_PARTNER_ID_SCALE_2}  ${request_body}

*** Keywords ***
Prepare Simple Sales Order template
    [Arguments]   ${template_file}   ${partnerSalesOrderId}
    ${orderDate}=    Set Variable    ${g_current_date}
    ${inputInvoiceDate}=    Set Variable    ${g_random_id}
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