    Write-Host ""
    Write-Host "##############################"
    Write-Host "#                            #"
    Write-Host "# Bienvenido al Carpeteador® #"
    Write-Host "#   -Edición Modo Guiado-    #"
    Write-Host "#                            #"
    Write-Host "##############################"
    Write-Host "# Introduce Exit para salir  #"
    Write-Host "##############################"
    Write-Host ""

    #Declaración de funciones

    Function sigFileZiller {
        $keyWord4 = Read-Host "¿Continuar con la importación del FileZilla?(s,n)"
        if ($keyWord4 -eq "s"){
            filezillerMG
        }
        if ($keyWord4 -eq "n"){
            Write-Warning "Modo guiado finalizado"
            $nota = Read-Host "¿Que nota le pondrías?(1-10"
            volverLobby
        }
    }
    
    Function carpeteadorBucle {

        Do {
            Write-Host ""
            Write-Warning ">Introduce done si ya has terminado"
            Write-Host ""
            $path = Read-Host '>Introduce ruta y nombre de la carpeta'
            if ($path -eq "Exit"){
                lobby
            }else{
                if ($path){
                    if ($path -eq "done"){
                    }else{
	                    & mkdir $path -Force
	                    $pass = ConvertTo-SecureString "abc123." -AsPlainText -Force
	                    & Receive-SmigServerData -Password $pass
                        }
                }else{
	                Write-Warning 'No has introducido nada, larpeirán!'
                }
            }
        }Until($path -eq "done") 
    }#fin declaracion

    #Modo guiado
    Write-Warning "Ahora toca aceptar los datos migrador desde el servidor Legacy"
    Write-Warning "Es necesario que introduzcas la carpeta indicada como destino en el Migrador®"
    Write-Host ""

    $omitir = Read-Host "¿deseas omitir este apartado?(s,n)"
    if ($omitir -eq "s"){
        sigFileZiller    
    }

    Write-Host ""
    Write-Warning "Es necesario que introduzcas la carpeta indicada como destino en el Migrador®"
    Write-Warning "Es preferible que no esté creada"
    $path = Read-Host 'Introduce el nombre de la carpeta'
    if ($path -eq "Exit"){
        volverMG
    }else{
        if ($path){
	        & mkdir $path -Force
	        $pass = ConvertTo-SecureString "abc123." -AsPlainText -Force
	        & Receive-SmigServerData -Password $pass
        }else{
	        Write-Warning 'No has introducido nada, larpeirán!'
        }
        carpeteadorBucle
        sigFileZiller
    }