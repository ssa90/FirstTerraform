resource "azurerm_function_app" "example" {
  name                       = "func-wus-first-func"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  app_service_plan_id        = azurerm_app_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  version                    = "~2"
  app_settings = {
    HASH                     = "${base64sha256("./FirstFunc.zip")}"
    WEBSITE_RUN_FROM_PACKAGE = "https://${azurerm_storage_account.example.name}.blob.core.windows.net/${azurerm_storage_container.example.name}/${azurerm_storage_blob.example.name}${data.azurerm_storage_account_sas.example.sas}"
    FUNCTION_APP_EDIT_MODE   = "readwrite"
    first_func_secret   = azurerm_key_vault_secret.first_func_secret.value   // "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.example.name};SecretName=${azurerm_key_vault_secret.first_func_secret.name})"   //azurerm_key_vault_secret.first_func_secret.value
  }
  identity {
    type = "SystemAssigned"
  }
}
