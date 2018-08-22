*** Settings ***
Resource          ../resource/All_global_resource.robot
Resource          ../resource/All_global_library.robot

*** Test Cases ***
SUP_API_001_[supplierName] input correct TH language Mandatory
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    ซัพพลายเออร์_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_002_[supplierName] input correct EN language Mandatory
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_003_[supplierName] input correct CH language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    咖啡店_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_004_[supplierName] input correct KR language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    안녕_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_005_[supplierName] input correct JP language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    こんにちは_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_006_[supplierName] input over length
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}_12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_007_[supplierName] input empty string
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    ${EMPTY}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_404_NOT_FOUND}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_008_[supplierName] input space
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API${SPACE}${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_009_[supplierName] input special char
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    [API_${random}]
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_010_[supplierName] dupplicate in patner
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_011_[contactName] input correct TH language Mandatory
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    นางสาวสวย
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_012_[contactName] input correct EN language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    qa_automate
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_013_[contactName] input correct CH language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    咖啡店
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_014_[contactName] input correct KR language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    안녕
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_015_[contactName] input correct JP language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    こんにちは
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_016_[contactName] input over length
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    Contact_name_Contact_name_Contact_name_Contact_name_Contact_name_Contact_name_Contact_name_Contact_name_Contact_name_Contact_name
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_016_[contactName] input empty string
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_017_[contactName] input space
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    qa${SPACE}automate
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_018_[contactName] input special char
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    [qa_automate]
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_019_[contactName] Deleted contactName
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Remove String    ${request_body}    "contactName": "VAR_CONTACT"
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${request_body}    Replace String    ${request_body}    "initiate": false,    "initiate": false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_020_[addressee] addressee TH language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    ชื่อซัพพลายเออร์
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_021_[addressee] addressee TH language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_022_[addressee] addressee CN language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    咖啡店
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_023_[addressee] addressee KR language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    안녕
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_024_[addressee] addressee JP language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    こんにちは
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_025_[addressee] addressee over length (max 255 chars)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee_1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_026_[addressee] addressee empty
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_027_[addressee] addressee has space
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    qa${SPACE}automate
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_028_[addressee] addressee has spacial char
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    [qa_automate]
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_029_[address1] Deleted address1
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    qa_automate
    ${request_body}    Remove String    ${request_body}    "address1" : "VAR_ADDRESS1",
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_030_[address1] address1 TH language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    บางนา
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_031_[address1] address1 EN language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_032_[address1] address1 CN language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    咖啡店
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_033_[address1] address1 KR language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    안녕
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_034_[address1] address1 JP language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    こんにちは
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_035_[address1] address1 over length (max 300 chars)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1_12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_036_[address1] address1 empty
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_037_[address1] address1 has space
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    qa${SPACE}automate
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_038_[address1] address1 has spacial char
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    [qa_automate]
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_039_[address2] address2 TH language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    บางนา
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_040_[address2] address2 EN language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_041_[address2] address2 CN language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    咖啡店
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_042_[address2] address2 KR language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    안녕
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_043_[address2] address2 JP language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    こんにちは
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_044_[address2] address2 over length (max 300 chars)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2_12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_045_[address2] address2 empty
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_046_[address2] address2 has space
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    qa${SPACE}automate
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_047_[address2] address2 has special char
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    [Address2]
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_048_[address2] delete address2
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Remove String    ${request_body}    "address2" : "VAR_ADDRESS2",
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub district
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_049_[subDistrict] subDistrict TH language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    กิ่งอำเภอ
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_050_[subDistrict] subDistrict EN language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_051_[subDistrict] subDistrict CN language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    咖啡店
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_052_[subDistrict] subDistrict KR language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    안녕
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_053_[subDistrict] subDistrict JP language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    こんにちは
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_054_[subDistrict] subDistrict over length (max 160 chars)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub_district_12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_055_[subDistrict] subDistrict empty
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_056_[subDistrict] subDistrict has space
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    qa${SPACE}automate
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_057_[subDistrict] subDistrict has special char
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    [qa_automate]
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_058_[subDistrict] delete subDistrict
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Remove String    ${request_body}    "subDistrict" :"VAR_SUB_DISTRICT",
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_059_[district] district TH language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    ตำบล
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_060_[district] district EN language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_061_[district] district CN language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    咖啡店
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_062_[district] district KR language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    안녕
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_063_[district] district JP language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    こんにちは
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_064_[district] district over length (max 300 chars)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    Sub_district_12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_065_[district] district empty
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_066_[district] district has space
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    qa${SPACE}automate
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_067_[district] district has special char
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    [qa_automate]
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_068_[district] delete district
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Remove String    ${request_body}    "district" : "VAR_DISTRICT",
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_069_[city] city TH language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    บางนา
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_070_[city] city EN language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_071_[city] city CN language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    咖啡店
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_072_[city] city KN language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    안녕
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_073_[city] city JP language
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    こんにちは
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_074_[city] city over length (max 255 chars)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    Bangna_12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_075_[city] city empty
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    ${EMPTY}
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_076_[city] city has space
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    bangna${SPACE}ka
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_200_OK}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}

SUP_API_077_[postalCode] postalCode over length (max 255 chars)
    #####    Set variable    #####
    ${random}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${supplier_name}=    Set Variable    API_${random}
    #####    Set request body    #####
    ${request_body}    Get File    ${R_TEMPLATE_SUPPLIER}
    ${request_body}    Replace String    ${request_body}    VAR_ACTION    create
    ${request_body}    Replace String    ${request_body}    VAR_WEBSITE    http://www.supplier.com
    ${request_body}    Replace String    ${request_body}    VAR_EMAIL    automate@acommerce.asia
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESSEE    Addressee
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS1    Address1
    ${request_body}    Replace String    ${request_body}    VAR_ADDRESS2    Address2
    ${request_body}    Replace String    ${request_body}    VAR_DISTRICT    District
    ${request_body}    Replace String    ${request_body}    VAR_SUB_DISTRICT    Sub District
    ${request_body}    Replace String    ${request_body}    VAR_CITY    bangna
    ${request_body}    Replace String    ${request_body}    VAR_PROVINCE    Bangkok
    ${request_body}    Replace String    ${request_body}    VAR_POSTAL_CODE    10260_12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    ${request_body}    Replace String    ${request_body}    VAR_PHONE    123456789
    ${request_body}    Replace String    ${request_body}    VAR_COUNTRY    TH
    ${request_body}    Replace String    ${request_body}    VAR_CURRENCY    THB
    ${request_body}    Replace String    ${request_body}    VAR_DEFAULT    false
    ${request_body}    Replace String    ${request_body}    VAR_CONTACT    contactName
    ${request_body}    Replace String    ${request_body}    VAR_INITIATE    false
    ${R_PATH_SUPPLIER}    Replace String    ${R_PATH_SUPPLIER}    <CONFIG_PARTNER_ID>    ${R_PARTNER_ID_NS_6}
    ${path}=    Set Variable    ${R_PATH_SUPPLIER}/${supplier_name}/
    Create_supplier    ${request_body}    ${R_EXPECTED_STATUS_400_BAD}    ${R_ENDPOINT_ITEM}    ${path}    ${R_PARTNER_ID_NS_6}    ${R_X_ROLES_NS_6}
    ...    ${R_HTTP_PUT}
