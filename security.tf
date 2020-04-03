resource "azurerm_security_center_contact" "resource-security-center-contact" {
  email = "${var.admin_email}"
  phone = "+1000-000-0000"

  alert_notifications = true
  alerts_to_admins    = true
}