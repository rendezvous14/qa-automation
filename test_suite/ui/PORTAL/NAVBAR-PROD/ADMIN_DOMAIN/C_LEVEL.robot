*** Settings ***
Documentation     To verify the navigator bar is controlled by login user role
...               Domain: ${domain}
Test Setup        Set Selenium Speed    .5 seconds
Test Teardown     Logout Portal and close browser    # Logout Portal and close browser
Resource          ../Resource/global_resource.robot
Resource          ../Resource/NAVBAR_ADMIN.robot

*** Variables ***
${domain}         ${ADMIN_PROD}
${login_role}     ${C_LEVEL}

*** Test Cases ***
C_LEVEL role
    [Tags]    Internal role
    Login IDP    ${login_role}
    Click side bar
    #Dashboard
    Page Should Contain Element    ${Dashboard}
    Page Should Contain Element    ${Dashboard_Overview}
    Page Should Contain Element    ${Dashboard_System monitoring}
    #Sherlock
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Contain Element    ${Sherlock_Marketing}
    Page Should Contain Element    ${Sherlock_Finance}
    Page Should Contain Element    ${Sherlock_Operations}
    Page Should Contain Element    ${Sherlock_Delivery}
    Page Should Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Contain Element    ${Sherlock_Business Development}
    #Product Catalogue
    Page Should Contain Element    ${ProductCatalogue}
    Page Should Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Contain Element    ${ProductCatalogue_ExportHistory}
    #Items & Inventory
    Page Should Contain Element    ${ItemsAndInventory}
    Page Should Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Contain Element    ${ItemsAndInventory_ImportHistory}
    ##Channel Management Not yet
    # Page Should Contain Element    ${ChannelManagement}
    # Page Should Contain Element    ${ChannelManagement_ChannelManagement}}
    #Purchase Orders
    Page Should Contain Element    ${PurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    # Page Should Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Contain Element    ${PurchaseOrders_ImportHistory}
    #Supplier
    Page Should Contain Element    ${Supplier}
    Page Should Contain Element    ${Supplier_ManageSupplier}
    Page Should Contain Element    ${Supplier_ImportHistory}
    #Delivery
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Contain Element    ${Delivery_OverPickupOrder}
    Page Should Contain Element    ${Delivery_ManagePickup}
    Page Should Contain Element    ${Delivery_ManageDelivery}
    Page Should Contain Element    ${Delivery_ManageReturn}
    Page Should Contain Element    ${Delivery_ManageProvider}
    Page Should Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Contain Element    ${Delivery_ImportHistory}
    #Import
    # Page Should Contain Element    ${Import}
    # Page Should Contain Element    ${Import_AllImportHistory}
    #Manage Inventory Items
    Page Should Contain Element    ${ManageInventoryItems}
    Page Should Contain Element    ${ManageInventoryItems_ListofItems}
    #Manage Purchase Orders
    Page Should Contain Element    ${ManagePurchaseOrders}
    Page Should Contain Element    ${ManagePurchaseOrders_ListOfPurchaseOrders}
    #Manage Item Receipt
    Page Should Contain Element    ${ManageItemReceipts}
    Page Should Contain Element    ${ManageItemReceipts_BatchProcessItemReceipts}
    # #Manage Sales Orders
    Page Should Contain Element    ${ManageSalesOrders}
    Page Should Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Contain Element    ${ManageSalesOrders_Packing}
    Page Should Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    #Manage Fulfillments
    Page Should Contain Element    ${ManageFulfillments}
    Page Should Contain Element    ${ManageFulfillments_ListofFulfillments}
    #Import/Export
    Page Should Contain Element    ${Import/Export}
    Page Should Contain Element    ${Import/Export_ImportFailed}
    Page Should Contain Element    ${Import/Export_TransactionImportHistory}
    #Report
    Page Should Contain Element    ${Report}
    Page Should Contain Element    ${Report_PendingFulfillmentReport}
    #Manage Partners
    Page Should Contain Element    ${ManagePartners}
    Page Should Contain Element    ${ManagePartners_ListofPartners}
    #System Configurations
    Page Should Contain Element    ${SystemConfigurations}
    Page Should Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Contain Element    ${NetsuiteRe-Synchronization}

Accessible check for Dashboard
    Login IDP    ${login_role}
    comment    ${isOverview}    ${isSystem monitoring}
    Validate Dashboard menu    true    true

Accessible check for Sherlock
    Login IDP    ${login_role}
    comment    ${isPublic}    ${isMarketing}    ${isFinance}    ${isOperations}    ${isDelivery}    ${isBrand Commerce}   ${isHR}   ${isBusiness Development}
    Validate Sherlock menu    true    true    true    true    true    true    false    true

Accessible check for Product Catalog
    Login IDP    ${login_role}
    comment    ${isManage Product}    ${isImport History}    ${isExport History}
    Validate Product Catalog menu    true    true    true

Accessible check for Items & Inventory
    Login IDP    ${login_role}
    comment    ${isManage Item}    ${isDemand Forecast}    ${isReplenishment}  ${isChannelAllocation}  ${isImport History}
    Validate Items & Inventory menu    true    true    true   true    true

Accessible check for Purchase Orders
    Login IDP    ${login_role}
    # comment    ${isManage Purchase Orders}    ${isManage Goods Receipt Notes}    ${isBatch Item Receipts}  ${isImport History}
    comment    ${isManage Purchase Orders}    ${isManage Goods Receipt Notes}   ${isImport History}
    Validate Purchase Orders menu    true    true    true

Accessible check for Supplier
    Login IDP    ${login_role}
    comment    ${isManage Supplier}    ${isImport History}
    Validate Supplier menu    true    true

Accessible check for Delivery
    Login IDP    ${login_role}
    comment    ${isShipping Order}   ${isOver-Pickup Orders}   ${isManage Pick up}   ${isManage Delivery}    ${isManage Return}    ${isManage Provider}    ${isManage Pre-defined Package}   ${isImport History}
    Validate Delivery menu    true    true    true    true    true    true    true    true

# Accessible check for Import
#     Login IDP    ${login_role}
#     comment    ${isImport History}
#     Validate Import menu    true

Accessible check for Manage Inventory Items
    Login IDP    ${login_role}
    comment    ${isList of Items}
    Validate Manage Inventory Items menu   true

Accessible check for Manage Purchase Orders
    Login IDP    ${login_role}
    comment    ${isList of Purchase Orders}
    Validate Manage Purchase Orders menu    true

Accessible check for Manage Item Receipt
    Login IDP    ${login_role}
    comment    ${isBatch Process Item Receipts}
    Validate Manage Item Receipt menu    true

Accessible check for Manage Sales Orders
    Login IDP    ${login_role}
    comment    ${isList of Sales Orders}    ${isList of Backorders}    ${isPicking and QC}    ${isPacking}    ${isPrint Fulfillment Doc}
    Validate Manage Sales Orders    true    true    true    true    true

Accessible check for Manage Fulfillments
    Login IDP    ${login_role}
    comment    ${isList of Fulfillments}
    Validate Manage Fulfillments    true

Accessible check for Import/Export menu
    Login IDP    ${login_role}
    comment    ${isImport Failed}    ${isTransaction Import History (History)}
    Validate Import/Export menu    true    true

Accessible check for Report
    Login IDP    ${login_role}
    comment    ${isPending Fulfillment Report}
    Validate Report menu    true

Accessible check for ManagePartners
    Login IDP    ${login_role}
    comment    ${isList of Partners}
    Validate Manage Partners menu    true

Accessible check for SystemConfiguration
    Login IDP    ${login_role}
    comment    ${isSetup Payment Types}    ${isSetup Shipping Types}    ${isSetup Netsuite Library}    ${isNetsuite Re-Synchronization}
    Validate System Configuration menu    true    true    true    true
