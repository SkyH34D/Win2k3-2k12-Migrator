#Declaracion de funciones del Modo Guiado
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

Function migradorMG {
   
    Write-Host "##############################"
    Write-Host "#                            #"
    Write-Host "#  Bienvenido al Migrador®   #"
    Write-Host "#   -Edición Modo Guiado-    #"
    Write-Host "#                            #"
    Write-Host "##############################"
    Write-Host "# Introduce Exit para salir  #"
    Write-Host "##############################"
    Write-Host ""

    #Declaración de funciones
    Function sigFileZiller {
        $keyWord4 = Read-Host "¿Continuar con la exportación del FileZilla?(s,n)"
        if ($keyWord4 -eq "s"){
            filezillerMG
        }
        if ($keyWord4 -eq "n"){
            Write-Warning "Modo guiado finalizado"
            $nota = Read-Host "¿Que nota le pondrías?(1-10"
            volverLobby
        }
    }

    Function migradorBucle {
        
        Write-Host ""
        Write-Warning ">Introduce done si ya haz terminado"
        Write-Host ""
        $SP = Read-Host ">Introduce ruta de origen"

        if ($SP -eq "Exit"){
            lobby
        }

        if ($SP -eq "done"){
            lobby
        }else{
	        Write-Host ""
	        $DP = Read-Host ">Introduce ruta de destino"
	        Write-Host ""
	
	        if ($DP -eq "Exit"){
                lobby
	        }else{
		        if ($SP -and $DP){
			        $pass = ConvertTo-SecureString "abc123." -AsPlainText -Force
			        & Send-SmigServerData -ComputerName $ip -Password $pass -SourcePath $SP -DestinationPath $DP -Recurse -Verbose -Include All -Force
                    migradorBucle
		        }else{
			        Write-Warning -Message "No introdujiste nada, lagrán!"
                    migradorBucle
		        }
	        }
        }    

    }

    #migrador

    #Modo guiado
    Write-Warning "Ahora toca migrar los datos"
    Write-Host ""
    $omitir = Read-Host "¿Deseas omitir este apartado?(s,n)"
    if ($omitir -eq "s"){
        sigFileZilla   
    }
    Write-Host ""
    Write-Warning "Introduce la ruta del archivo o carpeta que quieras migrar"
    Write-Warning "No se aceptan discos enteros ni entradas multiples"
    Write-Host ""
    $SP = Read-Host ">Introduce ruta de origen"

    if ($SP -eq "Exit"){
        lobby
    }else{
	    Write-Host ""
	    $ip = Read-Host ">Introduce IP del Host de destino"
	    Write-Host ""
        Write-Warning "Introduce la ruta del archivo o carpeta que quieras migrar"
        Write-Warning "Ruta de la carpeta donde se copiaran los datos. Preferiblemente que no exista en ServidorDestino"
        Write-Warning "Tras introducirla, vuelve al Servidor Destino y creala"
        Write-Host ""
	    $DP = Read-Host ">Introduce ruta de destino"
	    Write-Host ""
	
	    if ($DP -eq "Exit"){
            lobby
	    }else{
		    if ($SP -and $DP){
			    $pass = ConvertTo-SecureString "abc123." -AsPlainText -Force
			    & Send-SmigServerData -ComputerName $ip -Password $pass -SourcePath $SP -DestinationPath $DP -Recurse -Verbose -Include All -Force
                migradorBucle
		    }else{
			    Write-Warning -Message "No introdujiste nada, lagrán!"
		    }
	    }
    }
}#fin migradorMG

Function fileziller {

    Write-Host ""
    Write-Host "################################"
    Write-Host "#                              #"
    Write-Host "#  Bienvenido al FileZiller®   #"
    Write-Host "#                              #"
    Write-Host "################################"
    Write-Host "#  Introduce Exit para salir   #"
    Write-Host "################################"
    Write-Host ""

    Write-Warning "El ultimo paso será exportar el servidor FileZilla"
    Write-Host ""
    $fzPath = Read-Host ">Indica la ruta de instalación de FileZilla (sin comillas)"
    Write-Host ""
    Write-Warning "Indicar la carpeta compartida"
    Write-Host ""
    $cpPath = Read-Host ">Indica la ruta de Exportación"
    Write-Host ""
    & cd $fzPath
    & cp '.\FileZilla Server.xml' $cpPath
    cd \

    if (($fzPath -eq "Exit") -or ($cpPath -eq "Exit")){
        Write-Warning "Modo guiado finalizado"
        $nota = Read-Host "¿Que nota le pondrías?(1-10)"
        volverLobby
    }

    Write-Warning "Completado"
    Write-Warning "Ahora ya puedes realizar la importacion en el Servidor Destino"
    Write-Host ""
    Write-Warning "Modo guiado finalizado"
    $nota = Read-Host "¿Que nota le pondrías?(1-10)"
    $ans = Read-Host "¿Volver al lobby?(s,n)"

    if ($ans -eq "s"){
        lobby
    }

    if ($ans -eq "n"){
        Exit
    }

}# fin fileziller

Function modoGuiado {

Clear-Host
Write-Host ""
Write-Host "####################################################"
Write-Host "####################################################"
Write-Host "##                                                ##"
Write-Host "##                                                ##"
Write-Host "##           Migrador (semi)Definitivo®           ##"
Write-Host "##                 -Modo Guiado-                  ##"
Write-Host "##                                                ##"
Write-Host "##                                                ##"
Write-Host "####################################################"
Write-Host "###############Versión 0.0.1 (Alpha)################"
Write-Host ""
Write-Host "----------------------------------------------------"
Write-Host "                 Servidor Legacy                    " 
Write-Host "----------------------------------------------------"
Write-Host ""
Write-Host ""
Write-Warning "Pulsa cualquier telca para continuar"
Write-Host ""

    $keyWord = Read-Host ">Pulsa cualquier telca para continuar"
    deployerMG
}

Function volverMG {
    Write-Host ""
    $ans = Read-Host "¿Volver al inicio del modo guiado?(s,n)"
    if ($ans -eq "s"){
        modoGuiado
    }
    if ($ans -eq "n"){
        volverLobby
    }
}
#Fin declaracion funciones modo guiado

#Modo guiado
Clear-Host
Write-Host ""
Write-Host "####################################################"
Write-Host "####################################################"
Write-Host "##                                                ##"
Write-Host "##                                                ##"
Write-Host "##           Migrador (semi)Definitivo®           ##"
Write-Host "##                 -Modo Guiado-                  ##"
Write-Host "##                                                ##"
Write-Host "##                                                ##"
Write-Host "####################################################"
Write-Host "###############Versión 0.0.1 (Alpha)################"
Write-Host ""
Write-Host "----------------------------------------------------"
Write-Host "                 Servidor Legacy                    " 
Write-Host "----------------------------------------------------"
Write-Host ""
Write-Host ""
Write-Warning "Para continuar con el Modo Guiado en este servidor, debes indicar la palabra clave"
Write-Host ""

Do{
    $keyWord = Read-Host ">Introduce palabra clave para continuar"
    if ($keyWord -eq "por"){
        deployerMG
    }else{
        Write-Host "Buen intento, larpeiro, vai leer!"
    }
    if ($keyWord -eq "Exit"){
        volverLobby
    }
}Until($keyWord -eq "por")