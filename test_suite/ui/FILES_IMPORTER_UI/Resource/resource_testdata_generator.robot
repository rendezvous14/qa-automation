*** Settings ***
Library           OperatingSystem
Library
Resource          global_resource.robot

*** Variables ***
####### Partner Name for testing
${partner_fulfillment}    demo automate 1
${partner_dropship}       demo automate 2
${partner_hybrid}         demo automate 3

####### Test data
${file_importer_ui_home}   ${EXECDIR}/automation/PLATFORM/FILES_IMPORTER_UI/Testdata/
${test_item_001}           Item_demo_automate_1_001.csv
${test_po_001}             PO_demo_automate_1_001.csv

*** Keywords ***
Generate the Item

Generate the Purchase Order

Generate the Sales Order

Generate the Shipping Order
