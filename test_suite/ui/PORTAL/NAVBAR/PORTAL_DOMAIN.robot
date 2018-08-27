*** Settings ***
Documentation     To verify the navigator bar is controlled by login user role
...               Domain: ${domain}
Test Setup        Set Selenium Speed    .3 seconds
Test Teardown     Logout Portal and close browser    # Logout Portal and close browser
Resource          Resource/global_resource.robot
Resource          Resource/NAVBAR_PARTNER.robot

*** Variables ***
${domain}         ${PORTAL_DEV}

*** Test Cases ***
TC001 ADM
    #    role
    login_IDP    ${ADM}
    # Click side bar
    # Page Should Contain Element    ${Dashboard}
    # Page Should Contain Element    ${Dashboard_Overview}
    # Page Should Contain Element    ${Dashboard_Delivery and Outbound}
    # Page Should Not Contain Element    ${Sherlock}
    # Page Should Not Contain Element    ${Sherlock_Public}
    # Page Should Not Contain Element    ${Sherlock_Marketing}
    # Page Should Not Contain Element    ${Sherlock_Finance}
    # Page Should Not Contain Element    ${Sherlock_Operations}
    # Page Should Not Contain Element    ${Sherlock_Delivery}
    # Page Should Not Contain Element    ${Sherlock_BrandCommerce}
    # Page Should Not Contain Element    ${Sherlock_HR}
    # Page Should Not Contain Element    ${Sherlock_Business Development}
    # Page Should Contain Element    ${ProductCatalogue}
    # Page Should Contain Element    ${ProductCatalogue_ManageProduct}
    # Page Should Contain Element    ${ProductCatalogue_ImportHistory}
    # Page Should Contain Element    ${ProductCatalogue_ExportHistory}
    # Page Should Contain Element    ${ItemsAndInventory}
    # Page Should Contain Element    ${ItemsAndInventory_ManageItem}
    # Page Should Contain Element     ${ItemsAndInventory_DemandForecast}
    # Page Should Contain Element    ${ItemsAndInventory_Replenishment}
    # Page Should Contain Element    ${ItemsAndInventory_ImportHistory}
    # Page Should Contain Element    ${PurchaseOrders}
    # Page Should Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    # Page Should Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    # Page Should Contain Element    ${PurchaseOrders_BatchItemReceipts}
    # Page Should Contain Element    ${PurchaseOrders_ImportHistory}
    # Page Should Contain Element    ${Supplier}
    # Page Should Contain Element    ${Supplier_ManageSupplier}
    # Page Should Contain Element    ${Supplier_ImportHistory}
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}
    # Page Should Contain Element    ${ManageInventoryItems}
    # Page Should Contain Element    ${ManageInventoryItems_ListofItems}
    # Page Should Contain Element    ${ManageSalesOrders}
    # Page Should Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    # Page Should Contain Element    ${ManageSalesOrders_ListofBackorders}
    # Page Should Contain Element    ${ManageSalesOrders_PickingandQC}
    # Page Should Contain Element    ${ManageSalesOrders_Packing}
    # Page Should Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    # Page Should Contain Element    ${ManageFulfillments}
    # Page Should Contain Element    ${ManageFulfillments_ListofFulfillments}
    # Page Should Contain Element    ${Import/Export}
    # Page Should Contain Element    ${Import/Export_ImportFailed}
    # Page Should Contain Element    ${Import/Export_TransactionImportHistory}
    # Page Should Contain Element    ${Report}
    # Page Should Contain Element    ${Report_PendingFulfillmentReport}
    # Page Should Contain Element    ${ManagePartners}
    # Page Should Contain Element    ${ManagePartners_ListofPartners}
    # Page Should Contain Element    ${SystemConfigurations}
    # Page Should Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    # Page Should Contain Element    ${SystemConfigurations_SetupShippingTypes}
    # Page Should Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    # Page Should Contain Element    ${NetsuiteRe-Synchronization}

TC002 SHP
    #    role
    login_IDP    ${SHP}
    # Click side bar
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC003 VR
    #    role
    login_IDP    ${VR}
    # Click side bar
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC004 SUP
    #    role
    login_IDP    ${SUP}
    # Click side bar
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC005 CS
    #    role
    login_IDP    ${CS}
    # Click side bar
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC006 INB
    #    role
    login_IDP    ${INB}
    # Click side bar
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC007 OUTB
    #    role
    login_IDP    ${OUTB}
    # Click side bar
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC008 RVR
    #    role
    login_IDP    ${RVR}
    # Click side bar
    Page Should Not Contain Element    ${Delivery}
    Page Should Not Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC009 ROUT
    #    role
    login_IDP    ${ROUT}
    # Click side bar
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC010 SALE
    #    role
    login_IDP    ${SALE}
    # Click side bar
    Page Should Not Contain Element    ${Delivery}
    Page Should Not Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC011 MKT
    #    role
    login_IDP    ${MKT}
    # Click side bar
    Page Should Not Contain Element    ${Delivery}
    Page Should Not Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC012 FNZ
    #    role
    login_IDP    ${FNZ}
    # Click side bar
    Page Should Not Contain Element    ${Delivery}
    Page Should Not Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC013 HR
    #    role
    login_IDP    ${HR}
    # Click side bar
    Page Should Not Contain Element    ${Delivery}
    Page Should Not Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC014 SMGR
    #    role
    login_IDP    ${SMGR}
    # Click side bar
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC015 PURC
    #    role
    login_IDP    ${PURC}
    # Click side bar
    Page Should Not Contain Element    ${Delivery}
    Page Should Not Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC016 PADM
    #    role
    login_IDP    ${PADM}
    # Click side bar
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC017 POPS
    #    role
    login_IDP    ${POPS}
    # Click side bar
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC018 PSHP
    #    role
    login_IDP    ${PSHP}
    # Click side bar
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC019 PDC
    #    role
    login_IDP    ${PDC}
    # Click side bar
    Page Should Not Contain Element    ${Delivery}
    Page Should Not Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC020 CTVR
    #    role
    login_IDP    ${CTVR}
    # Click side bar
    Page Should Not Contain Element    ${Delivery}
    Page Should Not Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

TC021 MERC
    #    role
    login_IDP    ${MERC}
    # Click side bar
    Page Should Not Contain Element    ${Delivery}
    Page Should Not Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}

ADM/Delivery
    login_IDP    ${ADM}
    comment    ${isShipping Order}   ${isOver-Pickup Orders}   ${isManage Pick up}   ${isManage Delivery}    ${isManage Return}    ${isManage Provider}    ${isManage Pre-defined Package}   ${isImport History}
    Validate Delivery menu    true    false    false    false    false    false    false    false
