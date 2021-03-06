*** Settings ***
Documentation               Global Variable for integration

*** Variables ***
#-------------- End point ------------------#
${TEST_ENV}                 integration
${ORDER_STORE_URL}          order-store-qa.acommercedev.service
${IMS_URL}                  inventory-qa.acommercedev.service
${ITEM_MASTER_URL}          item-master-qa.acommercedev.service
#-------------- Submission Path ------------------#
# Item-master
${ITEM_MASTER_PATH}          /im/partner/<CONFIG_PARTNER_ID>/item-masters-submission-form/
${ITEM_SERVICE_PATH}         /im/partner/<CONFIG_PARTNER_ID>/item-services-submission-form/
${ITEM_DISCOUNT_PATH}        /im/partner/<CONFIG_PARTNER_ID>/item-discounts-submission-form/
${SUPPLIER_PATH}             /im/partner/<CONFIG_PARTNER_ID>/suppliers-submission-form/
# Order Store
${PURCHASE_ORDER_PATH}                    /os/partner/<CONFIG_PARTNER_ID>/submit-purchase-orders/
${SALES_ORDER_PATH}                       /os/partner/<CONFIG_PARTNER_ID>/submit-purchase-orders/
${ITEM_SALES_ORDER_PATH}                  /os/item-sales-orders/
${ISO_NON_GL_PATH}                        /os/partner/<CONFIG_PARTNER_ID>/so-frontend/<SO_KEY>/update-nongl/
${CANCEL_ITEM_SALES_ORDER_PATH}           /os/item-sales-orders/<SO_KEY>/cancel/
${RMA_URL}                                /os/fo/<FO_KEY>/rma/
${GRN_URL}                                /os/rma/<RMA_KEY>/grn/
#-------------- Get API --------------------#
# Item-master
${ITEM_MASTER_API}          /im/partner/<CONFIG_PARTNER_ID>/item-masters/<PARTNER_ITEM_ID>/
${ITEM_SERVICE_API}         ${ITEM_MASTER_URL}/im/partner/<CONFIG_PARTNER_ID>/item-services/<PARTNER_ITEM_ID>
${ITEM_DISCOUNT_API}        ${ITEM_MASTER_URL}/im/partner/<CONFIG_PARTNER_ID>/item-discounts/<PARTNER_ITEM_ID>
# Order Store
${PURCHASE_ORDER_API}       /os/purchase-orders/<PO_KEY>/?format=json

#-------------- HTTP Request header --------#
${X_USER_NAME}              bh-qa-automation
${CONTENT_TYPE}             application/json
${X_ROLES_SC_TH}            bo_4086
#-------------- Partner List --------#
${PARTNER_NAME_SC_TH}       BH_SCALE_AUTOMATION_TH_QA
${PARTNER_SLUG_SC_TH}       4086-btq-th
${PARTNER_ID_SC_TH}         4086
${PARTNER_PREFIX_SC_TH}     BTQ

#-------------- Purchase Order Tax ID --#
${TAX_RATE_TH}              7

#-------------- Warehouse Code ------#
${WAREHOUSE_CODE_SC_TH}     TH-BH-SCALE

#-------------- Shipping Type -------#
${SHIPPING_TYPE_STANDARD_2_4_DAYS}        STANDARD_2_4_DAYS
${SHIPPING_TYPE_SAME_DAY}                 SAME_DAY
${SHIPPING_TYPE_NEXT_DAY}                 NEXT_DAY
${SHIPPING_TYPE_EXPRESS_1_2_DAYS}         EXPRESS_1_2_DAYS
${SHIPPING_TYPE_NATIONWIDE_3_5_DAYS}      NATIONWIDE_3_5_DAYS
${SHIPPING_TYPE_INTERNATIONAL_ECONOMY}    INTERNATIONAL_ECONOMY
${SHIPPING_TYPE_INTERNATIONAL_STANDARD}   INTERNATIONAL_STANDARD
${SHIPPING_TYPE_INTERNATIONAL_EXPRESS}    INTERNATIONAL_EXPRESS
${SHIPPING_TYPE_NO_SHIPPING}              NO_SHIPPING

#--------------- Payment TYpe --------#
${PAYMENT_TYPE_COD}          COD
${PAYMENT_TYPE_CCOD}         CCOD
${PAYMENT_TYPE_NON_CODE}     NON_COD

#-------------- Admin Portal --------#
${ADMIN_LOGIN_NAME}          qa_admin
${ADMIN_PASSWORD}            Acomm1234!
${ADMIN_URL}                 http://admintest.acommercedev.com

#-------------- NS --------#
${USERNAME_NS}               nattapol.wilarat@acommerce.asia
${PASSWORD_NS}               JackHandsome123!
${NS_URL}                    https://system.sandbox.netsuite.com/pages/customerlogin.jsp

#-------------- Beehive Frontend ----#
${SO_URL}                    ${ADMIN_URL}/beehive/frontend/ui-sales-order
${INVENTORY_URL}             ${ADMIN_URL}/beehive/frontend/ui-inventory

#-------------- Test Data path ------#
${SO_TEST_DATA}              test_suite/sales_order/test_data
${ITEM_TEST_DATA}            test_suite/item_master/test_data

#-------------- Supplier Information --------#
${SUPPLIER_CODE_SC_TH}        BH_SCALE_AUTOMATION_TH_QA
${SUPPLIER_KEY_SC_TH}         HDTXIB48R771OZ8KSETDNSO71

#-------------- Error code ------------------#
${STATUS_200}                 200 OK
${STATUS_201}                 201 Created
${STATUS_400}                 400 Bad Request

#-------------- Static string ---------------#
${COMMA}                      ,

#-------------- Order Store MongoDB ---------------------#
${MONGO_DB_HOST}                  dev-mongo-1a-0.acommercedev.platform
${ORDER_STORE_MONGO_HOST}         ${MONGO_DB_HOST}
${ORDER_STORE_MONGO_PORT}         27017
${ORDER_STORE_MONGO_DB_NAME}      bh_order_store_db_qa
${ORDER_STORE_MONGO_USER}         bh_order_store_user
${ORDER_STORE_MONGO_PASSWORD}     48UWUv#$x
${ORDER_STORE_MONGO_AUTH_SOURCE}  admin
${SALES_ORDER_COLLECTION}         sales_order
${FULFILLMENT_ORDER_COLLECTION}   fulfillment_order

#-------------- Item Master MongoDB ---------------------#
${ITEM_MASTER_MONGO_HOST}         ${MONGO_DB_HOST}
${ITEM_MASTER_MONGO_PORT}         27017
${ITEM_MASTER_MONGO_DB_NAME}      itemmaster_service_qa
${ITEM_MASTER_MONGO_USER}         itemmaster_service
${ITEM_MASTER_MONGO_PASSWORD}     itemmaster_service
${ITEM_MASTER_MONGO_AUTH_SOURCE}  admin
${ITEM_MASTER_COLLECTION}         item_master

#-------------- Postgres DB -----------------#
${RDS_HOST}                       inventorydb.acommercedev.platform
${IMS_DB_HOST}                    ${RDS_HOST}
${IMS_DB_PORT}                    5432
${IMS_DB_NAME}                    inventorydb_qa
${IMS_DB_USER}                    inventorydev
${IMS_DB_PASSWORD}                TJ8wgV63qw

#-------------- Rabbit MQ -------------------#
${AMQP_HOST}                       queue-common.acommercedev.service
${AMQP_PORT}                       5672
${AMQP_USERNAME}                   beehive
${AMQP_PASSWORD}                   8lsd29Sgr19350
${VHOST_SALES_ORDER}               common-qa
${VHOST_SCALEBRIDGE}               ScaleBridge-qa

#-------------- Queue name ------------------#
# Exchange: order
${QUEUE_ORDER_ITEM_SALES_ORDER}             robot.order.item_sales_order
${QUEUE_ORDER_FULFILLMENT_ORDER}            robot.order.fulfillment_order
# Exchange: status
${QUEUE_STATUSV2_ORDER_ITEMSALESORDER}        robot.status.order.itemsalesorder
${QUEUE_STATUSV2_ORDER_FULFILLMENT_ORDER}     robot.status.order.fulfillment
# Exchange: bh-order-status
${QUEUE_STATUSV3_ORDER_ITEMSALESORDER}        robot.bh-order-status.order.item_sales_order
${QUEUE_STATUSV3_ORDER_FULFILLMENT_ORDER}     robot.bh-order-status.order.fulfillment_order

#-------------- Default Standing data ----------------#
${headerPublisherId}      beehive-order-store
${salesChannelId}         Company Website
${paymentType}            COD
${shippingType}           STANDARD_2_4_DAYS
${warehouseCode}          TH-BH-SCALE

#-------------- Standing data ------------------------#
${PARTNER_ITEM_ID_TH}     ITEM_GENERAL_20180307174034   

#-------------- Cancel ------------------------#
${REASON}                 Duplicate Delivery    
${REASON_CODE}            A05   