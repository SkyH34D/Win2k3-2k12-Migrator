    Write-Host ""
    Write-Host "################################"
    Write-Host "#                              #"
    Write-Host "#  Bienvenido al Originador®   #"
    Write-Host "#    -Edición Modo Guiado-     #"
    Write-Host "#                              #"
    Write-Host "################################"
    Write-Host "#  Introduce Exit para salir   #"
    Write-Host "################################"
    Write-Host ""

    #Declaración de funciones
    Function sigDespliegador {
        Write-Host ""
        Write-Warning "Ahora ejecuta el Migrador (semi)Definitivo en el servidor Legacy e inicia el Modo Guiado, la palabra clave para iniciarlo es 'por'" 
        Write-Warning "Vuelve cuando obtengas la clave para continuar"               
        Do{
            $keyWord2 = Read-Host ">Introduce palabra clave para continuar"
            if ($keyWord2 -eq "por"){
                despliegadorMG
            }else{
                Write-Host "Buen intento, larpeiro, vai leer!"
            }
            if ($keyWord2 -eq "Exit"){
                volverMG
            }
        }Until($keyWord2 -eq "por")    
    }    
    
    Function Legacity{
        $path = Read-Host ">Introduce ruta para la utilidad Legacy (SMT)"
        if ($path -eq "Exit"){
            volverMG
        }else{
	        Write-Host "" 
            cd C:\Windows\System32\ServerMigrationTools\
            & .\SmigDeploy.exe /package /architecture X86 /os WS03 /path $path
            Write-Host ""
            Write-Warning "Completado"
            Write-Warning "No olvides copiar el archivo en el servidor Legacy"
        }
    }

    Function despedida {
	    Write-Host ""
	    Write-Host "# ¡Hasta pronto! #"
	    Write-Host ""
        Exit
    }#fin declaracion

    #Modo guiado
    Write-Warning "Ahora toca instalar la utilidad que nos permitirá realizar la migración."
    Write-Host ""
    $omitir = Read-Host "¿Deseas omitir este apartado?(s,n)"
    if ($omitir -eq "s"){
        sigDespliegador    
    }

    #Instalar la utilidad
    $answ = Read-Host "¿Deseas instalar las Migration Tools? (s,n)"
    if ($answ -eq "Exit"){
        volverMG #despedida
    }

    if ($answ -eq "s"){
        Install-WindowsFeature Migration
        Write-Host ""
        Write-Warning "Completado"
        Write-Host ""
        Write-Warning "Ahora crearemos la utilidad para el sistema operativo que deseamos migrar"
        Write-Warning "Es recomendable crearla en la recurso de red que hemos creado con el Compartidor®"
        Write-Host ""
        Legacity
        sigdespliegador
    }

    if ($answ -eq "n"){
        Write-Host ""
        Write-Warning "Ahora crearemos la utilidad para el sistema operativo que deseamos migrar"
        Write-Warning "Es recomendable crearla en la recurso de red que hemos compartido con el Compartidor®"
        Write-Host ""
        #Crear utilidad para el server legacy
        $resp = Read-Host "¿deseas crear Migrations Tools para Server Legacy? (s,n)"

        if ($resp -eq "n"){
            lobby
        }

        if ($resp -eq "s"){
            Write-Host ""
            Legacity
            sigdespliegador
        }
 
        #Copiar utilidad en ubicación especifica
        Write-Host ""
        Write-Warning "Si la ruta indicada no ha sido la carpeta compartida con el Compartidor®, copia la carpeta con las utilidades que se acaban de crear en el Servidor Legacy"
        Write-Host ""
        $copia = Read-Host "¿Copiar las Server Migrations Tools (SMT) en una ubicación especifica?(s,n)"
        if ($resp -eq "n"){
            lobby
        }
        if ($resp -eq "s"){
            Write-Host ""
            $pathO = Read-Host ">Indica la ruta de las SMT (carpeta incluida)"
            Write-Host ""
            $pathD = Read-Host ">Indica la ruta destino"

            & cp $pathO $pathD
            Write-Host ""
            Write-Warning "Completado"
            Write-Host ""
            sigdespliegador
        }
    } #Cierre del no instalar Migrations Tools