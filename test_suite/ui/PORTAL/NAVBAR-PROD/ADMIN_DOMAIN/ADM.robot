*** Settings ***
Documentation     To verify the navigator bar is controlled by login user role
...               Domain: ${domain}
Test Teardown     Logout Portal and close browser    # Logout Portal and close browser
Resource          ../Resource/global_resource.robot
Resource          ../Resource/NAVBAR_ADMIN.robot

*** Variables ***
${domain}         ${ADMIN_PROD}
${login_role}     ${ADM}

*** Test Cases ***
ADM role
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
    Page Should Not Contain Element    ${Sherlock_Marketing}
    Page Should Not Contain Element    ${Sherlock_Finance}
    Page Should Not Contain Element    ${Sherlock_Operations}
    Page Should Not Contain Element    ${Sherlock_Delivery}
    Page Should Not Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Not Contain Element    ${Sherlock_Business Development}
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
    # Page Should Not Contain Element    ${Import}
    # Page Should Not Contain Element    ${Import_AllImportHistory}
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
