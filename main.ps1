<#Projet AD - Scipt - Powershell#>
<#Purpose : Création d'un script automatisant la création d'utilisateurs, de groupes et d'OU à travers un menu contextuel#>
<#Code by : Baptiste ROQUES 3SRC2#>



import-module ActiveDirectory


Write-Host "
--------------------------------------------------------------------------------
               _   _                 _ _               _                   
     /\       | | (_)               | (_)             | |                  
    /  \   ___| |_ ___   _____    __| |_ _ __ ___  ___| |_ ___  _ __ _   _ 
   / /\ \ / __| __| \ \ / / _ \  / _` | | '__/ _ \/ __| __/ _ \| '__| | | |
  / ____ \ (__| |_| |\ V /  __/ | (_| | | | |  __/ (__| || (_) | |  | |_| |
 /_/    \_\___|\__|_| \_/ \___|  \__,_|_|_|  \___|\___|\__\___/|_|   \__, |
                                                                      __/ |
                                                                     |___/ 

--------------------------------------------------------------------------------
"


Write-Host "Ce script a pour but la créations d'objet dans la base Active Directory : 
1. Creations d'utilisateur.
2. Creations d'un groupe.
3. Creations d'une OU.
"

$choiseUsers = Read-Host -Prompt "Saisissez votre choix "


