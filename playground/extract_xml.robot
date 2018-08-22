*** Settings ***
Library    XML
Library    OperatingSystem

*** Variables ***
${template}    ./test_data_xml.xml

*** Test Cases ***
TEST1
    ${foo_xml}=  Get File  ${template}


    ${root}=  Parse XML   ${foo_xml}

    ${itemKey}=    Set Variable   6CD1I97Z8EG9YVO5NI27MZ1R7
    
    @{ShipmentDetail}    Get Elements    ${root}    body/Shipments/Shipment/Details/ShipmentDetail
    :FOR    ${adjacency}    IN    @{ShipmentDetail}
    \    ${results}=   Set Variable    NOT FOUND
    \    ${getErpOrder}=    Get Element Text    ${adjacency}    ErpOrder
    \    ${results}=   Set Variable If   '${getErpOrder}'=='${itemKey}'   ${getErpOrder}   ${results}
    \    Exit For Loop If    '${getErpOrder}'=='${itemKey}'
    Should Not Be Equal   ${results}   NOT FOUND    Cannot found this item


    ${itemKey}=    Set Variable   I9IS7QU5ODSOI0SKXA910DXV6
    
    @{ShipmentDetail}    Get Elements    ${root}    body/Shipments/Shipment/Details/ShipmentDetail
    :FOR    ${adjacency}    IN    @{ShipmentDetail}
    \    ${results}=   Set Variable    NOT FOUND
    \    ${getErpOrder}=    Get Element Text    ${adjacency}    ErpOrder
    \    ${results}=   Set Variable If   '${getErpOrder}'=='${itemKey}'   ${getErpOrder}   ${results}
    \    Exit For Loop If    '${getErpOrder}'=='${itemKey}'
    Should Not Be Equal   ${results}   NOT FOUND    Cannot found this item