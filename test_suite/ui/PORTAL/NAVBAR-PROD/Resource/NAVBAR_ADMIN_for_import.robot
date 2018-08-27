*** Settings ***
Library           Selenium2Library
Resource          global_resource.robot

*** Variables ***
${SideBar}        xpath=/html/body/div[3]/div[1]/ul/li[1]/div
${Dashboard}      id=dashboard-0
${Dashboard_Overview}    id=overview-0-0
${Dashboard_System monitoring}    id=system-monitoring-0-1
${Sherlock}       id=sherlock-1
${Sherlock_Public}    id=public-1-0
${Sherlock_Marketing}    id=marketing-1-1
${Sherlock_Finance}    id=finance-1-2
${Sherlock_Operations}    id=operations-1-3
${Sherlock_Delivery}    id=delivery-1-4
${Sherlock_BrandCommerce}    id=brand-commerce-1-5
${Sherlock_Business Development}    id=business-development-1-6
${Sherlock_HR}    id=hr-1-7
${ProductCatalogue}    id=product-catalog-2
${ProductCatalogue_ManageProduct}    id=manage-product-2-0
${ProductCatalogue_ImportHistory}    id=import-history-2-1
${ProductCatalogue_ExportHistory}    id=export-history-2-2
${ItemsAndInventory}    id=item--inventory-3
${ItemsAndInventory_ManageItem}    id=manage-item-3-0
${ItemsAndInventory_DemandForecast}    id=demand-forecast-3-1
${ItemsAndInventory_Replenishment}    id=replenishment-3-2
${ItemsAndInventory_ChannelAllocation}    id=channel-allocation-3-3
${ItemsAndInventory_ImportHistory}    id=import-history-3-4
${PurchaseOrders}    id=[beta]purchase-orders-4
${PurchaseOrders_ManagePurchaseOrders}    id=manage-purchase-orders-4-0
${PurchaseOrders_ManageGoodsReceiptNotes}    id=manage-goods-received-notes-4-1
# ${PurchaseOrders_BatchItemReceipts}    id=batch-item-receipts-4-2
${PurchaseOrders_ImportHistory}    id=import-history-4-2
${Supplier}       id=supplier-5
${Supplier_ManageSupplier}    id=manage-supplier-5-0
${Supplier_ImportHistory}    id=import-history-5-1
${Delivery}       id=delivery-6
${Delivery_ShippingOrder}    id=shipping-orders-6-0
${Delivery_OverPickupOrder}    id=over-pickup-orders-6-1
${Delivery_ManagePickup}    id=manage-pickup-6-2
${Delivery_ManageDelivery}    id=manage-delivery-6-3
${Delivery_ManageReturn}    id=manage-return-6-4
${Delivery_ManageProvider}    id=manage-providers-6-5
${Delivery_ManagePreDefinedPackage}    id=manage-pre-defined-package-6-6
${Delivery_ImportHistory}    id=import-history-6-7
# ${Import}         id=import-7
# ${Import_AllImportHistory}      id=all-import-history-7-0
${ManageInventoryItems}    id=manage-inventory-items-8
${ManageInventoryItems_ListofItems}    id=list-of-items-8-0
${ManagePurchaseOrders}    id=manage-purchase-orders-9
${ManagePurchaseOrders_ListOfPurchaseOrders}    id=list-of-purchase-orders-9-0
${ManageItemReceipts}    id=manage-item-receipt-10
${ManageItemReceipts_BatchProcessItemReceipts}    id=batch-process-item-receipts-10-0
${ManageSalesOrders}    id=manage-sales-orders-11
${ManageSalesOrders_ListofSalesOrders}    id=list-of-sales-orders-11-0
${ManageSalesOrders_ListofBackorders}    id=list-of-backorders-11-1
${ManageSalesOrders_PickingandQC}    id=picking--qc-11-2
${ManageSalesOrders_Packing}    id=packing-11-3
${ManageSalesOrders_PrintFulfillmentDoc}    id=print-fulfillment-doc.-11-4
${ManageFulfillments}    id=manage-fulfillments-12
${ManageFulfillments_ListofFulfillments}    id=list-of-fulfillments-12-0
${Import/Export}    id=import/export-13
${Import/Export_ImportFailed}    id=import-failed-13-0
${Import/Export_TransactionImportHistory}    id=transaction-import-history-13-1
${Report}         id=report-14
${Report_PendingFulfillmentReport}    id=pending-fulfillment-report-14-0
${ManagePartners}    id=manage-partners-15
${ManagePartners_ListofPartners}    id=list-of-partners-15-0
${SystemConfigurations}    id=system-configuration-16
${SystemConfigurations_SetupPaymentTypes}    id=setup-payment-types-16-0
${SystemConfigurations_SetupShippingTypes}    id=setup-shipping-types-16-1
${SystemConfigurations_SetupNetsuiteLibrary}    id=setup-netsuite-library-16-2
${NetsuiteRe-Synchronization}    id=netsuite-re-synchronization-16-3
#locator
${Dashboard_locator}    css=#dashboard-0 > a > span
${Dashboard_Overview_locator}    css=#overview-0-0 > span
${Dashboard_System monitoring_locator}    css=#system-monitoring-0-1 > span
${Sherlock_locator}    css=#sherlock-1 > a > span
${Sherlock_Public_locator}    css=#public-1-0 > span
${Sherlock_Marketing_locator}    css=#marketing-1-1 > span
${Sherlock_Finance_locator}    css=#finance-1-2 > span
${Sherlock_Operations_locator}    css=#operations-1-3 > span
${Sherlock_Delivery_locator}    css=#delivery-1-4 > span
${Sherlock_BrandCommerce_locator}    css=#brand-commerce-1-5 > span
${Sherlock_HR_locator}    css=#hr-1-7 > span
${Sherlock_Business_Development_locator}    css=#business-development-1-6 > span
${ProductCatalogue_locator}    css=#product-catalog-2 > a > span
${ProductCatalogue_ManageProduct_locator}    css=#manage-product-2-0 > span
${ProductCatalogue_ImportHistory_locator}    css=#import-history-2-1 > span
${ProductCatalogue_ExportHistory_locator}    css=#export-history-2-2 > span
${ItemsAndInventory_locator}    css=#item--inventory-3 > a > span
${ItemsAndInventory_ManageItem_locator}    css=#manage-item-3-0 > span
${ItemsAndInventory_DemandForecast_locator}    css=#demand-forecast-3-1 > span
${ItemsAndInventory_Replenishment_locator}    css=#replenishment-3-2 > span
${ItemsAndInventory_ChannelAllocation_locator}    css=#channel-allocation-3-3 > span
${ItemsAndInventory_ImportHistory_locator}    css=#import-history-3-4 > span
${PurchaseOrders_locator}    css=#purchase-orders-4 > a > span
${PurchaseOrders_ManagePurchaseOrders_locator}    css=#manage-purchase-orders-4-0 > span
${PurchaseOrders_ManageGoodsReceiptNotes_locator}    css=#manage-goods-received-notes-4-1 > span
# ${PurchaseOrders_BatchItemReceipts_locator}    css=#batch-item-receipts-4-2 > span
${PurchaseOrders_ImportHistory_locator}    css=#import-history-4-3 > span
${Supplier_locator}    css=#supplier-5 > a > span
${Supplier_ManageSupplier_locator}    css=#manage-supplier-5-0 > span
${Supplier_ImportHistory_locator}    css=#import-history-5-1 > span
${Delivery_locator}    css=#delivery-6 > a > span
${Delivery_ShippingOrder_locator}    css=#shipping-orders-6-0 > span
${Delivery_OverPickupOrder_locator}    css=#over-pickup-orders-6-1 > span
${Delivery_ManagePickup_locator}    css=#manage-pickup-6-2 > span
${Delivery_ManageDelivery_locator}    css=#manage-delivery-6-3 > span
${Delivery_ManageReturn_locator}    css=#manage-return-6-4 > span
${Delivery_ManageProvider_locator}    css=#manage-providers-6-5 > span
${Delivery_ManagePreDefinedPackage_locator}    css=#manage-pre-defined-package-6-6 > span
${Delivery_ImportHistory_locator}    css=#import-history-6-7 > span
${Import_locator}         css=#import-7 > a > span
${Import_AllImportHistory_locator}      css=#all-import-history-7-0 > span
${ManageInventoryItems_locator}    css=#manage-inventory-items-8 > a > span
${ManageInventoryItems_ListofItems_locator}    css=#list-of-items-8-0 > span
${ManagePurchaseOrders_locator}    css=#manage-purchase-orders-9 > a > span
${ManagePurchaseOrders_ListOfPurchaseOrders_locator}    css=#list-of-purchase-orders-9-0 > span
${ManageItemReceipts_locator}    css=#manage-item-receipt-10 > a > span
${ManageItemReceipts_BatchProcessItemReceipts}    css=#batch-process-item-receipts-10-0 > span
${ManageSalesOrders_locator}    css=#manage-sales-orders-11 > a > span
${ManageSalesOrders_ListofSalesOrders_locator}    css=#list-of-sales-orders-11-0 > span
${ManageSalesOrders_ListofBackorders_locator}    css=#list-of-backorders-11-1 > span
${ManageSalesOrders_PickingandQC_locator}    css=#picking--qc-11-2 > span
${ManageSalesOrders_Packing_locator}    css=#packing-11-3 > span
${ManageSalesOrders_PrintFulfillmentDoc_locator}    xpath=//*[@id="print-fulfillment-doc.-11-4"]/span
${ManageFulfillments_locator}    css=#manage-fulfillments-12 > a > span
${ManageFulfillments_ListofFulfillments_locator}    css=#list-of-fulfillments-12-0 > span
${Import/Export_locator}    css=#import\\2f export-13 > a > span
${Import/Export_ImportFailed_locator}    css=#import-failed-13-0 > span
${Import/Export_TransactionImportHistory_locator}    css=#transaction-import-history-13-1 > span
${Report_locator}    css=#report-14 > a > span
${Report_PendingFulfillmentReport_locator}    css=#pending-fulfillment-report-14-0 > span
${ManagePartners_locator}    css=#manage-partners-15 > a > span
${ManagePartners_ListofPartners_locator}    css=#list-of-partners-15-0 > span
${SystemConfigurations_locator}    css=#system-configuration-16 > a > span
${SystemConfigurations_SetupPaymentTypes_locator}    css=#setup-payment-types-16-0 > span
${SystemConfigurations_SetupShippingTypes_locator}    css=#setup-shipping-types-16-1 > span
${SystemConfigurations_SetupNetsuiteLibrary_locator}    css=#setup-netsuite-library-16-2 > span
${NetsuiteRe-Synchronization_locator}    css=#netsuite-re-synchronization-16-3 > span

*** Keywords ***
Click side bar
    Wait Until Page Contains Element    xpath=/html/body/div[3]/div[1]/ul/li[1]/div    10
    Click Element    ${SideBar}

Validate Dashboard menu
    [Arguments]    ${isOverview}    ${isSystem monitoring}
    Click side bar
    Wait Until Page Contains Element    ${Dashboard_locator}    10
    Element Text Should Be    ${Dashboard_locator}    Dashboard
    ${collapse_nav_bar}=    Run Keyword And Return Status    Element Should Not Be Visible    ${Dashboard_locator}
    Run Keyword If    ${collapse_nav_bar}    Click Element    ${Dashboard_locator}
    Run Keyword If    '${isOverview}'=='true'    Run Keywords    Wait Until Page Contains Element    ${Dashboard_Overview_locator}    10
    ...    AND    Element Text Should Be    ${Dashboard_Overview_locator}    Overview
    ...    AND    Click Element    ${Dashboard_Overview_locator}
    ...    AND    URL should be    /dashboard/default/
    ...    AND    Wait Until Page Contains    Welcome to Admin Portal.    10
    Run Keyword If    '${isSystem monitoring}'=='true'    Run Keywords    Wait Until Page Contains Element    ${Dashboard_System monitoring_locator}    10
    ...    AND    Element Text Should Be    ${Dashboard_System monitoring_locator}    System Monitoring
    ...    AND    Click Element    ${Dashboard_System monitoring_locator}
    ...    AND    URL should be    /dashboard/monitoring/
    ...    AND    Wait Until Page Contains    Welcome to Monitoring Dashboard    10

Validate Sherlock menu
    [Arguments]    ${isPublic}    ${isMarketing}    ${isFinance}    ${isOperations}    ${isDelivery}    ${isBrand Commerce}
    ...    ${isHR}    ${isBusiness Development}
    Click side bar
    Element Text Should Be    ${Sherlock_locator}    Sherlock
    Click Element    ${Sherlock_locator}
    Run Keyword If    '${isPublic}'=='true'    Run Keywords    Element Text Should Be    ${Sherlock_Public_locator}    Public
    ...    AND    Click Element    ${Sherlock_Public_locator}
    ...    AND    URL should be    /sherlock/launcher/public
    ...    AND    Wait Until Page Contains    Home    15
    Run Keyword If    '${isMarketing}'=='true'    Run Keywords    Element Text Should Be    ${Sherlock_Marketing_locator}    Marketing
    ...    AND    Click Element    ${Sherlock_Marketing}
    ...    AND    URL should be    /sherlock/marketing/
    ...    AND    Wait Until Page Contains    Apps    15
    Run Keyword If    '${isFinance}'=='true'    Run Keywords    Element Text Should Be    ${Sherlock_Finance_locator}    Finance
    ...    AND    Click Element    ${Sherlock_Finance_locator}
    ...    AND    URL should be    /sherlock/finance/
    ...    AND    Wait Until Page Contains    Apps    15
    Run Keyword If    '${isOperations}'=='true'    Run Keywords    Element Text Should Be    ${Sherlock_Operations_locator}    Operations
    ...    AND    Click Element    ${Sherlock_Operations_locator}
    ...    AND    URL should be    /sherlock/operations/
    ...    AND    Wait Until Page Contains    Apps    15
    Run Keyword If    '${isDelivery}'=='true'    Run Keywords    Element Text Should Be    ${Sherlock_Delivery_locator}    Delivery
    ...    AND    Click Element    ${Sherlock_Delivery_locator}
    ...    AND    URL should be    /sherlock/delivery/
    ...    AND    Wait Until Page Contains    Apps    15
    Run Keyword If    '${isBrand Commerce}'=='true'    Run Keywords    Element Text Should Be    ${Sherlock_BrandCommerce_locator}    Brand Commerce
    ...    AND    Click Element    ${Sherlock_BrandCommerce_locator}
    ...    AND    URL should be    /sherlock/brandcommerce/
    ...    AND    Wait Until Page Contains    Apps    15
    Run Keyword If    '${isBusiness Development}'=='true'    Run Keywords    Element Text Should Be    ${Sherlock_Business_Development_locator}    Business Development
    ...    AND    Click Element    ${Sherlock_Business_Development_locator}
    ...    AND    URL should be    /sherlock/businessdevelopment/
    ...    AND    Wait Until Page Contains    Apps    15
    Run Keyword If    '${isHR}'=='true'    Run Keywords    Element Text Should Be    ${Sherlock_HR_locator}    HR
    ...    AND    Click Element    ${Sherlock_HR_locator}
    ...    AND    Location Should Be    https://acommerce.bamboohr.co.uk/login.php?r=%2Fhome%2F
    ...    AND    Wait Until Page Contains    BambooHR    15

Validate Product Catalog menu
    [Arguments]    ${isManage Product}    ${isImport History}    ${isExport History}
    Click side bar
    Element Text Should Be    ${ProductCatalogue_locator}    Product Catalog
    Click Element    ${ProductCatalogue_locator}
    Run Keyword If    '${isManage Product}'=='true'    Run Keywords    Element Text Should Be    ${ProductCatalogue_ManageProduct_locator}    Manage Product
    ...    AND    Click Element    ${ProductCatalogue_ManageProduct_locator}
    ...    AND    URL should be    /product-catalog/front/#/products
    ...    AND    Wait Until Page Contains    Product List    20
    Run Keyword If    '${isImport History}'=='true'    Run Keywords    Element Text Should Be    ${ProductCatalogue_ImportHistory_locator}    Import History
    ...    AND    Click Element    ${ProductCatalogue_ImportHistory_locator}
    ...    AND    URL should be    /product-catalog/front/#/history
    ...    AND    Wait Until Page Contains    Import History    20
    Run Keyword If    '${isExport History}'=='true'    Run Keywords    Element Text Should Be    ${ProductCatalogue_ExportHistory_locator}    Export History
    ...    AND    Click Element    ${ProductCatalogue_ExportHistory_locator}
    ...    AND    URL should be    /product-catalog/front/#/export
    ...    AND    Wait Until Page Contains    Export History    20

Validate Items & Inventory menu
    [Arguments]    ${isManage Item}    ${isDemand Forecast}    ${isReplenishment}    ${isChannelAllocation}    ${isImport History}
    Click side bar
    Element Text Should Be    ${ItemsAndInventory_locator}    Item & Inventory
    Click Element    ${ItemsAndInventory_locator}
    Run Keyword If    '${isManage Item}'=='true'    Run Keywords    Element Text Should Be    ${ItemsAndInventory_ManageItem_locator}    Manage Item
    ...    AND    Click Element    ${ItemsAndInventory_ManageItem_locator}
    ...    AND    URL should be    /beehive/frontend/ui-item
    ...    AND    Wait Until Page Contains    Manage Item    10
    Run Keyword If    '${isDemand Forecast}'=='true'    Run Keywords    Element Text Should Be    ${ItemsAndInventory_DemandForecast_locator}    Demand Forecast
    ...    AND    Click Element    ${ItemsAndInventory_DemandForecast_locator}
    ...    AND    URL should be    /demand-forecast/forecast
    ...    AND    Wait Until Page Contains    Demand Forecast    10
    Run Keyword If    '${isReplenishment}'=='true'    Run Keywords    Element Text Should Be    ${ItemsAndInventory_Replenishment_locator}    Replenishment
    ...    AND    Click Element    ${ItemsAndInventory_Replenishment_locator}
    ...    AND    URL should be    /demand-forecast/reorder
    ...    AND    Wait Until Page Contains    Replenishment    10
    Run Keyword If    '${isImport History}'=='true'    Run Keywords    Element Text Should Be    ${ItemsAndInventory_ImportHistory_locator}    Import History
    ...    AND    Click Element    ${ItemsAndInventory_ImportHistory_locator}
    ...    AND    URL should be    /beehive/frontend/item-master/import-histories
    ...    AND    Wait Until Page Contains    Item Import History List    10
    Run Keyword If    '${isChannelAllocation}'=='true'    Run Keywords    Element Text Should Be    ${ItemsAndInventory_ChannelAllocation_locator}    Channel Allocation
    ...    AND    Click Element    ${ItemsAndInventory_ChannelAllocation_locator}
    ...    AND    Location Should Be    https://channels.acommerce.asia/login?next=/
    ...    AND    Wait Until Page Contains    Login to aCommerce Management Portal    10

Validate Purchase Orders menu
    #  [Arguments]    ${isManage Purchase Orders}    ${isManage Goods Receipt Notes}    ${isBatch Item Receipts}    ${isImport History}
    [Arguments]    ${isManage Purchase Orders}    ${isManage Goods Receipt Notes}  ${isImport History}
    Click side bar
    Element Text Should Be    ${PurchaseOrders_locator}    Purchase Orders
    Click Element    ${PurchaseOrders_locator}
    Run Keyword If    '${isManage Purchase Orders}'=='true'    Run Keywords    Element Text Should Be    ${PurchaseOrders_ManagePurchaseOrders_locator}    Manage Purchase Orders
    ...    AND    Click Element    ${PurchaseOrders_ManagePurchaseOrders_locator}
    ...    AND    URL should contain    /beehive/frontend/ui-purchase-order/
    ...    AND    Wait Until Page Contains    Purchase Order List    10
    Run Keyword If    '${isManage Goods Receipt Notes}'=='true'    Run Keywords    Element Text Should Be    ${PurchaseOrders_ManageGoodsReceiptNotes_locator}   Manage Goods Received Notes
    ...    AND    Click Element    ${PurchaseOrders_ManageGoodsReceiptNotes_locator}
    ...    AND    URL should contain    /beehive/frontend/ui-goods-received-note
    ...    AND    Wait Until Page Contains    Goods Received Note List    10
    # Run Keyword If    '${isBatch Item Receipts'=='true'    Run Keywords    Element Text Should Be    ${PurchaseOrders_BatchItemReceipts_locator}    Batch Item Receipts
    # ...    AND    Click Element    ${PurchaseOrders_BatchItemReceipts_locator}
    # ...    AND    URL should contain    /itemreceipt/import/
    # ...    AND    Wait Until Page Contains    Batch process Item Receipt    10
    Run Keyword If    '${isImport History}'=='true'    Run Keywords    Element Text Should Be    ${PurchaseOrders_ImportHistory_locator}    Import History
    ...    AND    Click Element    ${PurchaseOrders_ImportHistory_locator}
    ...    AND    URL should contain    /beehive/frontend/purchase-order/import-histories/
    ...    AND    Wait Until Page Contains    Purchase Order Import History List    10

Validate Supplier menu
    [Arguments]    ${isManage Supplier}    ${isImport History}
    Click side bar
    Element Text Should Be    ${Supplier_locator}    Supplier
    Click Element    ${Supplier_locator}
    Run Keyword If    '${isManage Supplier}'=='true'    Run Keywords    Element Text Should Be    ${Supplier_ManageSupplier_locator}    Manage Supplier
    ...    AND    Click Element    ${Supplier_ManageSupplier_locator}
    ...    AND    URL should be    /beehive/frontend/ui-supplier
    ...    AND    Wait Until Page Contains    Manage Supplier    10
    Run Keyword If    '${isImport History}'=='true'    Run Keywords    Element Text Should Be    ${Supplier_ImportHistory_locator}    Import History
    ...    AND    Click Element    ${Supplier_ImportHistory_locator}
    ...    AND    URL should contain    /beehive/frontend/supplier/import-histories
    ...    AND    Wait Until Page Contains    Supplier Import History List    10

Validate Delivery menu
    [Arguments]    ${isShipping Order}    ${isOver-Pickup Orders}    ${isManage Pick up}    ${isManage Delivery}    ${isManage Return}    ${isManage Provider}
    ...    ${isManage Pre-defined Package}    ${isImport History}
    Click side bar
    Element Text Should Be    ${Delivery_locator}    Delivery
    Click Element    ${Delivery_locator}
    Run Keyword If    '${isShipping Order}'=='true'    Run Keywords    Element Text Should Be    ${Delivery_ShippingOrder_locator}    Shipping Orders
    ...    AND    Click Element    ${Delivery_ShippingOrder_locator}
    ...    AND    URL should be    /smartship-front/view/shipment-list
    ...    AND    Wait Until Page Contains    Shipping Orders    10
    Run Keyword If    '${isOver-Pickup Orders}'=='true'    Run Keywords    Element Text Should Be    ${Delivery_OverPickupOrder_locator}    Over-Pickup Orders
    ...    AND    Click Element    ${Delivery_OverPickupOrder_locator}
    ...    AND    URL should be    /smartship-front/view/overpickup-list
    ...    AND    Wait Until Page Contains    Over-Pickup Orders    10
    Run Keyword If    '${isManage Pick up}'=='true'    Run Keywords    Element Text Should Be    ${Delivery_ManagePickup_locator}    Manage Pickup
    ...    AND    Click Element    ${Delivery_ManagePickup_locator}
    ...    AND    URL should be    /smartship-front/view/manage-pickup
    ...    AND    Wait Until Page Contains    Manage Pickup    10
    Run Keyword If    '${isManage Delivery}'=='true'    Run Keywords    Element Text Should Be    ${Delivery_ManageDelivery_locator}    Manage Delivery
    ...    AND    Click Element    ${Delivery_ManageDelivery_locator}
    ...    AND    URL should be    /smartship-front/view/manage-delivery
    ...    AND    Wait Until Page Contains    Manage Delivery    10
    Run Keyword If    '${isManage Return}'=='true'    Run Keywords    Element Text Should Be    ${Delivery_ManageReturn_locator}    Manage Return
    ...    AND    Click Element    ${Delivery_ManageReturn_locator}
    ...    AND    URL should be    /smartship-front/view/manage-return
    ...    AND    Wait Until Page Contains    Manage Return    10
    Run Keyword If    '${isManage Provider}'=='true'    Run Keywords    Element Text Should Be    ${Delivery_ManageProvider_locator}    Manage Providers
    ...    AND    Click Element    ${Delivery_ManageProvider_locator}
    ...    AND    URL should be    /smartship-front/view/providers
    ...    AND    Wait Until Page Contains    Manage Providers    10
    Run Keyword If    '${isManage Pre-defined Package}'=='true'    Run Keywords    Element Text Should Be    ${Delivery_ManagePreDefinedPackage_locator}    Manage Pre-defined Package
    ...    AND    Click Element    ${Delivery_ManagePreDefinedPackage_locator}
    ...    AND    URL should be    /smartship-front/view/manage-predefined-package
    ...    AND    Wait Until Page Contains    Manage Pre-defined Package    10
    Run Keyword If    '${isImport History}'=='true'    Run Keywords    Element Text Should Be    ${Delivery_ImportHistory_locator}    Import History
    ...    AND    Click Element    ${Delivery_ImportHistory_locator}
    ...    AND    URL should be    /smartship-front/view/import-history
    ...    AND    Wait Until Page Contains    Import History    10

Validate Import menu
    [Arguments]    ${isImport History}
    Click side bar
    Element Text Should Be    ${Import_locator}    Import
    Click Element    ${Import_locator}
    Run Keyword If    '${isImport History}'=='true'    Run Keywords    Element Text Should Be    ${Import_ImportHistory_locator}    Import History
    ...    AND    Click Element    ${Import_ImportHistory_locator}
    ...    AND    URL should contain    /filesimporterui/frontend/
    ...    AND    Wait Until Page Contains     All Import History    10

Validate Manage Inventory Items menu
    [Arguments]    ${isList of Items}
    Click side bar
    Element Text Should Be    ${ManageInventoryItems_locator}    Manage Inventory Items
    Click Element    ${ManageInventoryItems_locator}
    Run Keyword If    '${isList of Items}'=='true'    Run Keywords    Element Text Should Be    ${ManageInventoryItems_ListofItems_locator}    List of Items
    ...    AND    Click Element    ${ManageInventoryItems_ListofItems_locator}
    ...    AND    URL should be    /inventory/product/
    ...    AND    Wait Until Page Contains    Manage Inventory Items    10

Validate Manage Purchase Orders menu
    [Arguments]    ${isList of Purchase Orders}
    Click side bar
    Element Text Should Be    ${ManagePurchaseOrders_locator}    Manage Purchase Orders
    Click Element    ${ManagePurchaseOrders_locator}
    Run Keyword If    '${isList of Purchase Orders}'=='true'    Run Keywords    Element Text Should Be    ${ManagePurchaseOrders_ListOfPurchaseOrders_locator}    List of Purchase Orders
    ...    AND    Click Element    ${ManagePurchaseOrders_ListOfPurchaseOrders_locator}
    ...    AND    URL should be    /purchaseorder/
    ...    AND    Wait Until Page Contains    List of Purchase Orders    10

Validate Manage Item Receipt menu
    [Arguments]    ${isBatch Process Item Receipts}
    Click side bar
    Element Text Should Be    ${ManageItemReceipts_locator}    Manage Item Receipt
    Click Element    ${ManageItemReceipts_locator}
    Run Keyword If    '${isBatch Process Item Receipts}'=='true'    Run Keywords    Element Text Should Be    ${ManageItemReceipts_BatchProcessItemReceipts}    Batch Process Item Receipts
    ...    AND    Click Element    ${ManageItemReceipts_BatchProcessItemReceipts}
    ...    AND    URL should be    /itemreceipt/import/
    ...    AND    Wait Until Page Contains    Batch process Item Receipt    10

Validate Manage Sales Orders
    [Arguments]    ${isList of Sales Orders}    ${isList of Backorders}    ${isPicking and QC}    ${isPacking}    ${isPrint Fulfillment Doc}
    Click side bar
    Element Text Should Be    ${ManageSalesOrders_locator}    Manage Sales Orders
    Click Element    ${ManageSalesOrders_locator}
    Run Keyword If    '${isList of Sales Orders}'=='true'    Run Keywords    Element Text Should Be    ${ManageSalesOrders_ListofSalesOrders_locator}    List of Sales Orders
    ...    AND    Click Element    ${ManageSalesOrders_ListofSalesOrders_locator}
    ...    AND    URL should be    /shipping/order/
    ...    AND    Wait Until Page Contains    Manage Sales Orders    10
    Run Keyword If    '${isList of Backorders}'=='true'    Run Keywords    Element Text Should Be    ${ManageSalesOrders_ListofBackorders_locator}    List of Backorders
    ...    AND    Click Element    ${ManageSalesOrders_ListofBackorders_locator}
    ...    AND    URL should be    /shipping/backorder/
    ...    AND    Wait Until Page Contains    Backorder Report    10
    Run Keyword If    '${isPicking and QC}'=='true'    Run Keywords    Element Text Should Be    ${ManageSalesOrders_PickingandQC_locator}    Picking & QC
    ...    AND    Click Element    ${ManageSalesOrders_PickingandQC_locator}
    ...    AND    URL should be    /picking/qc/
    ...    AND    Wait Until Page Contains    Input/Scan Item Fulfillment No.    10
    ...    AND    Click Element    css=#input_picking_slip_popup > div.modal-header > a
    Run Keyword If    '${isPacking}'=='true'    Run Keywords    Element Text Should Be    ${ManageSalesOrders_Packing_locator}    Packing
    ...    AND    Click Element    ${ManageSalesOrders_Packing_locator}
    ...    AND    URL should be    /picking/picking/
    ...    AND    Wait Until Page Contains    Fulfillment Process    10
    Run Keyword If    '${isPrint Fulfillment Doc}'=='true'    Run Keywords    Element Text Should Be    ${ManageSalesOrders_PrintFulfillmentDoc_locator}    Print Fulfillment Doc.
    ...    AND    Click Element    ${ManageSalesOrders_PrintFulfillmentDoc_locator}
    ...    AND    URL should be    /printfulfilldoc/
    ...    AND    Wait Until Page Contains    Fulfillment Document    10

Validate Manage Fulfillments
    [Arguments]    ${isList of Fulfillments}
    Click side bar
    Element Text Should Be    ${ManageFulfillments_locator}    Manage Fulfillments
    Click Element    ${ManageFulfillments_locator}
    Run Keyword If    '${isList of Fulfillments}'=='test'    Run Keywords    Element Text Should Be    ${ManageFulfillments_ListofFulfillments_locator}    List of Fulfillments
    ...    AND    Click Element    ${ManageFulfillments_ListofFulfillments_locator}
    ...    AND    URL should be    /itemfulfillment/
    ...    AND    Wait Until Page Contains    Manage Item Fulfillments    10

Validate Import/Export menu
    [Arguments]    ${isImport Failed}    ${isTransaction Import History (History)}
    Click side bar
    Element Text Should Be    ${Import/Export_locator}    Import/Export
    Click Element    ${Import/Export_locator}
    Run Keyword If    '${isImport Failed}'=='true'    Run Keywords    Element Text Should Be    ${Import/Export_ImportFailed_locator}    Import Failed
    ...    AND    Click Element    ${Import/Export_ImportFailed_locator}
    ...    AND    URL should be    /shipping/fail/
    ...    AND    Wait Until Page Contains    (Show all shipping order failed transaction)    10
    Run Keyword If    '${isTransaction Import History (History)}'=='true'    Run Keywords    Element Text Should Be    ${Import/Export_TransactionImportHistory_locator}    Transaction Import History
    ...    AND    Click Element    ${Import/Export_TransactionImportHistory_locator}
    ...    AND    URL should be    /dataFlow/history/
    ...    AND    Wait Until Page Contains    (This page for show all files on import partner)    10

Validate Report menu
    [Arguments]    ${isPending Fulfillment Report}
    Click side bar
    Element Text Should Be    ${Report_locator}    Report
    Click Element    ${Report_locator}
    Run Keyword If    '${isPending Fulfillment Report}'=='true'    Run Keywords    Element Text Should Be    ${Report_PendingFulfillmentReport_locator}    Pending Fulfillment Report
    ...    AND    Click Element    ${Report_PendingFulfillmentReport_locator}
    ...    AND    URL should be    /report/pendingfulfillReport/
    ...    AND    Wait Until Page Contains    (Show Pending Fulfillment report)    10

Validate Manage Partners menu
    [Arguments]    ${isList of Partners}
    Click side bar
    Element Text Should Be    ${ManagePartners_locator}    Manage Partners
    Click Element    ${ManagePartners_locator}
    Run Keyword If    '${isList of Partners}'=='true'    Run Keywords    Element Text Should Be    ${ManagePartners_ListofPartners_locator}    List of Partners
    ...    AND    Click Element    ${ManagePartners_ListofPartners_locator}
    ...    AND    URL should be    /partner/
    ...    AND    Wait Until Page Contains    (Show all partners managment)    10

Validate System Configuration menu
    [Arguments]    ${isSetup Payment Types}    ${isSetup Shipping Types}    ${isSetup Netsuite Library}    ${isNetsuite Re-Synchronization}
    Click side bar
    Element Text Should Be    ${SystemConfigurations_locator}    System Configuration
    Click Element    ${SystemConfigurations_locator}
    Run Keyword If    '${isSetup Payment Types}'=='true'    Run Keywords    Element Text Should Be    ${SystemConfigurations_SetupPaymentTypes_locator}    Setup Payment Types
    ...    AND    Click Element    ${SystemConfigurations_SetupPaymentTypes_locator}
    ...    AND    URL should be    /payment/payment/
    ...    AND    Wait Until Page Contains    ( Show all Payment Type)    10
    Run Keyword If    '${isSetup Shipping Types}'=='true'    Run Keywords    Element Text Should Be    ${SystemConfigurations_SetupShippingTypes_locator}    Setup Shipping Types
    ...    AND    Click Element    ${SystemConfigurations_SetupShippingTypes_locator}
    ...    AND    URL should be    /shipping/type/
    ...    AND    Wait Until Page Contains    ( Show all Shipping Type)    10
    Run Keyword If    '${isSetup Netsuite Library}'=='true'    Run Keywords    Element Text Should Be    ${SystemConfigurations_SetupNetsuiteLibrary_locator}    Setup NetSuite Library
    ...    AND    Click Element    ${SystemConfigurations_SetupNetsuiteLibrary_locator}
    ...    AND    URL should be    /netsuitelibrary/netsuiteLibrary/
    ...    AND    Wait Until Page Contains    ( Show all Netsuite Library)    10
    Run Keyword If    '${isNetsuite Re-Synchronization}'=='true'    Run Keywords    Element Text Should Be    ${NetsuiteRe-Synchronization_locator}    NetSuite Re-Synchronization
    ...    AND    Click Element    ${NetsuiteRe-Synchronization_locator}
    ...    AND    URL should be    /netsuiteintegrationlog/
    ...    AND    Wait Until Page Contains    ( Show all failed transactions)    10

Is services accessible
    [Arguments]    ${is_accessible}    ${nav_bar_locator}    ${expected_url}
    Wait Until Page Contains
