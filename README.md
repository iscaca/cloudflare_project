# cloudflare_project
Cloudflare_API_Token
Set up an Azure Key Vault: First, you'll need to set up an Azure Key Vault to store your Cloudflare API token securely. You can follow Microsoft's documentation on creating an Azure Key Vault if you haven't done this before.

Add the Cloudflare API token to the Azure Key Vault: Once you have set up the Azure Key Vault, you can add your Cloudflare API token to it. Make sure to give the token a clear and identifiable name.

Configure the Azure DevOps pipeline to authenticate with Azure Key Vault: In order to access the Cloudflare API token stored in the Azure Key Vault, you need to configure the Azure DevOps pipeline to authenticate with the Azure Key Vault. You can do this by creating an Azure Resource Manager service connection in Azure DevOps that uses a service principal with access to the Azure Key Vault.

Use the Azure Key Vault task in the Azure DevOps pipeline: Once you have set up the service connection, you can use the Azure Key Vault task in the Azure DevOps pipeline to retrieve the Cloudflare API token from the Azure Key Vault. You can store the token in a pipeline variable or use it directly in a script task.

Call the Cloudflare API using the token: With the token now available in the pipeline, you can use it to authenticate your requests to the Cloudflare API.
----------------------------

variables:
  # Name of the Azure Key Vault where the Cloudflare API token is stored
  keyVaultName: '<your-key-vault-name>'
  # Name of the Cloudflare API token in the Azure Key Vault
  secretName: '<your-secret-name>'
  # Azure Resource Manager service connection name
  serviceConnectionName: '<your-service-connection-name>'

steps:
  - task: AzureKeyVault@2
    inputs:
      azureSubscription: '$(serviceConnectionName)'
      keyVaultName: '$(keyVaultName)'
      secretsFilter: '$(secretName)'
  - task: Bash@3
    inputs:
      targetType: 'inline'
      script: |
        # Set the Cloudflare API token as an environment variable
        export CLOUDFLARE_API_TOKEN=$(cat $(secretName))
        # Make a request to the Cloudflare API
        curl -X GET "https://api.cloudflare.com/client/v4/zones" \
          -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN"