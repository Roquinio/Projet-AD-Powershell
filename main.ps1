<#Projet AD - Scipt - Powershell#>
<#Purpose : Création d'un script automatisant la création d'utilisateurs, de groupes et d'OU à travers un menu contextuel#>
<#Code by : Baptiste ROQUES 3SRC2#>

Write-Host "
-------------------------------------------------------------------------
|  __ \     | |         | |       | |                     (_)     | |  
| |  | | ___| |__  _   _| |_    __| |_   _   ___  ___ _ __ _ _ __ | |_ 
| |  | |/ _ \ '_ \| | | | __|  / _` | | | | / __|/ __| '__| | '_ \| __|
| |__| |  __/ |_) | |_| | |_  | (_| | |_| | \__ \ (__| |  | | |_) | |_ 
|_____/ \___|_.__/ \__,_|\__|  \__,_|\__,_| |___/\___|_|  |_| .__/ \__|
                                                            | |        
                                                            |_|        
-------------------------------------------------------------------------
"


Write-Host "Ce script a pour but la créations d'objet dans la base Active Directory : 
1. Creations d'utilisateur.
2. Creations d'un groupe.
3. Creations d'une OU.
"

$choiseUsers = Read-Host -Prompt "Saisissez votre choix :"


