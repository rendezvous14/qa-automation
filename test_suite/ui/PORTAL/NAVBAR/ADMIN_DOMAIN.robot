*** Settings ***
Documentation     To verify the navigator bar is controlled by login user role
...               Domain: ${domain}
Test Setup        Set Selenium Speed    .3 seconds
Test Teardown     Logout Portal and close browser    # Logout Portal and close browser
Resource          Resource/global_resource.robot
Resource          Resource/NAVBAR_ADMIN.robot

*** Variables ***
${domain}         ${ADMIN_DEV}

*** Test Cases ***
TC001 ADM
    #   role
    login_IDP    ${ADM}
    Click side bar
    Page Should Contain Element    ${Dashboard}
    Page Should Contain Element    ${Dashboard_Overview}
    Page Should Contain Element    ${Dashboard_System monitoring}
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Contain Element    ${Sherlock_Marketing}
    Page Should Not Contain Element    ${Sherlock_Finance}
    Page Should Contain Element    ${Sherlock_Operations}
    Page Should Contain Element    ${Sherlock_Delivery}
    Page Should Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Contain Element    ${Sherlock_Business Development}
    Page Should Contain Element    ${ProductCatalogue}
    Page Should Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Contain Element    ${ProductCatalogue_ExportHistory}
    Page Should Contain Element    ${ItemsAndInventory}
    Page Should Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Contain Element    ${ItemsAndInventory_ImportHistory}
    Page Should Contain Element    ${PurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    Page Should Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Contain Element    ${PurchaseOrders_ImportHistory}
    Page Should Contain Element    ${Supplier}
    Page Should Contain Element    ${Supplier_ManageSupplier}
    Page Should Contain Element    ${Supplier_ImportHistory}
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Contain Element    ${Delivery_OverPickupOrder}
    Page Should Contain Element    ${Delivery_ManagePickup}
    Page Should Contain Element    ${Delivery_ManageDelivery}
    Page Should Contain Element    ${Delivery_ManageReturn}
    Page Should Contain Element    ${Delivery_ManageProvider}
    Page Should Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Contain Element    ${Delivery_ImportHistory}
    Page Should Contain Element    ${ManageInventoryItems}
    Page Should Contain Element    ${ManageInventoryItems_ListofItems}
    Page Should Contain Element    ${ManageSalesOrders}
    Page Should Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Contain Element    ${ManageSalesOrders_Packing}
    Page Should Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    Page Should Contain Element    ${ManageFulfillments}
    Page Should Contain Element    ${ManageFulfillments_ListofFulfillments}
    Page Should Contain Element    ${Import/Export}
    Page Should Contain Element    ${Import/Export_ImportFailed}
    Page Should Contain Element    ${Import/Export_TransactionImportHistory}
    Page Should Contain Element    ${Report}
    Page Should Contain Element    ${Report_PendingFulfillmentReport}
    Page Should Contain Element    ${ManagePartners}
    Page Should Contain Element    ${ManagePartners_ListofPartners}
    Page Should Contain Element    ${SystemConfigurations}
    Page Should Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Contain Element    ${NetsuiteRe-Synchronization}

TC002 SHP
    #    role
    login_IDP    ${SHP}
    Click side bar
    Page Should Contain Element    ${Dashboard}
    Page Should Contain Element    ${Dashboard_Overview}
    Page Should Not Contain Element    ${Dashboard_System monitoring}
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Not Contain Element    ${Sherlock_Marketing}
    Page Should Not Contain Element    ${Sherlock_Finance}
    Page Should Contain Element    ${Sherlock_Operations}
    Page Should Contain Element    ${Sherlock_Delivery}
    Page Should Not Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Not Contain Element    ${Sherlock_Business Development}
    Page Should Not Contain Element    ${ProductCatalogue}
    Page Should Not Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Not Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Not Contain Element    ${ProductCatalogue_ExportHistory}
    Page Should Contain Element    ${ItemsAndInventory}
    Page Should Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Not Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Not Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Not Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Contain Element    ${ItemsAndInventory_ImportHistory}
    Page Should Contain Element    ${PurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    Page Should Not Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Contain Element    ${PurchaseOrders_ImportHistory}
    Page Should Not Contain Element    ${Supplier}
    Page Should Not Contain Element    ${Supplier_ManageSupplier}
    Page Should Not Contain Element    ${Supplier_ImportHistory}
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}
    Page Should Contain Element    ${ManageInventoryItems}
    Page Should Contain Element    ${ManageInventoryItems_ListofItems}
    Page Should Contain Element    ${ManageSalesOrders}
    Page Should Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Not Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Not Contain Element    ${ManageSalesOrders_Packing}
    Page Should Not Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    Page Should Not Contain Element    ${ManageFulfillments}
    Page Should Not Contain Element    ${ManageFulfillments_ListofFulfillments}
    Page Should Not Contain Element    ${Import/Export}
    Page Should Not Contain Element    ${Import/Export_ImportFailed}
    Page Should Not Contain Element    ${Import/Export_TransactionImportHistory}
    Page Should Contain Element    ${Report}
    Page Should Contain Element    ${Report_PendingFulfillmentReport}
    Page Should Not Contain Element    ${ManagePartners}
    Page Should Not Contain Element    ${ManagePartners_ListofPartners}
    Page Should Not Contain Element    ${SystemConfigurations}
    Page Should Not Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Not Contain Element    ${NetsuiteRe-Synchronization}

TC003 VR
    #    role
    login_IDP    ${VR}
    Click side bar
    Page Should Contain Element    ${Dashboard}
    Page Should Contain Element    ${Dashboard_Overview}
    Page Should Not Contain Element    ${Dashboard_System monitoring}
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Not Contain Element    ${Sherlock_Marketing}
    Page Should Not Contain Element    ${Sherlock_Finance}
    Page Should Not Contain Element    ${Sherlock_Operations}
    Page Should Not Contain Element    ${Sherlock_Delivery}
    Page Should Not Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Not Contain Element    ${Sherlock_Business Development}
    Page Should Not Contain Element    ${ProductCatalogue}
    Page Should Not Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Not Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Not Contain Element    ${ProductCatalogue_ExportHistory}
    Page Should Contain Element    ${ItemsAndInventory}
    Page Should Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Not Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Not Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Not Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Not Contain Element    ${ItemsAndInventory_ImportHistory}
    Page Should Contain Element    ${PurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    Page Should Not Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Contain Element    ${PurchaseOrders_ImportHistory}
    Page Should Contain Element    ${Supplier}
    Page Should Contain Element    ${Supplier_ManageSupplier}
    Page Should Not Contain Element    ${Supplier_ImportHistory}
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Contain Element    ${Delivery_ManagePickup}
    Page Should Contain Element    ${Delivery_ManageDelivery}
    Page Should Contain Element    ${Delivery_ManageReturn}
    Page Should NOT Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}
    Page Should Contain Element    ${ManageInventoryItems}
    Page Should Contain Element    ${ManageInventoryItems_ListofItems}
    Page Should Contain Element    ${ManageSalesOrders}
    Page Should Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Not Contain Element    ${ManageSalesOrders_Packing}
    Page Should Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    Page Should Not Contain Element    ${ManageFulfillments}
    Page Should Not Contain Element    ${ManageFulfillments_ListofFulfillments}
    Page Should Not Contain Element    ${Import/Export}
    Page Should Not Contain Element    ${Import/Export_ImportFailed}
    Page Should Not Contain Element    ${Import/Export_TransactionImportHistory}
    Page Should Not Contain Element    ${Report}
    Page Should Not Contain Element    ${Report_PendingFulfillmentReport}
    Page Should Contain Element    ${ManagePartners}
    Page Should Contain Element    ${ManagePartners_ListofPartners}
    Page Should Contain Element    ${SystemConfigurations}
    Page Should Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Not Contain Element    ${NetsuiteRe-Synchronization}

TC004 SUP
    #    role
    login_IDP    ${SUP}
    Click side bar
    Page Should Contain Element    ${Dashboard}
    Page Should Contain Element    ${Dashboard_Overview}
    Page Should Contain Element    ${Dashboard_System monitoring}
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Contain Element    ${Sherlock_Marketing}
    Page Should Not Contain Element    ${Sherlock_Finance}
    Page Should Contain Element    ${Sherlock_Operations}
    Page Should Contain Element    ${Sherlock_Delivery}
    Page Should Not Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Contain Element    ${Sherlock_Business Development}
    Page Should Not Contain Element    ${ProductCatalogue}
    Page Should Not Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Not Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Not Contain Element    ${ProductCatalogue_ExportHistory}
    Page Should Contain Element    ${ItemsAndInventory}
    Page Should Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Not Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Not Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Not Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Contain Element    ${ItemsAndInventory_ImportHistory}
    Page Should Contain Element    ${PurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    Page Should Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Contain Element    ${PurchaseOrders_ImportHistory}
    Page Should Contain Element    ${Supplier}
    Page Should Contain Element    ${Supplier_ManageSupplier}
    Page Should Contain Element    ${Supplier_ImportHistory}
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Contain Element    ${Delivery_OverPickupOrder}
    Page Should Contain Element    ${Delivery_ManagePickup}
    Page Should Contain Element    ${Delivery_ManageDelivery}
    Page Should Contain Element    ${Delivery_ManageReturn}
    Page Should Contain Element    ${Delivery_ManageProvider}
    Page Should Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Contain Element    ${Delivery_ImportHistory}
    Page Should Contain Element    ${ManageInventoryItems}
    Page Should Contain Element    ${ManageInventoryItems_ListofItems}
    Page Should Contain Element    ${ManageSalesOrders}
    Page Should Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Not Contain Element    ${ManageSalesOrders_Packing}
    Page Should Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    Page Should Not Contain Element    ${ManageFulfillments}
    Page Should Not Contain Element    ${ManageFulfillments_ListofFulfillments}
    Page Should Contain Element    ${Import/Export}
    Page Should Not Contain Element    ${Import/Export_ImportFailed}
    Page Should Contain Element    ${Import/Export_TransactionImportHistory}
    Page Should Contain Element    ${Report}
    Page Should Contain Element    ${Report_PendingFulfillmentReport}
    Page Should Contain Element    ${ManagePartners}
    Page Should Contain Element    ${ManagePartners_ListofPartners}
    Page Should Contain Element    ${SystemConfigurations}
    Page Should Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Not Contain Element    ${NetsuiteRe-Synchronization}

TC005 CS
    #    role
    login_IDP    ${CS}
    Click side bar
    Page Should Contain Element    ${Dashboard}
    Page Should Contain Element    ${Dashboard_Overview}
    Page Should Contain Element    ${Dashboard_System monitoring}
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Not Contain Element    ${Sherlock_Marketing}
    Page Should Not Contain Element    ${Sherlock_Finance}
    Page Should Not Contain Element    ${Sherlock_Operations}
    Page Should Not Contain Element    ${Sherlock_Delivery}
    Page Should Not Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Not Contain Element    ${Sherlock_Business Development}
    Page Should Not Contain Element    ${ProductCatalogue}
    Page Should Not Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Not Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Not Contain Element    ${ProductCatalogue_ExportHistory}
    Page Should Contain Element    ${ItemsAndInventory}
    Page Should Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Not Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Not Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Not Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Contain Element    ${ItemsAndInventory_ImportHistory}
    Page Should Not Contain Element    ${PurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    Page Should Not Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Not Contain Element    ${PurchaseOrders_ImportHistory}
    Page Should Contain Element    ${Supplier}
    Page Should Contain Element    ${Supplier_ManageSupplier}
    Page Should Not Contain Element    ${Supplier_ImportHistory}
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Contain Element    ${Delivery_OverPickupOrder}
    Page Should Contain Element    ${Delivery_ManagePickup}
    Page Should Contain Element    ${Delivery_ManageDelivery}
    Page Should Contain Element    ${Delivery_ManageReturn}
    Page Should Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Contain Element    ${Delivery_ImportHistory}
    Page Should Contain Element    ${ManageInventoryItems}
    Page Should Contain Element    ${ManageInventoryItems_ListofItems}
    Page Should Contain Element    ${ManageSalesOrders}
    Page Should Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Not Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Not Contain Element    ${ManageSalesOrders_Packing}
    Page Should Not Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    Page Should Not Contain Element    ${ManageFulfillments}
    Page Should Not Contain Element    ${ManageFulfillments_ListofFulfillments}
    Page Should Contain Element    ${Import/Export}
    Page Should Not Contain Element    ${Import/Export_ImportFailed}
    Page Should Contain Element    ${Import/Export_TransactionImportHistory}
    Page Should Not Contain Element    ${Report}
    Page Should Not Contain Element    ${Report_PendingFulfillmentReport}
    Page Should Contain Element    ${ManagePartners}
    Page Should Contain Element    ${ManagePartners_ListofPartners}
    Page Should Not Contain Element    ${SystemConfigurations}
    Page Should Not Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Not Contain Element    ${NetsuiteRe-Synchronization}

TC006 INB
    #    role
    login_IDP    ${INB}
    Click side bar
    Page Should Contain Element    ${Dashboard}
    Page Should Contain Element    ${Dashboard_Overview}
    Page Should Contain Element    ${Dashboard_System monitoring}
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Not Contain Element    ${Sherlock_Marketing}
    Page Should Not Contain Element    ${Sherlock_Finance}
    Page Should Contain Element    ${Sherlock_Operations}
    Page Should Contain Element    ${Sherlock_Delivery}
    Page Should Not Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Not Contain Element    ${Sherlock_Business Development}
    Page Should Not Contain Element    ${ProductCatalogue}
    Page Should Not Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Not Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Not Contain Element    ${ProductCatalogue_ExportHistory}
    Page Should Contain Element    ${ItemsAndInventory}
    Page Should Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Not Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Not Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Not Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Contain Element    ${ItemsAndInventory_ImportHistory}
    Page Should Contain Element    ${PurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    Page Should Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Contain Element    ${PurchaseOrders_ImportHistory}
    Page Should Contain Element    ${Supplier}
    Page Should Contain Element    ${Supplier_ManageSupplier}
    Page Should Not Contain Element    ${Supplier_ImportHistory}
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}
    Page Should Contain Element    ${ManageInventoryItems}
    Page Should Contain Element    ${ManageInventoryItems_ListofItems}
    Page Should Contain Element    ${ManageSalesOrders}
    Page Should Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Contain Element    ${ManageSalesOrders_Packing}
    Page Should Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    Page Should Not Contain Element    ${ManageFulfillments}
    Page Should Not Contain Element    ${ManageFulfillments_ListofFulfillments}
    Page Should Not Contain Element    ${Import/Export}
    Page Should Not Contain Element    ${Import/Export_ImportFailed}
    Page Should Not Contain Element    ${Import/Export_TransactionImportHistory}
    Page Should Contain Element    ${Report}
    Page Should Contain Element    ${Report_PendingFulfillmentReport}
    Page Should Not Contain Element    ${ManagePartners}
    Page Should Not Contain Element    ${ManagePartners_ListofPartners}
    Page Should Not Contain Element    ${SystemConfigurations}
    Page Should Not Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Not Contain Element    ${NetsuiteRe-Synchronization}

TC007 OUTB
    #    role
    login_IDP    ${OUTB}
    Click side bar
    Page Should Contain Element    ${Dashboard}
    Page Should Contain Element    ${Dashboard_Overview}
    Page Should Contain Element    ${Dashboard_System monitoring}
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Not Contain Element    ${Sherlock_Marketing}
    Page Should Not Contain Element    ${Sherlock_Finance}
    Page Should Contain Element    ${Sherlock_Operations}
    Page Should Contain Element    ${Sherlock_Delivery}
    Page Should Not Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Not Contain Element    ${Sherlock_Business Development}
    Page Should Not Contain Element    ${ProductCatalogue}
    Page Should Not Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Not Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Not Contain Element    ${ProductCatalogue_ExportHistory}
    Page Should Contain Element    ${ItemsAndInventory}
    Page Should Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Not Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Not Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Not Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Contain Element    ${ItemsAndInventory_ImportHistory}
    Page Should Not Contain Element    ${PurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    Page Should Not Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Not Contain Element    ${PurchaseOrders_ImportHistory}
    Page Should Not Contain Element    ${Supplier}
    Page Should Not Contain Element    ${Supplier_ManageSupplier}
    Page Should Not Contain Element    ${Supplier_ImportHistory}
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}
    Page Should Contain Element    ${ManageInventoryItems}
    Page Should Contain Element    ${ManageInventoryItems_ListofItems}
    Page Should Contain Element    ${ManageSalesOrders}
    Page Should Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Contain Element    ${ManageSalesOrders_Packing}
    Page Should Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    Page Should Not Contain Element    ${ManageFulfillments}
    Page Should Not Contain Element    ${ManageFulfillments_ListofFulfillments}
    Page Should Not Contain Element    ${Import/Export}
    Page Should Not Contain Element    ${Import/Export_ImportFailed}
    Page Should Not Contain Element    ${Import/Export_TransactionImportHistory}
    Page Should Not Contain Element    ${Report}
    Page Should Not Contain Element    ${Report_PendingFulfillmentReport}
    Page Should Not Contain Element    ${ManagePartners}
    Page Should Not Contain Element    ${ManagePartners_ListofPartners}
    Page Should Not Contain Element    ${SystemConfigurations}
    Page Should Not Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Not Contain Element    ${NetsuiteRe-Synchronization}

TC008 RVR
    #    role
    login_IDP    ${RVR}
    Click side bar
    Page Should Contain Element    ${Dashboard}
    Page Should Contain Element    ${Dashboard_Overview}
    Page Should Not Contain Element    ${Dashboard_System monitoring}
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Not Contain Element    ${Sherlock_Marketing}
    Page Should Not Contain Element    ${Sherlock_Finance}
    Page Should Not Contain Element    ${Sherlock_Operations}
    Page Should Not Contain Element    ${Sherlock_Delivery}
    Page Should Not Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Not Contain Element    ${Sherlock_Business Development}
    Page Should Not Contain Element    ${ProductCatalogue}
    Page Should Not Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Not Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Not Contain Element    ${ProductCatalogue_ExportHistory}
    Page Should Not Contain Element    ${ItemsAndInventory}
    Page Should Not Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Not Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Not Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Not Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Not Contain Element    ${ItemsAndInventory_ImportHistory}
    Page Should Not Contain Element    ${PurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    Page Should Not Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Not Contain Element    ${PurchaseOrders_ImportHistory}
    Page Should Not Contain Element    ${Supplier}
    Page Should Not Contain Element    ${Supplier_ManageSupplier}
    Page Should Not Contain Element    ${Supplier_ImportHistory}
    Page Should Not Contain Element    ${Delivery}
    Page Should Not Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}
    Page Should Not Contain Element    ${ManageInventoryItems}
    Page Should Not Contain Element    ${ManageInventoryItems_ListofItems}
    Page Should Not Contain Element    ${ManageSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Not Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Not Contain Element    ${ManageSalesOrders_Packing}
    Page Should Not Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    Page Should Not Contain Element    ${ManageFulfillments}
    Page Should Not Contain Element    ${ManageFulfillments_ListofFulfillments}
    Page Should Not Contain Element    ${Import/Export}
    Page Should Not Contain Element    ${Import/Export_ImportFailed}
    Page Should Not Contain Element    ${Import/Export_TransactionImportHistory}
    Page Should Not Contain Element    ${Report}
    Page Should Not Contain Element    ${Report_PendingFulfillmentReport}
    Page Should Not Contain Element    ${ManagePartners}
    Page Should Not Contain Element    ${ManagePartners_ListofPartners}
    Page Should Not Contain Element    ${SystemConfigurations}
    Page Should Not Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Not Contain Element    ${NetsuiteRe-Synchronization}

TC009 ROUT
    #    role
    login_IDP    ${ROUT}
    Click side bar
    Page Should Not Contain Element    ${Dashboard}
    Page Should Not Contain Element    ${Dashboard_Overview}
    Page Should Not Contain Element    ${Dashboard_System monitoring}
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Not Contain Element    ${Sherlock_Marketing}
    Page Should Not Contain Element    ${Sherlock_Finance}
    Page Should Not Contain Element    ${Sherlock_Operations}
    Page Should Not Contain Element    ${Sherlock_Delivery}
    Page Should Not Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Not Contain Element    ${Sherlock_Business Development}
    Page Should Not Contain Element    ${ProductCatalogue}
    Page Should Not Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Not Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Not Contain Element    ${ProductCatalogue_ExportHistory}
    Page Should Not Contain Element    ${ItemsAndInventory}
    Page Should Not Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Not Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Not Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Not Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Not Contain Element    ${ItemsAndInventory_ImportHistory}
    Page Should Not Contain Element    ${PurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    Page Should Not Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Not Contain Element    ${PurchaseOrders_ImportHistory}
    Page Should Not Contain Element    ${Supplier}
    Page Should Not Contain Element    ${Supplier_ManageSupplier}
    Page Should Not Contain Element    ${Supplier_ImportHistory}
    Page Should Contain Element        ${Delivery}
    Page Should Contain Element        ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}
    Page Should Not Contain Element    ${ManageInventoryItems}
    Page Should Not Contain Element    ${ManageInventoryItems_ListofItems}
    Page Should Not Contain Element    ${ManageSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Not Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Not Contain Element    ${ManageSalesOrders_Packing}
    Page Should Not Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    Page Should Not Contain Element    ${ManageFulfillments}
    Page Should Not Contain Element    ${ManageFulfillments_ListofFulfillments}
    Page Should Not Contain Element    ${Import/Export}
    Page Should Not Contain Element    ${Import/Export_ImportFailed}
    Page Should Not Contain Element    ${Import/Export_TransactionImportHistory}
    Page Should Not Contain Element    ${Report}
    Page Should Not Contain Element    ${Report_PendingFulfillmentReport}
    Page Should Not Contain Element    ${ManagePartners}
    Page Should Not Contain Element    ${ManagePartners_ListofPartners}
    Page Should Not Contain Element    ${SystemConfigurations}
    Page Should Not Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Not Contain Element    ${NetsuiteRe-Synchronization}

TC010 SALE
    #    role
    login_IDP    ${SALE}
    Click side bar
    Page Should Contain Element    ${Dashboard}
    Page Should Contain Element    ${Dashboard_Overview}
    Page Should Not Contain Element    ${Dashboard_System monitoring}
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Not Contain Element    ${Sherlock_Marketing}
    Page Should Not Contain Element    ${Sherlock_Finance}
    Page Should Not Contain Element    ${Sherlock_Operations}
    Page Should Not Contain Element    ${Sherlock_Delivery}
    Page Should Not Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Contain Element    ${Sherlock_Business Development}
    Page Should Not Contain Element    ${ProductCatalogue}
    Page Should Not Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Not Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Not Contain Element    ${ProductCatalogue_ExportHistory}
    Page Should Not Contain Element    ${ItemsAndInventory}
    Page Should Not Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Not Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Not Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Not Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Not Contain Element    ${ItemsAndInventory_ImportHistory}
    Page Should Not Contain Element    ${PurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    Page Should Not Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Not Contain Element    ${PurchaseOrders_ImportHistory}
    Page Should Not Contain Element    ${Supplier}
    Page Should Not Contain Element    ${Supplier_ManageSupplier}
    Page Should Not Contain Element    ${Supplier_ImportHistory}
    Page Should Not Contain Element    ${Delivery}
    Page Should Not Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}
    Page Should Not Contain Element    ${ManageInventoryItems}
    Page Should Not Contain Element    ${ManageInventoryItems_ListofItems}
    Page Should Not Contain Element    ${ManageSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Not Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Not Contain Element    ${ManageSalesOrders_Packing}
    Page Should Not Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    Page Should Not Contain Element    ${ManageFulfillments}
    Page Should Not Contain Element    ${ManageFulfillments_ListofFulfillments}
    Page Should Not Contain Element    ${Import/Export}
    Page Should Not Contain Element    ${Import/Export_ImportFailed}
    Page Should Not Contain Element    ${Import/Export_TransactionImportHistory}
    Page Should Not Contain Element    ${Report}
    Page Should Not Contain Element    ${Report_PendingFulfillmentReport}
    Page Should Not Contain Element    ${ManagePartners}
    Page Should Not Contain Element    ${ManagePartners_ListofPartners}
    Page Should Not Contain Element    ${SystemConfigurations}
    Page Should Not Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Not Contain Element    ${NetsuiteRe-Synchronization}

TC011 MKT
    #    role
    login_IDP    ${MKT}
    # Click side bar
    Page Should Not Contain Element    ${Dashboard}
    Page Should Not Contain Element    ${Dashboard_Overview}
    Page Should Not Contain Element    ${Dashboard_System monitoring}
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Contain Element    ${Sherlock_Marketing}
    Page Should Not Contain Element    ${Sherlock_Finance}
    Page Should Not Contain Element    ${Sherlock_Operations}
    Page Should Not Contain Element    ${Sherlock_Delivery}
    Page Should Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Contain Element    ${Sherlock_Business Development}
    Page Should Not Contain Element    ${ProductCatalogue}
    Page Should Not Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Not Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Not Contain Element    ${ProductCatalogue_ExportHistory}
    Page Should Not Contain Element    ${ItemsAndInventory}
    Page Should Not Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Not Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Not Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Not Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Not Contain Element    ${ItemsAndInventory_ImportHistory}
    Page Should Not Contain Element    ${PurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    Page Should Not Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Not Contain Element    ${PurchaseOrders_ImportHistory}
    Page Should Not Contain Element    ${Supplier}
    Page Should Not Contain Element    ${Supplier_ManageSupplier}
    Page Should Not Contain Element    ${Supplier_ImportHistory}
    Page Should Not Contain Element    ${Delivery}
    Page Should Not Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}
    Page Should Not Contain Element    ${ManageInventoryItems}
    Page Should Not Contain Element    ${ManageInventoryItems_ListofItems}
    Page Should Not Contain Element    ${ManageSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Not Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Not Contain Element    ${ManageSalesOrders_Packing}
    Page Should Not Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    Page Should Not Contain Element    ${ManageFulfillments}
    Page Should Not Contain Element    ${ManageFulfillments_ListofFulfillments}
    Page Should Not Contain Element    ${Import/Export}
    Page Should Not Contain Element    ${Import/Export_ImportFailed}
    Page Should Not Contain Element    ${Import/Export_TransactionImportHistory}
    Page Should Not Contain Element    ${Report}
    Page Should Not Contain Element    ${Report_PendingFulfillmentReport}
    Page Should Not Contain Element    ${ManagePartners}
    Page Should Not Contain Element    ${ManagePartners_ListofPartners}
    Page Should Not Contain Element    ${SystemConfigurations}
    Page Should Not Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Not Contain Element    ${NetsuiteRe-Synchronization}

TC012 FNZ
    #    role
    login_IDP    ${FNZ}
    # Click side bar
    Page Should Not Contain Element    ${Dashboard}
    Page Should Not Contain Element    ${Dashboard_Overview}
    Page Should Not Contain Element    ${Dashboard_System monitoring}
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Not Contain Element    ${Sherlock_Marketing}
    Page Should Contain Element    ${Sherlock_Finance}
    Page Should Not Contain Element    ${Sherlock_Operations}
    Page Should Not Contain Element    ${Sherlock_Delivery}
    Page Should Not Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Contain Element    ${Sherlock_Business Development}
    Page Should Not Contain Element    ${ProductCatalogue}
    Page Should Not Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Not Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Not Contain Element    ${ProductCatalogue_ExportHistory}
    Page Should Not Contain Element    ${ItemsAndInventory}
    Page Should Not Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Not Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Not Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Not Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Not Contain Element    ${ItemsAndInventory_ImportHistory}
    Page Should Not Contain Element    ${PurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    Page Should Not Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Not Contain Element    ${PurchaseOrders_ImportHistory}
    Page Should Not Contain Element    ${Supplier}
    Page Should Not Contain Element    ${Supplier_ManageSupplier}
    Page Should Not Contain Element    ${Supplier_ImportHistory}
    Page Should Not Contain Element    ${Delivery}
    Page Should Not Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}
    Page Should Not Contain Element    ${ManageInventoryItems}
    Page Should Not Contain Element    ${ManageInventoryItems_ListofItems}
    Page Should Not Contain Element    ${ManageSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Not Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Not Contain Element    ${ManageSalesOrders_Packing}
    Page Should Not Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    Page Should Not Contain Element    ${ManageFulfillments}
    Page Should Not Contain Element    ${ManageFulfillments_ListofFulfillments}
    Page Should Not Contain Element    ${Import/Export}
    Page Should Not Contain Element    ${Import/Export_ImportFailed}
    Page Should Not Contain Element    ${Import/Export_TransactionImportHistory}
    Page Should Not Contain Element    ${Report}
    Page Should Not Contain Element    ${Report_PendingFulfillmentReport}
    Page Should Not Contain Element    ${ManagePartners}
    Page Should Not Contain Element    ${ManagePartners_ListofPartners}
    Page Should Not Contain Element    ${SystemConfigurations}
    Page Should Not Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Not Contain Element    ${NetsuiteRe-Synchronization}

TC013 HR
    #    role
    login_IDP    ${HR}
    # Click side bar
    Page Should Not Contain Element    ${Dashboard}
    Page Should Not Contain Element    ${Dashboard_Overview}
    Page Should Not Contain Element    ${Dashboard_System monitoring}
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Not Contain Element    ${Sherlock_Marketing}
    Page Should Not Contain Element    ${Sherlock_Finance}
    Page Should Not Contain Element    ${Sherlock_Operations}
    Page Should Not Contain Element    ${Sherlock_Delivery}
    Page Should Not Contain Element    ${Sherlock_BrandCommerce}
    Page Should Contain Element    ${Sherlock_HR}
    Page Should Not Contain Element    ${Sherlock_Business Development}
    Page Should Not Contain Element    ${ProductCatalogue}
    Page Should Not Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Not Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Not Contain Element    ${ProductCatalogue_ExportHistory}
    Page Should Not Contain Element    ${ItemsAndInventory}
    Page Should Not Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Not Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Not Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Not Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Not Contain Element    ${ItemsAndInventory_ImportHistory}
    Page Should Not Contain Element    ${PurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Not Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    Page Should Not Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Not Contain Element    ${PurchaseOrders_ImportHistory}
    Page Should Not Contain Element    ${Supplier}
    Page Should Not Contain Element    ${Supplier_ManageSupplier}
    Page Should Not Contain Element    ${Supplier_ImportHistory}
    Page Should Not Contain Element    ${Delivery}
    Page Should Not Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}
    Page Should Not Contain Element    ${ManageInventoryItems}
    Page Should Not Contain Element    ${ManageInventoryItems_ListofItems}
    Page Should Not Contain Element    ${ManageSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Not Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Not Contain Element    ${ManageSalesOrders_Packing}
    Page Should Not Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    Page Should Not Contain Element    ${ManageFulfillments}
    Page Should Not Contain Element    ${ManageFulfillments_ListofFulfillments}
    Page Should Not Contain Element    ${Import/Export}
    Page Should Not Contain Element    ${Import/Export_ImportFailed}
    Page Should Not Contain Element    ${Import/Export_TransactionImportHistory}
    Page Should Not Contain Element    ${Report}
    Page Should Not Contain Element    ${Report_PendingFulfillmentReport}
    Page Should Not Contain Element    ${ManagePartners}
    Page Should Not Contain Element    ${ManagePartners_ListofPartners}
    Page Should Not Contain Element    ${SystemConfigurations}
    Page Should Not Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Not Contain Element    ${NetsuiteRe-Synchronization}

TC014 SMGR
    #    role
    login_IDP    ${SMGR}
    # Click side bar
    Page Should Not Contain Element    ${Dashboard}
    Page Should Not Contain Element    ${Dashboard_Overview}
    Page Should Not Contain Element    ${Dashboard_System monitoring}
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Contain Element    ${Sherlock_Marketing}
    Page Should Not Contain Element    ${Sherlock_Finance}
    Page Should Contain Element    ${Sherlock_Operations}
    Page Should Not Contain Element    ${Sherlock_Delivery}
    Page Should Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Contain Element    ${Sherlock_Business Development}
    Page Should Contain Element    ${ProductCatalogue}
    Page Should Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Contain Element    ${ProductCatalogue_ExportHistory}
    Page Should Contain Element    ${ItemsAndInventory}
    Page Should Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Contain Element    ${ItemsAndInventory_ImportHistory}
    Page Should Contain Element    ${PurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    Page Should Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Contain Element    ${PurchaseOrders_ImportHistory}
    Page Should Contain Element    ${Supplier}
    Page Should Contain Element    ${Supplier_ManageSupplier}
    Page Should Contain Element    ${Supplier_ImportHistory}
    Page Should Contain Element    ${Delivery}
    Page Should Contain Element    ${Delivery_ShippingOrder}
    Page Should Contain Element    ${Delivery_OverPickupOrder}
    Page Should Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Contain Element    ${Delivery_ImportHistory}
    Page Should Not Contain Element    ${ManageInventoryItems}
    Page Should Not Contain Element    ${ManageInventoryItems_ListofItems}
    Page Should Not Contain Element    ${ManageSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Not Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Not Contain Element    ${ManageSalesOrders_Packing}
    Page Should Not Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    Page Should Not Contain Element    ${ManageFulfillments}
    Page Should Not Contain Element    ${ManageFulfillments_ListofFulfillments}
    Page Should Not Contain Element    ${Import/Export}
    Page Should Not Contain Element    ${Import/Export_ImportFailed}
    Page Should Not Contain Element    ${Import/Export_TransactionImportHistory}
    Page Should Not Contain Element    ${Report}
    Page Should Not Contain Element    ${Report_PendingFulfillmentReport}
    Page Should Not Contain Element    ${ManagePartners}
    Page Should Not Contain Element    ${ManagePartners_ListofPartners}
    Page Should Not Contain Element    ${SystemConfigurations}
    Page Should Not Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Not Contain Element    ${NetsuiteRe-Synchronization}

TC015 PURC
    #    role
    login_IDP    ${PURC}
    # Click side bar
    Page Should Not Contain Element    ${Dashboard}
    Page Should Not Contain Element    ${Dashboard_Overview}
    Page Should Not Contain Element    ${Dashboard_System monitoring}
    Page Should Contain Element    ${Sherlock}
    Page Should Contain Element    ${Sherlock_Public}
    Page Should Contain Element    ${Sherlock_Marketing}
    Page Should Not Contain Element    ${Sherlock_Finance}
    Page Should Contain Element    ${Sherlock_Operations}
    Page Should Not Contain Element    ${Sherlock_Delivery}
    Page Should Not Contain Element    ${Sherlock_BrandCommerce}
    Page Should Not Contain Element    ${Sherlock_HR}
    Page Should Not Contain Element    ${Sherlock_Business Development}
    Page Should Not Contain Element    ${ProductCatalogue}
    Page Should Not Contain Element    ${ProductCatalogue_ManageProduct}
    Page Should Not Contain Element    ${ProductCatalogue_ImportHistory}
    Page Should Not Contain Element    ${ProductCatalogue_ExportHistory}
    Page Should Contain Element    ${ItemsAndInventory}
    Page Should Contain Element    ${ItemsAndInventory_ManageItem}
    Page Should Not Contain Element    ${ItemsAndInventory_DemandForecast}
    Page Should Not Contain Element    ${ItemsAndInventory_Replenishment}
    Page Should Contain Element    ${ItemsAndInventory_ChannelAllocation}
    Page Should Contain Element    ${ItemsAndInventory_ImportHistory}
    Page Should Contain Element    ${PurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManagePurchaseOrders}
    Page Should Contain Element    ${PurchaseOrders_ManageGoodsReceiptNotes}
    Page Should Contain Element    ${PurchaseOrders_BatchItemReceipts}
    Page Should Contain Element    ${PurchaseOrders_ImportHistory}
    Page Should Contain Element    ${Supplier}
    Page Should Contain Element    ${Supplier_ManageSupplier}
    Page Should Contain Element    ${Supplier_ImportHistory}
    Page Should Not Contain Element    ${Delivery}
    Page Should Not Contain Element    ${Delivery_ShippingOrder}
    Page Should Not Contain Element    ${Delivery_OverPickupOrder}
    Page Should Not Contain Element    ${Delivery_ManagePickup}
    Page Should Not Contain Element    ${Delivery_ManageDelivery}
    Page Should Not Contain Element    ${Delivery_ManageReturn}
    Page Should Not Contain Element    ${Delivery_ManageProvider}
    Page Should Not Contain Element    ${Delivery_ManagePreDefinedPackage}
    Page Should Not Contain Element    ${Delivery_ImportHistory}
    Page Should Not Contain Element    ${ManageInventoryItems}
    Page Should Not Contain Element    ${ManageInventoryItems_ListofItems}
    Page Should Not Contain Element    ${ManageSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofSalesOrders}
    Page Should Not Contain Element    ${ManageSalesOrders_ListofBackorders}
    Page Should Not Contain Element    ${ManageSalesOrders_PickingandQC}
    Page Should Not Contain Element    ${ManageSalesOrders_Packing}
    Page Should Not Contain Element    ${ManageSalesOrders_PrintFulfillmentDoc}
    Page Should Not Contain Element    ${ManageFulfillments}
    Page Should Not Contain Element    ${ManageFulfillments_ListofFulfillments}
    Page Should Not Contain Element    ${Import/Export}
    Page Should Not Contain Element    ${Import/Export_ImportFailed}
    Page Should Not Contain Element    ${Import/Export_TransactionImportHistory}
    Page Should Not Contain Element    ${Report}
    Page Should Not Contain Element    ${Report_PendingFulfillmentReport}
    Page Should Not Contain Element    ${ManagePartners}
    Page Should Not Contain Element    ${ManagePartners_ListofPartners}
    Page Should Not Contain Element    ${SystemConfigurations}
    Page Should Not Contain Element    ${SystemConfigurations_SetupPaymentTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupShippingTypes}
    Page Should Not Contain Element    ${SystemConfigurations_SetupNetsuiteLibrary}
    Page Should Not Contain Element    ${NetsuiteRe-Synchronization}

TC016 PADM
    #    role
    login_IDP    ${PADM}
    Access Denied

TC017 POPS
    #    role
    login_IDP    ${POPS}
    Access Denied

TC018 PSHP
    #    role
    login_IDP    ${PSHP}
    Access Denied

TC019 PDC
    #    role
    login_IDP    ${PDC}
    Access Denied

TC020 CTVR
    #    role
    login_IDP    ${CTVR}
    Access Denied

TC021 MERC
    #    role
    login_IDP    ${MERC}
    Access Denied

ADM/Dashboard
    login_IDP    ${ADM}
    Comment    ${isOverview}    ${isSystem monitoring}
    Validate Dashboard menu    true    true

ADM/Sherlock
    login_IDP    ${ADM}
    comment    ${isPublic}    ${isMarketing}    ${isFinance}    ${isOperations}    # ${isDelivery}    ${isBrand Commerce}
    ...    # ${isHR}    ${isBusiness Development}
    Comment    Validate Sherlock menu    true    true    false    true    true
    ...    true    false    true

ADM/Product Catalog
    login_IDP    ${ADM}
    comment    ${isManage Product}    ${isImport History}    ${isExport History}
    Validate Product Catalog menu    true    true    true

ADM/Items & Inventory
    login_IDP    ${ADM}
    comment    ${isManage Item}    ${isDemand Forecast}    ${isReplenishment}  ${isChannelAllocation}  ${isImport History}
    Validate Items & Inventory menu    true    true    true   true    true

ADM/Purchase Orders
    login_IDP    ${ADM}
    comment    ${isManage Purchase Orders}    ${isManage Goods Receipt Notes}    ${isBatch Item Receipts}    ${isImport History}
    Validate Purchase Orders menu    true    true    true    true

ADM/Supplier
    login_IDP    ${ADM}
    comment    ${isManage Supplier}    ${isImport History}
    Validate Supplier menu    true    true

ADM/Delivery
    login_IDP    ${ADM}
    comment    ${isShipping Order}   ${isOver-Pickup Orders}   ${isManage Pick up}   ${isManage Delivery}    ${isManage Return}    ${isManage Provider}    ${isManage Pre-defined Package}   ${isImport History}
    Validate Delivery menu    true    true    true    true    true    true    true    true

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

ADM/Import/Export menu
    login_IDP    ${ADM}
    comment    ${isImport Failed}    ${isTransaction Import History (History)}
    Validate Import/Export menu    true    true

ADM/Report
    login_IDP    ${ADM}
    comment    ${isPending Fulfillment Report}
    Validate Report menu    true

ADM/ManagePartners
    login_IDP    ${ADM}
    comment    ${isList of Partners}
    Validate Manage Partners menu    true

ADM/SystemConfiguration
    login_IDP    ${ADM}
    comment    ${isSetup Payment Types}    ${isSetup Shipping Types}    ${isSetup Netsuite Library}    ${isNetsuite Re-Synchronization}
    Validate System Configuration menu    true    true    true    true
