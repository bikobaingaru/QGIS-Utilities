# AZURE VM CONFIGURATION

DESCRIPTION     | VALUE
--------------- | --------------
Computer name   | kiwash
Disk type       | HDD
User name       | kiwash
Size            | Standard D1 v2 (1 vcpu, 3.5 GB memory)
Managed         | Yes
Virtual network | (new) kiwashGIS-vnet
Subnet          | (new) default (62.12.115.0/24)
Public IP address   | (new) kiwash-ip - 52.169.22.56
Network security group (firewall)   | (new) kiwash-nsg
Availability set    | None
Guest OS diagnostics    | Enabled
Boot diagnostics    | Enabled
Diagnostics storage account | kiwashgis
Auto-shutdown   | off
Backup  | Disabled
DNS name | kiwashgis.northeurope.cloudapp.azure.com