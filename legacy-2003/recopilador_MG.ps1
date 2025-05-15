Function recopiladorMG {
    Write-Host ""
    Write-Host "################################"
    Write-Host "#                              #"
    Write-Host "#  Bienvenido al Recopilador®  #"
    Write-Host "#    -Edición Modo Guiado-     #"
    Write-Host "#                              #"
    Write-Host "################################"
    Write-Host "#  Introduce Exit para salir   #"
    Write-Host "################################"
    Write-Host ""

    #Declaracion de funciones
    Function SigMigrador {
        Write-Warning "Ahora vuelve al Servidor Destino, la palabra clave es 'la'" 
        Write-Warning "Vuelve cuando obtengas la clave para continuar"               
        Do{
            $keyWord2 = Read-Host ">Introduce palabra clave para continuar"
            if ($keyWord2 -eq "horda"){
                migradorMG
            }else{
                Write-Host "Buen intento, larpeiro, vai leer!"
            }
            if ($keyWord2 -eq "Exit"){
                volverMG
            }
        }Until($keyWord2 -eq "horda") 
    }
    
    Function exportUsers {
        Write-Host ""
        Write-Warning "Indica la carpeta compartida creada con el Compartidor®"
        Write-Host ""
        $path = Read-Host "Introduce ruta para guardar los usuarios/grupos"
        if ($path -eq "Exit"){
            volverMG
        }else{
            $pass = ConvertTo-SecureString "abc123." -AsPlainText -Force
            & Export-SmigServerSetting -User All -Group -Path $path -Password $pass -Verbose
            #Write-Host ""
            #Write-Warning "Completado"
            #Write-Host ""
            #Write-Warning "Ahora copia el archivo generado en el nuevo servidor"
            SigMigrador
        }
    }

    Function despedida {
	    Write-Host ""
	    Write-Host "# ¡Hasta pronto! #"
	    Write-Host ""
        Exit
    }#fin declaracion

    #Modo guiado
    Write-Warning "Ahora toca exportar los usuarios y grupos."
    Write-Host ""
    $omitir = Read-Host "¿Deseas omitir este apartado?(s,n)"
    if ($omitir -eq "s"){
        SigMigrador   
    }

    #Iniciar Migration Tools
    Write-Warning "En nuestro caso 's' porque a veces no se inician en el paso anterior" 
    Write-Warning "No pasa nada si sale un mensaje de error"
    Write-Host ""
    $answ = Read-Host "¿Deseas iniciar las Migration Tools?[No si ya las iniciaste antes] (s,n)"
    if ($answ -eq "Exit"){
        volverMG
    }

    if ($answ -eq "s"){
        Add-PSSnapin Microsoft.Windows.ServerManager.Migration
        Write-Host ""
        Write-Warning "Iniciadas"

        #Exportacion de usuarios
        exportUsers

    }

    if ($answ -eq "n"){
        exportUsers 
    }

    #Copiar el archivo usuarios al destino indicado
    #$ans = Read-Host "¿Deseas copiar el archivo ahora?[No si ya introdujiste una ruta de red en el paso anterior](s,n)"
    #
    #if ($ans -eq "n"){
    #    volverLobby
    #}
    #
    #if ($ans -eq "s"){

    #   Write-Host ""
    #   $pathO = Read-Host ">Indica ruta completa del archivo"
    #   Write-Host ""
    #   $pathD = Read-Host ">Indica ruta destino"

    #   & copy $pathO $pathD

    #}


}#fin recopilador