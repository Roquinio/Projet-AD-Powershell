<#Projet AD - Scipt - Powershell#>
<#Purpose : Création d'un script automatisant la création d'utilisateurs, de groupes et d'OU à travers un menu contextuel#>
<#Code by : Baptiste ROQUES 3SRC2#>





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

function Get-Ajout {

Write-Host "Ce script a pour but la créations d'objet dans la base Active Directory : 
1. Creations d'utilisateur.
2. Creations d'un groupe.
3. Creations d'une OU.
"

[int]$choiseUsers = Read-Host -Prompt "Saisissez votre choix "

if ( $choiseUsers == 1 )
    {

        New-ADUser -Name (Read-Host -Prompt "Saisissez votre nom") -AccountPassword(Read-Host -AsSecureString "Choisissez votre mot de passe") -Path "CN=Users,DC=Force2,DC=net"  -Enabled $True 
    } 

if ( $choiseUsers == 2 )
    {
        New-ADGroup -Name (Read-Host -Prompt "Saissez le nom du groupe") 
    }

if ( $choiseUsers == 3 )
    {
        New-ADOrganizationalUnit -Name (Read-Host -Prompt "Saisissez le nom de l'unité d'organisation") 
    }

}

Get-Ajout

