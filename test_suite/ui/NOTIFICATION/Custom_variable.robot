*** Settings ***
Documentation     PLAT-362 [Consumer Notification] Email/SMS Notification Services
...               Handle custom variable
Resource          resource/global_resource_selenium.robot
Resource          resource/global_resource_api.robot
# Suite Setup       Configure Partner Template      65    IN_TRANSIT   shipping_status_in_transit    Your order has been shipped {{partner_order_id}}   Email Only
# Suite Teardown    Logout and close browser
Suite Setup         Run Keywords
...                 Enable Test Mode   AND
...                 Configure Partner Template     65   IN_TRANSIT   shipping_status_in_transit_ph  Your order {{partner_order_id}} is in_transit   Email And Sms
Suite Teardown      Run Keywords
...                 Sleep  20s      AND
...                 Disable Test Mode

*** Variables ***
${domain}            ${noti_dev}

*** Test Cases ***
TC001 Event is IN_TRANSIT and all variable are null
  [tags]  var
  Make Notification request body with null for all variables   65    IN_TRANSIT   yes    yes
  POST Consumer Notification with custom variable    65    IN_TRANSIT    201 Created

TC002 Event is IN_TRANSIT and have empty variable
  [tags]  var
  Make Notification request body with variable is null   65    IN_TRANSIT   yes    yes
  POST Consumer Notification with custom variable    65    IN_TRANSIT    400 Bad Request

TC003 Event is IN_TRANSIT and without variable
  [tags]  var
  Make Notification request body without variable   65    IN_TRANSIT   yes    yes
  POST Consumer Notification with custom variable    65    IN_TRANSIT    201 Created

TC004 Event is IN_TRANSIT and all variable are ""
  [tags]  var
  Make Notification request body with blank string   65    IN_TRANSIT   yes    yes
  POST Consumer Notification with custom variable    65    IN_TRANSIT    201 Created

TC005 Event is IN_TRANSIT and variable is ""
  [tags]  var
  Make Notification request body with variable is ""  65    IN_TRANSIT   yes    yes
  POST Consumer Notification with custom variable    65    IN_TRANSIT    400 Bad Request

TC006 Event is IN_TRANSIT and in_transit date format is 2017/02/01 12:59:59 GMT+7
  [tags]  datetime
  Make Notification request body with other date format  65    IN_TRANSIT   yes    yes  2017/02/01 12:59:59 GMT+7
  POST Consumer Notification with custom variable    65    IN_TRANSIT    201 Created

TC007 Event is IN_TRANSIT and in_transit date format is 2017-02-01
  [tags]  datetime
  Make Notification request body with other date format  65    IN_TRANSIT   yes    yes  2017-02-01
  POST Consumer Notification with custom variable    65    IN_TRANSIT    201 Created

TC008 Event is IN_TRANSIT and in_transit date format is 02-Feb-2017 12.59.59 UTC
  [tags]  datetime
  Make Notification request body with other date format  65    IN_TRANSIT   yes    yes  02-Feb-2017 12.59.59 UTC
  POST Consumer Notification with custom variable    65    IN_TRANSIT    201 Created

TC009 Event is IN_TRANSIT and in_transit date format is Wed Feb 01 2017 12:59:59 GMT-1000
  [tags]  datetime
  Make Notification request body with other date format  65    IN_TRANSIT   yes    yes  Wed Feb 01 2017 12:59:59 GMT-1000
  POST Consumer Notification with custom variable    65    IN_TRANSIT    201 Created

TC010 Event is IN_TRANSIT and in_transit date format is 2014-01-01T23:28:56.782Z
  [tags]  datetime
  Make Notification request body with other date format  65    IN_TRANSIT   yes    yes  2014-01-01T23:28:56.782Z
  POST Consumer Notification with custom variable    65    IN_TRANSIT    201 Created

TC011 Event is IN_TRANSIT and in_transit date format is 20.01.2017 12.59.59
  [tags]  datetime
  Make Notification request body with other date format  65    IN_TRANSIT   yes    yes  20.01.2017 12.59.59
  POST Consumer Notification with custom variable    65    IN_TRANSIT    201 Created
