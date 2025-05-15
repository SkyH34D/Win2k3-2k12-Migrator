Function deployerMG {

    Write-Host ""
    Write-Host "#############################"
    Write-Host "#                           #"
    Write-Host "#  Bienvenido al Deployer®  #"
    Write-Host "#   -Edición Modo Guiado-   #"
    Write-Host "#                           #"
    Write-Host "#############################"
    Write-Host "# Introduce Exit para salir #"
    Write-Host "#############################"
    Write-Host ""

    #Declaración de funciones

    Function sigRecopilador {
        $siguiente = Read-Host "¿Listo para el siguiente apartado?(s,n)"
        if ($siguiente -eq "s"){
            recopiladorMG
        }else{
            volverMG
        } 
    }
    
    Function copiarSMT {

        Write-Host ""
        Write-Warning "Es nuestro caso, asi que 's'"
        Write-Host ""
        $answ = Read-Host "¿Tienes las Server Migration Tools (SMT) en un carpeta de red?(s,n)"

        if ($answ -eq "n"){
            deployear
        }

        #Copiar SMT de red a local
        Write-Host ""
        Write-Warning "Indicar ruta de red de la carpeta creada con el Compartidor®"
        Write-Host ""
        if ($answ -eq "s"){
            Write-Host ""
            $pathSMT = Read-Host ">Introduce la ruta de red completa de las SMT (\\IP\La\Ruta)"
            Write-Host ""
            $pathDestino = Read-Host ">Introduce la ruta completa de destino"
            & cp -R $pathSMT $pathDestino
            Write-Host ""
            Write-Warning "Completado"
            Write-Host ""
            
            #Ejecutar SMT desde red  
            Write-Host ""
            Write-Warning "'S'"
            Write-Host ""
            $ans = Read-Host "¿Desea instalar las Server Migration Tools (SMT) ahora?(s,n)"

            if ($ans -eq "n"){
                volverMG
            }

            if ($ans -eq "s"){
                Write-Host ""
                & cd $pathDestino\SMT_ws03_x86
                .\Smigdeploy.exe
                Write-Host ""
                Write-Warning "Completado"
                Add-PSSnapin Microsoft.Windows.ServerManager.Migration
                Write-Warning "Migration Tools habilitadas"
                Write-Host ""
                sigRecopilador
            } 
               
        }    

    }
    
    Function deployear {
        
        Write-Host ""
        $ans = Read-Host "¿Desea instalar las Server Migration Tools (SMT) ahora?(s,n)"

        if ($ans -eq "n"){
            sigRecopilador
        }

        if ($ans -eq "s"){
            Write-Host ""
            $path = Read-Host ">Introduce la ruta completa de las Server Migration Tools"
            #funciona con ubicaciones de red si tenemos el acceso autorizado
            & cd $path 
            .\Smigdeploy.exe
            Write-Host ""
            Write-Warning "Completado"
            Add-PSSnapin Microsoft.Windows.ServerManager.Migration
            Write-Warning "Migration Tools habilitadas"
            Write-Host ""
            sigRecopilador

        }
    
    }

    Function despedida {
	    Write-Host ""
	    Write-Host "# ¡Hasta pronto! #"
	    Write-Host ""
        Exit
    }#fin declaracion

    #Modo guiado
    Write-Warning "Ahora toca instalar la utilidad que nos permitirá realizar la migración en el Servidor Legacy."
    Write-Host ""
    $omitir = Read-Host "¿Deseas omitir este apartado?(s,n)"
    if ($omitir -eq "s"){
        sigRecopilador   
    }

    #Habilitar acceso a la carpeta compartida por Servidor Destino 
    Write-Warning "Pon 's' si usaste el Compartidor®, que es nuestro caso"
    Write-Host ""
    $answ = Read-Host "¿Deseas acceder a un recurso compartido?(s,n)"

    if ($answ -eq "Exit"){
        volverMG #despedida
    }

    if ($answ -eq "s"){
        Write-Host
        Write-Warning "Ahora hay que indicar la ruta de red del recurso y un usuario del servidor (Administrador, por ejemplo)"
        Write-Host ""
        $ipDest = Read-Host ">Introduce dirección IP del equipo destino"
        Write-Host ""
        $carpetaComp = Read-Host ">Introduce el nombre de la carpeta compartida"
        Write-Host ""
        $usuario = Read-Host ">Introduce usuario del equipo destino"
        Write-Host ""
        & net use \\$ipDest\$carpetaComp * /user:$usuario
        #Ejecutar las Server Migration Tools
        copiarSMT
        
        }

    if ($answ -eq "n"){
        copiarSMT
    }

}#fin deployerMG