*** Settings ***
Resource   ../test_suite/resource/group_vars/${env}/global_resource.robot
Resource   ../test_suite/resource/resource_portal.robot

*** Test Cases ***
T1 
    Login to admin
    Go To   https://admindev.acommercedev.com/beehive/frontend/ui-inventory/detail/3880/WIKT8SGLV0GGGII5RASJUFZK1
    Element Should Contain   xpath=//*[@id="lblUpc"]  UPC_20180329_011057

