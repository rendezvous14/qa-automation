*** Settings ***
Test Setup        Set Selenium Speed	 .3 seconds
Test Teardown     Logout Portal and close browser
Library           Selenium2Library
Resource          Resource/global_resource.robot
Resource          Resource/NAVBAR_ADMIN.robot

*** Variables ***
${domain}         ${ADMIN_DEV}

*** Test Cases ***
ADM/Dashboard
    login_IDP    ${ADM}
    Comment    ${isOverview}    ${isSystem monitoring}
    Validate Dashboard menu    true    true

ADM/Sherlock
    login_IDP    ${ADM}
    comment    ${isPublic}    ${isMarketing}    ${isFinance}    ${isOperations}    # ${isDelivery}    ${isBrand Commerce}   ${isHR}    ${isBusiness Development}
    Validate Sherlock menu    true    true    false    true    true    true
    ...    false    true

ADM/Product Catalog
    login_IDP    ${ADM}
    comment    ${isManage Product}   ${isImport History}    ${isExport History}
    Validate Product Catalog menu    true     true    true

ADM/Items & Inventory
    login_IDP    ${ADM}
    comment    ${isManage Item}    ${isDemand Forecast}    ${isReplenishment}   ${isImport History}
    Validate Items & Inventory menu    true    true   true   true

ADM/Purchase Orders
    login_IDP    ${ADM}
    comment    ${isManage Purchase Orders}    ${isManage Goods Receipt Notes}    ${isBatch Item Receipts}    ${isImport History}
    Validate Purchase Orders menu    true    true    true    true

ADM/Supplier
    login_IDP    ${ADM}
    comment    ${isManage Supplier}    ${isImport History}
    Validate Supplier menu    true    true

ADM/Smartship
    login_IDP    ${ADM}
    comment    ${isShipping Order}    ${isManage Pick up}    ${isManage Delivery}    ${isManage Return}    ${isManage Provider}    ${isManage Pre-defined Package}
    Validate Smartship menu    true    true    true    true    true    true

ADM/Manage Inventory Items
    login_IDP    ${ADM}
    comment    ${isList of Items}
    Validate Manage Inventory Items    true

ADM/Manage Sales Orders
    login_IDP    ${ADM}
    comment    ${isList of Sales Orders}    ${isList of Backorders}    ${isPicking and QC}    ${isPacking}    ${isPrint Fulfillment Doc}
    Validate Manage Sales Orders    true    true    true    true    true

ADM/Manage Fulfillments
    login_IDP    ${ADM}
    comment    ${isList of Fulfillments}
    Validate Manage Fulfillments    true

ADM/Manage Pick Up and Return
    login_IDP    ${ADM}
    comment    ${isList of Dropship Pickup}    ${isList of Dropship Return}    ${isScan and Assign Return}    ${isPrint Dropship Doc}
    Validate Manage Pick Up and Return    true    true    true    true

ADM/Dispatch and Shipping
    login_IDP    ${ADM}
    comment    ${isList of Shipments}    ${isReset Shipment}    ${isRedeliver Shipment}    ${isList of Manifest}    ${isVolumemetric}    ${isCOD Log Report}
    Validate Dispatch and Shipping    true    true    true    true    true    true

ADM/Manage Distributions
    login_IDP    ${ADM}
    comment    ${isRouting Sheet}    ${isManifest Report}    ${isSetup Driver}    ${isSetup Zone}    ${isSetup Failed Reason}
    Validate Manage Distributions    true    true    true    true    true

ADM/Import/Export menu
    login_IDP    ${ADM}
    comment    ${isImport Failed}    ${isDrop Files (Delivered Tracking & Failed Deliver)}    ${isTransaction Import History (History)}    ${isOps. Import History (Delivered Tracking & Failed Deliver)}    ${isShipment Export History}
    Validate Import/Export menu    true    true    true    true    true

ADM/Report
    login_IDP    ${ADM}
    comment    ${isAttempt Report}    ${isConsolidated Dropship Report (Dropship Report)}    ${isPending Fulfillment Report}    ${isCOD Payment Report}
    Validate Report menu    true    true    true    true

ADM/ManagePartners
    login_IDP    ${ADM}
    comment    ${isList of Partners}
    Validate Manage Partners menu    true

ADM/SystemConfiguration
    login_IDP    ${ADM}
    comment    ${isSetup Provider}    ${isSetup Payment Types}    ${isSetup Shipping Types}    ${isSetup Netsuite Library}    ${isNetsuite Re-Synchronization}
    Validate System Configuration menu    true    true    true    true    true
