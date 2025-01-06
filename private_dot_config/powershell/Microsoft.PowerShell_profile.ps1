function Load-Env {
  param(
    [string]$EnvFile
   )

  (Get-Content -Path $EnvFile -Encoding UTF8) -replace '"','' |
    ForEach-Object { $line = $_; $varName, $varValue = $line -split '=', 2;
                     [System.Environment]::SetEnvironmentVariable($varName, $varValue, [System.EnvironmentVariableTarget]::Process) }; $null
}

Function Set-Subscription {
    param(
        $Name,
        $TenantId = (Get-AzContext).Tenant.Id
    )
    $currentSub = Get-AzContext

    # Get subscriptions
    $Subscriptions = Get-AzSubscription -TenantId $TenantId -WarningAction Ignore | Where-Object name -Match $Name | Sort-Object -Property Name
    $Subs = @()

    # Add numbers to subscription
    $index = 0
    $Subscriptions | ForEach-Object {
        $obj = [PSCustomObject] @{ Number = $index; Name = $_.Name; Id = $_.id; TenantId = $_.TenantId; State = $_.State }
        $Subs += $obj
        $index++
    }
    # Choose subscription
    do {
        $Subs | Format-Table
        $select = Read-Host -Prompt 'Select a subscription'
        $ChosenSubscription = $Subs[$select]
    } until ($null -ne $ChosenSubscription)

    # Set the chosen subscription
    Set-AzContext -SubscriptionId $ChosenSubscription.Id -TenantId $ChosenSubscription.TenantId | Format-List -Property name, account, subscription, tenant
}

Function Find-Resources {
    param(
        $Name,
        $Type,
        $Id,
        [Switch]$FullDisplay
    )
    $query = "where name contains '$Name' | where type contains '$Type' | where id contains '$Id' | order by name desc"
    $result = Search-AzGraph -Query $query -UseTenantScope
    if ($FullDisplay) {
        Write-Output $result
    }
    else {
        Write-Output $result | Select name, resourceGroup, id, type, tags, properties
    }
}
if (!(Get-Alias findres -ErrorAction SilentlyContinue)) {
    New-Alias -Name findres -Value Find-Resources
}
