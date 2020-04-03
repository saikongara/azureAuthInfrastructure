resource "azurerm_monitor_action_group" "resource-action-group" {
  name                = "${var.action_group}"
  resource_group_name = "${data.azurerm_resource_group.resources-rg-persistent.name}"
  short_name          = "p0action"

  email_receiver {
    name          = "sendtoadmin"
    email_address = "${var.admin_email}"
  }

  email_receiver {
    name          = "sendtodevops"
    email_address = "${var.devops_email}"
  }

  sms_receiver {
    name         = "oncallmsg"
    country_code = "1"
    phone_number = "${var.oncall_msg}"
  }

//  webhook_receiver {
//    name        = "callmyapiaswell"
//    service_uri = "http://example.com/alert"
//  }
}