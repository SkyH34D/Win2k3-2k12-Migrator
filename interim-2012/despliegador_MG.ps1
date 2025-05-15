
    
    Write-Host ""
    Write-Host "#################################"
    Write-Host "#                               #"
    Write-Host "#  Bienvenido al Despliegador®  #"
    Write-Host "#    -Edición Modo Guiado-      #"
    Write-Host "#                               #"
    Write-Host "#################################"
    Write-Host "#   Introduce Exit para salir   #"
    Write-Host "#################################"
    Write-Host ""

    #Declaracion de funciones
    Function sigCarpeteador {
        Write-Host ""
        Write-Warning "Vuelve al servidor Legacy e inicia el Modo Guiado, la palabra clave para continuar es 'horda'"
        Write-Host "Vuelve cuando aparezca la barra de carga"                
        Write-Host ""
        $keyWord3 = Read-Host "¿Estás de vuelta?(s,n)"
        if ($keyWord3){
            carpeteadorMG
        }
        if ($keyWord3 -eq "Exit"){
            volverMG
        }
    }
    
    Function despedida {
	    Write-Host ""
	    Write-Host "# ¡Hasta pronto! #"
	    Write-Host ""
        Exit
    }

    Function importUsers {
        Write-Host ""
        $path = Read-Host ">Introduce ruta del archivo usuarios/grupos (solo carpeta contenedora)"
        if ($path -eq "Exit"){
            volverMG #despedida
        }else{
            $pass = ConvertTo-SecureString "abc123." -AsPlainText -Force
            & Import-SmigServerSetting -User All -Group -Path $path -Verbose -Password $pass
            Write-Host ""
        }
        Write-Warning "Usuarios importados con éxito"
        Write-Host ""
        net user
    }#fin declaracion

    #Modo guiado
    Write-Warning "Ahora toca importar los usuarios del servidor Legacy"
    Write-Host ""
    $omitir = Read-Host "¿deseas omitir este apartado?(s,n)"
    if ($omitir -eq "s"){
        sigCarpeteador    
    }

    Write-Host ""
    Write-Warning "Indicamos la ruta de la carpeta creada con el Compartidor"
    #Importar usuarios
    importUsers
    
    $resp = Read-Host "¿Deseas habilitar los usuarios?(s,n)"

    if ($resp -eq "n"){
        sigCarpeteador
    }

    if ($resp -eq "s"){
        Write-Host ""
        Write-Host "1 - Iris"
        Write-Host "2 - su"
        Write-Host "3 - seresco"
        Write-Host "4 - su.aplicaciones"
        Write-Host "5 - All"
        Write-Host ""
        $user = Read-Host ">Indica el usuario a habilitar"
        if ($user){
            Write-Host ""
            Write-Warning "Has intentado utilizar una función premium."
            Write-Warning "Ponte en contacto con el desarrollador para conocer las ofertas actuales"
        sigCarpeteador
        }
    }

