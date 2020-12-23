<#Projet AD - Scipt - Powershell#>
<#Purpose : Création d'un script automatisant la modification d'objet de la base Active directory tel que la créations ou la suppression d'utilisateurs, de groupes et d'OU à travers un menu contextuel#>
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

function Get-Menu  {

    Write-Host "==================Menu=================="

    Write-Host "Que souhaitez-vous faire ?
     1. Faire un ajout dans la base Active Directory
     2. Modifier un objet de la base Active Directory
     3. Supprimer un objet de la base Active Directory
     4. Quitter le script"

    [int]$choiseMenus = Read-Host -Prompt "Saisissez votre choix "

    switch ($choiseMenus) {
        1 { Get-Ajout }
        2 { Get-Modif }
        3 { Get-Suppr }
        4 { Exit }
        Default { Write-Host "Erreur, veuillez réessayer"; Get-Menu }
    }
         
                
}

Get-Menu


function Get-Ajout {

    
    Write-Host "Ce script a pour but la créations d'objet dans la base Active Directory : 
    1. Creations d'utilisateur.
    2. Creations d'un groupe.
    3. Creations d'une unité d'organisation.
    4. Retourner au menu principal
    "

    [int]$choiseUsers = Read-Host -Prompt "Saisissez votre choix "

    switch ($choiseUsers) 
        {
        1 {  New-ADUser -Name (Read-Host -Prompt "Saisissez votre nom") -AccountPassword(Read-Host -AsSecureString "Choisissez votre mot de passe") -Path "CN=Users,DC=Force2,DC=net"  -Enabled $True }

        2 {  New-ADGroup -Name (Read-Host -Prompt "Saissez le nom du groupe") }
       
        3 {  New-ADOrganizationalUnit -Name (Read-Host -Prompt "Saisissez le nom de l'unité d'organisation") }

        4 {  until (Get-Menu) }

        Default { Write-Host "Erreur, veuillez réessayer"; Get-Ajout }
        }
    

}

