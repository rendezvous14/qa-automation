*** Settings ***
Documentation     BEEH-834 [Front End] [Order Store]
...               Ability to adjust GRN price on Beehive UI
Test Setup        Init Rabbitmq Connection    queue-common.acommercedev.service   5672   admin  aCom1234   common-qa
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
GRN_UI_001 Single Item
    [Documentation]   Verify that GRN's price can be updated and saved to database successfully - single item
    [Tags]  GRN
    ############# Test Data #################
    ${line_item_number_1}=    Set Variable    1
    ${price_1}=               Set Variable    123456789.12345
    ${grn_key}=               Set Variable    IITV6QM2XB1FLMGAF0QHNWTQ7
    ${price_cleanup}=         Set Variable    999.99
    ############# Test Steps ################
    Consume Order GRN queue
    Modify GRN Price on UI   ${grn_key}   ${price_1}
    Confirm GRN Price has been saved into order store correctly   ${grn_key}   ${line_item_number_1}  ${price_1}
    Confirm GRN Price has been published to order exchange correctly  ${grn_key}  ${line_item_number_1}  ${price_1}
    [Teardown]   Clean up GRN price   ${grn_key}  ${price_cleanup}

GRN_UI_002 Multiple Items
    [Documentation]   Verify that GRN's price can be updated and saved to database successfully - multiple items
    [Tags]  GRN
    ############# Test Data #################
    ${line_item_number_1}=    Set Variable    1
    ${line_item_number_2}=    Set Variable    2
    ${line_item_number_3}=    Set Variable    3
    ${line_item_number_4}=    Set Variable    4
    ${line_item_number_5}=    Set Variable    5
    ${price_1}=               Set Variable    0
    ${price_2}=               Set Variable    1
    ${price_3}=               Set Variable    99999999.99999
    ${price_4}=               Set Variable    100
    ${price_5}=               Set Variable    0.55555
    ${grn_key}=               Set Variable    GNQOUEN2ZNXL40BVB6J6U3912
    ${price_list_cleanup}=    Create List     999.99  999.99  999.99  999.99  999.99
    ${line_item_list}=        Create List  ${line_item_number_1}  ${line_item_number_2}   ${line_item_number_3}   ${line_item_number_4}  ${line_item_number_5}
    ${price_list}=            Create List  ${price_1}  ${price_2}   ${price_3}   ${price_4}  ${price_5}
    ############# Test Steps ################
    Consume Order GRN queue
    Modify Multiple GRN Price on UI   ${grn_key}  ${line_item_list}   ${price_list}
    Confirm Multiple GRN Price has been saved into order store correctly  ${grn_key}  ${line_item_list}  ${price_list}
    Confirm Multiple GRN Price has been published to order exchange correctly   ${grn_key}   ${line_item_list}  ${price_list}
    [Teardown]   Clean up Multiple GRN price   ${grn_key}   ${line_item_list}  ${price_list_cleanup}
