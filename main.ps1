<#Projet AD - Script - Powershell#>
<#Purpose : Création d'un script automatisant la modification d'objet de la base Active directory tel que :
            la créations la suppression d'utilisateurs, de groupes et d'OU à travers un menu contextuel.  #>
<#Coded by : Baptiste ROQUES 3SRC2#>


<#  Ajouter un check de la base Active Directory #>


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

import-module ActiveDirectory


function Main-AD {
    function show-Menu  {

    Write-Host "==================Menu=================="
    Write-Host ""
    Write-Host "Que souhaitez-vous faire ?
     1. Faire un ajout dans la base Active Directory
     2. Modifier un objet de la base Active Directory
     3. Supprimer un objet de la base Active Directory
     4. Quitter le script"

    [int]$choiseMenus = Read-Host -Prompt "Saisissez votre choix "

    switch ($choiseMenus) {
        1 { show-Ajout }
        2 { show-Modif }
        3 { show-Suppr }
        4 { Exit }
        Default { Write-Host "Erreur, veuillez réessayer"; show-Menu }
    }
         
                
    }

    function show-Ajout {

    
    Write-Host "==================Ajouter================== 
    1. Créations d'utilisateur.
    2. Créations d'un groupe.
    3. Créations d'une unité d'organisation.
    4. Retourner au menu principal
    "

    [int]$choiseUsers = Read-Host -Prompt "Saisissez votre choix "

    switch ($choiseUsers) 
        {
        1 {  New-ADUser -Name (Read-Host -Prompt "Saisissez votre nom") -AccountPassword(Read-Host -AsSecureString "Choisissez votre mot de passe") -Path "CN=Users,DC=Force2,DC=net"  -Enabled $True ;clear;Write-Host "L'utilisateur a été crée" ; show-Menu}

        2 {  New-ADGroup -Name (Read-Host -Prompt "Saissez le nom du groupe") ;clear;Write-Host "Le groupe a été crée" ; show-Menu }
       
        3 {  New-ADOrganizationalUnit -Name (Read-Host -Prompt "Saisissez le nom de l'unité d'organisation");clear;Write-Host "L'unité d'organisation a été crée"; show-Menu }

        4 { show-Menu }

        Default { Write-Host "Erreur, veuillez réessayer"; show-Ajout }
        }
    

    }


    function show-Modif {

    Write-Host "==================Modifications==================
    1. Modification d'un utilisateur.
    2. Modification d'un groupe.
    3. Retourner au menu principal
    "
    [int]$choiseModif = Read-Host -Prompt "Saisissez votre choix "

    switch ($choiseModif) 
        {
        1 { show-userModif }  

        2 { show-groupModif }
       
        3 { show-Menu }

        Default { Write-Host "Erreur, veuillez réessayer"; show-Modif }
        }
    

    }


    function show-Suppr {

    Write-Host "==================Supressions==================
    1. Supression d'un utilisateur.
    2. Supression d'un groupe.
    3. Supression d'une unité d'organisation.
    4. Retourner au menu principal
    "
    [int]$choiseSuppr = Read-Host -Prompt "Saisissez votre choix "

    switch ($choiseSuppr) 
        {
            
        1 { $userList=Read-Host -Prompt "Quel utilisateur souhaitez-vous supprimer ?"; Remove-ADUser -Identity $userList;clear;Write-Host "L'utilisateur a été supprimé";show-Menu }

        2 { $groupList=Read-Host -Prompt "Quel groupe souhaitez-vous supprimer ?";Remove-ADGroup -Identity $groupList;clear;Write-Host "Le groupe a été supprimé";show-Menu}
       
        3 { $orgList=Read-Host -Prompt "Quelle unité d'organisation souhaitez-vous supprimer ?";Remove-ADOrganizationalUnit -Identity $orgList -Recursive;Write-Host "L'unité d'organisation a été supprimé";show-Menu }

        4 { show-Menu }

        Default { Write-Host "Erreur, veuillez réessayer"; show-Suppr }
        }
    

    }

    function show-userModif {

    Write-Host "
    1. Modifier une valeur.
    2. Suprimer une valeur.
    3. Retourner au menu principal"
   
    [int]$modifArg = (Read-Host -Prompt "Que souhaitez-vous faire ?")

    switch ($modifArg) {
        1 { show-modifValeur }

        2 { show-supprValeur }

        3 { clear;show-Menu }

        Default { Write-Host "Erreur, veuillez réessayer"; show-userModif}
    }



    }

    function show-groupModif {

    $groupList=Read-Host -Prompt "Quel groupe souhaitez-vous modifier ?"

    Write-Host "==================Modifications==================
    1. Modifier le nom du groupe
    2. Changer l'étendue du groupe
    3. Changer la description du groupe
    "

    [int]$modifChoix = Read-Host -Prompt "Que souhaitez-vous modifier ?"


    switch ($modifChoix) {
        1 { Rename-ADObject -Identity $groupList -PassThru -NewName(Read-Host -Prompt "Saisissez le nouveau nom du groupe"); clear ;Write-Host "Le nom du groupe à été changer";show-Menu }
        2 { Set-ADGroup -Identity $groupList -GroupScope(Read-Host -Prompt "Saisissez la nouvelle étendue du groupe"); clear ;Write-Host "L'étendue du groupe à été changer";show-Menu } 
        3 { Set-ADGroup -Identity $groupList -Description(Read-Host -Prompt "Saissisez la nouvelle description du groupe"); clear ;Write-Host "La description du groupe à été changer";show-Menu }
        Default { Write-Host "Erreur, veuillez réessayer";show-groupModif }
    }
    }



    function show-modifValeur {

    $userList=Read-Host -Prompt "Quel utilisateur souhaitez-vous modifier ?"

    Get-ADUser -Filter 'name -like $userList' -SearchBase "CN=Users,DC=Force2,DC=net"


    Write-Host "==================Modifications==================
    1. Rejoindre un groupe.
    2. Changer le mot de passe.
    3. Retourner au menu principal
    "
    [int]$modifChoix = Read-Host -Prompt "Que souhaitez-vous modifier ?"
    
    switch ($modifChoix) {
        1 { Add-ADGroupMember -Identity (Read-Host -Prompt "Saisissez le nom du groupe:") -Members $userList ;clear;Write-Host "L'utilisateur a été changé de groupe";show-Menu} 
        2 { Set-ADAccountPassword -Identity $userList -Reset -NewPassword(Read-Host -AsSecureString -Prompt "Saisissez le nouveau mot de passe:");clear;Write-Host "Le mot de passe été changé !"; show-Menu} 
        3 { clear ;show-Menu } 
        Default { Write-Host "Erreur, veuillez réessayer"; show-modifValeur}

        }
    }


    show-Menu

     
 }

Main-AD