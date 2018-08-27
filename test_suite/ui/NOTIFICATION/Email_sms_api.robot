*** Settings ***
Documentation       PLAT-684 [Consumer Notification] notification endpoint supports empty email and phone input
Resource            resource/global_resource_selenium.robot
Resource            resource/global_resource_api.robot
# Suite Setup         Run Keywords
# ...                 Enable Test Mode   AND
# ...                 Configure Partner Template     65   IN_TRANSIT   shipping_status_in_transit_ph  Your order {{partner_order_id}} is in_transit   Email And Sms
# Suite Teardown      Run Keywords
# ...                 Sleep  20s      AND
# ...                 Disable Test Mode

*** Variables ***
${domain}            ${noti_dev}

*** Test Cases ***
TC004 got 400 Bad Request when recipientPhone contains no (+)
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    66839919341    400 Bad Request

TC005 got 400 Bad Request when recipientPhone contains any prefix text
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    abc+66839919341    400 Bad Request

TC006 got 400 Bad Request when recipientPhone contains any prefix number
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    +668+66839919341    400 Bad Request

TC007 got 400 Bad Request when recipientPhone contains no country code
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    0801111111    400 Bad Request

TC008 got 400 Bad Request when recipientPhone contains multiple phone no
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    +6689011011,+6689810111   400 Bad Request

TC009 got 201 Created when recipientPhone contains long length phone number (14 characters)
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    +6689011011111101   201 Created

TC010 got 400 Bad Request when recipientPhone contains over length phone number (15 characters)
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    +66890110111111011   400 Bad Request

TC011 got 400 Bad Request when recipientPhone contains -characters
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    -66800110111   400 Bad Request

TC012 got 400 Bad Request when recipientPhone contains ++ characters
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes    ++66800110111   400 Bad Request

TC015 got 400 Bad Request when recipientEmail contains multiple email address
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     abc.a@abcdefg.com,abe.b@abcdefg.com    yes   400 Bad Request

TC016 got 400 Bad Request when recipientEmail contains incorrect format email address
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     abc#abcedfg..  yes   400 Bad Request

TC017 got 400 Bad Request when recipientEmail contains variable
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     {{partner.servicesSettings.CUSTOMER_SERVICE.email}}  yes   400 Bad Request

TC018 got 400 Bad Request when recipientPhone contains variable
  [Tags]  Email and Sms
  POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes  {{partner.servicesSettings.CUSTOMER_SERVICE.phone}}   400 Bad Request

# TC000 got 201 Created when recipientEmail and recipientPhone are valid
#   [Tags]  Email and Sms
#   POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes   yes   201 Created
#
# TC001 No "recipientEmail" even though notifyPreference is Email and Sms
#   [Tags]  Email and Sms
#   POST Consumer Notification with custom email and sms   65  IN_TRANSIT     no     yes    201 Created
#
# TC002 No "recipientSms" even though notifyPreference is Email and Sms
#   [Tags]  Email and Sms
#   POST Consumer Notification with custom email and sms     65  IN_TRANSIT     yes     no    201 Created
#
# TC003 no both recipientEmail and recipientPhone even though notifyPreference is Email and Sms
#   [Tags]  Email and Sms
#   POST Consumer Notification with custom email and sms    65  IN_TRANSIT     no     no    201 Created\
#
# TC013 got 400 Bad Request when recipientPhone contains empty
#   [Tags]  Email and Sms
#   POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes      ${EMPTY}   400 Bad Request
#
# TC014 got 400 Bad Request when recipientPhone contains null
#   [Tags]  Email and Sms
#   POST Consumer Notification with custom email and sms    65  IN_TRANSIT     yes      null   400 Bad Request
