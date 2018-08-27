*** Settings ***
Documentation     PLAT-362 [Consumer Notification] Email/SMS Notification Services
...               PLAT-630 [Consumer Notification] Automation Testing for Consumer Notification
...               To verified that consumer notification is working to create Emails and Sms(s)
...               from Private API. And also confirm that there will be no impact because of code updated.
Resource          resource/global_resource_selenium.robot
Resource          resource/global_resource_api.robot
Suite Setup         Enable Test Mode
Suite Teardown      Run Keywords
...                 Sleep  20s      AND
...                 Disable Test Mode

*** Variables ***
${domain}            ${noti_dev}

*** Test Cases ***
TC001 Event is IN_TRANSIT and to be Notified by Email Only
  #                              PartnerId   Event        Pre-defined template           Sms msg                                              notify preference
  Configure Partner Template     65          IN_TRANSIT    shipping_status_in_transit     Your order has been shipped {{partner_order_id}}   Email Only
  POST Consumer Notification     65          IN_TRANSIT     yes        yes
  # Sleep  30s
  # Confirm Notification Sent successfully

TC002 Event is IN_TRANSIT and to be Notified by Sms Only
  Configure Partner Template     65          IN_TRANSIT    shipping_status_in_transit_ph  Your order has been shipped {{partner_order_id}}   Sms Only
  POST Consumer Notification     65          IN_TRANSIT     yes        yes

TC003 Event is IN_TRANSIT and to be Notified by Email And Sms
  Configure Partner Template     65          IN_TRANSIT    intransit_email_AIS       Your order has been shipped {{partner_order_id}}   Email And Sms
  POST Consumer Notification     65          IN_TRANSIT     yes        yes

TC004 Event is IN_TRANSIT and to be Notified by Email Over Sms
  Configure Partner Template     65          IN_TRANSIT    Intransit_email_CNS_philippines  Your order has been shipped {{partner_order_id}}   Email Over Sms
  POST Consumer Notification     65          IN_TRANSIT     yes        yes

TC005 Event is IN_TRANSIT and to be Notified by Email Over Sms but no Email
  Configure Partner Template     65          IN_TRANSIT    shipping_status_in_delivered_ph  Your order has been shipped {{partner_order_id}}  Email Over Sms
  POST Consumer Notification with error status     65      IN_TRANSIT     yes     yes    201 Created

TC006 Event is CANCELLED and to be Notified by Sms Over Email
  Configure Partner Template     65          CANCELLED    shipping_status_cancelled_ph       Your order {{partner_order_id}} has been cancelled   Sms Over Email
  POST Consumer Notification     65          CANCELLED    yes     yes

TC007 Event is REJECTED and to be Notified by Sms Over Email but no Sms
  Configure Partner Template     65          REJECTED    shipping_status_rejected_ph         Your order {{partner_order_id}} has been cancelled   Sms Over Email
  POST Consumer Notification with error status     65       REJECTED   yes     no    201 Created

TC008 Event is custom event and to be notified by Email Only
  Configure Partner Template     65          PREPARING_DELIVERY    shipping_status_in_transit_ph  Your order {{partner_order_id}} has been cancelled   Email Only
  POST Consumer Notification     65          PREPARING_DELIVERY    yes   yes

#--- Mandatory fields in HTTP Request -----
TC009 Case sensitive checking for Event is IN_TRANSIT in HTTP request
  Configure Partner Template     65          IN_TRANSIT     shipping_status_in_transit_ph  Your order {{partner_order_id}} has been cancelled   Email Only
  POST Consumer Notification with error status     65          In_transit     yes     yes    400 Bad Request

TC010 No partner template configured for new partner
  Login Notification Admin
  POST Consumer Notification with error status     9999          IN_TRANSIT     yes     yes    400 Bad Request

TC011 No "partner" field in HTTP request
  Configure Partner Template     65          IN_TRANSIT     shipping_status_in_transit_ph  Your order {{partner_order_id}} has been cancelled   Email Only
  POST Consumer Notification with error status     no          IN_TRANSIT      yes     yes    400 Bad Request

TC012 No "event" field in HTTP request
  Configure Partner Template     65          IN_TRANSIT     shipping_status_in_transit_ph  Your order {{partner_order_id}} has been cancelled   Email Only
  POST Consumer Notification with error status     65          no     yes     yes    400 Bad Request

TC013 partner field is empty string [""]
  Configure Partner Template     65          IN_TRANSIT     intransit_email_AIS   Your order {{partner_order_id}} has been cancelled   Email And Sms
  POST Consumer Notification with error status     ${EMPTY}     IN_TRANSIT     yes     yes    400 Bad Request

TC014 event field is empty string [""]
  Configure Partner Template     65          IN_TRANSIT     intransit_email_AIS   Your order has been shipped {{partner_order_id}}    Email And Sms
  POST Consumer Notification with error status     65    ${EMPTY}     yes     yes    400 Bad Request

# To be improved
# Setup
#  Clean up Partner Template    65          CANCELLED    shipping_status_cancelled_ph  Your order {{partner_order_id}} has been cancelled   Email Only
