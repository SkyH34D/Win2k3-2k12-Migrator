#Declaracion de funciones principales {
function compartidor{

#2
    Write-Host ""
    Write-Host "################################"
    Write-Host "#                              #"
    Write-Host "#  Bienvenido al Compartidor®  #"
    Write-Host "#                              #"
    Write-Host "################################"
    Write-Host "#  Introduce Exit para salir   #"
    Write-Host "################################"
    Write-Host ""

    #Declaración de funciones
    Function despedida {
	    Write-Host ""
	    Write-Host "# ¡Hasta pronto! #"
	    Write-Host ""
        Exit
    }

    #23
    Function comparticion {
        Write-Host ""
        $name = Read-Host ">Introduce nombre para el recurso compartido"
        if ($name -eq "Exit"){
        volverLobby #despedida
        }else{
            Write-Host ""
            $path = Read-Host ">Introduce ruta completa de la carpeta a compartir"
            if ($path -eq "Exit"){
                volverLobby #despedida
            }else{
                & New-SmbShare -Name $name -Path $path -FullAccess "Todos"
            }
        }
        
    }

    #Crear carpeta a compartir
    Write-Host ""
    $answ = Read-Host "¿Quieres crear la carpeta a compartir?(s,n)" 

    if ($answ -eq "Exit"){
        volverLobby #despedida
    }

    if ($answ -eq "s"){
        Write-Host ""
        $folder = Read-Host ">Introduce nombre para la carpeta (y ruta si quieres una ubicación distinta de la actual)"

        if ($folder -eq "Exit"){
        volverLobby #despedida
        }else{
            & mkdir $folder
        }
        #Compartir carpeta
        comparticion
        Write-Warning "Completado"
        volverLobby
    }

    if ($answ -eq "n"){
        #Compartir carpeta
        comparticion
        Write-Warning "Completado"
        volverLobby
    }

}#fin Compartidor

function version{
   Write-Host "Ideado y escrito por Cristian D. Franco"
}

function originador{
    Write-Host ""
    Write-Host "###############################"
    Write-Host "#                             #"
    Write-Host "#  Bienvenido al Originador®  #"
    Write-Host "#                             #"
    Write-Host "###############################"
    Write-Host "#  Introduce Exit para salir  #"
    Write-Host "###############################"
    Write-Host ""

    #Declaración de funciones
    Function Legacity{
        $path = Read-Host ">Introduce ruta para la utilidad Legacy (SMT)"
        if ($path -eq "Exit"){
            volverLobby
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
    }

    #Instalar la utilidad
    $answ = Read-Host "¿Deseas instalar las Migration Tools? (s,n)"
    if ($answ -eq "Exit"){
        volverLobby #despedida
    }

    if ($answ -eq "s"){
        Install-WindowsFeature Migration
        Write-Host ""
        Write-Warning "Completado"
        Write-Host ""
        Legacity
        volverLobby
    }

    if ($answ -eq "n"){
        Write-Host ""
        #Crear utilidad para el server legacy
        $resp = Read-Host "¿Deseas crear Migrations Tools para Server Legacy? (s,n)"

        if ($resp -eq "n"){
            lobby
        }

        if ($resp -eq "s"){
            Write-Host ""
            Legacity
            volverLobby
        }
 
        #Copiar utilidad en ubicación especifica
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

            $destino = Read-Host "¿Desdeas volver al lobby?(s,n)"

            if ($destino -eq "s"){
                lobby
            }

            if ($destino -eq "n"){
                originador
            }
        }
    } #Cierre del no instalar Migrations Tools
}#fin originador

function despliegador {
    
    Write-Host ""
    Write-Host "#################################"
    Write-Host "#                               #"
    Write-Host "#  Bienvenido al Despliegador®  #"
    Write-Host "#                               #"
    Write-Host "#################################"
    Write-Host "#  Introduce Exit para salir    #"
    Write-Host "#################################"
    Write-Host ""

    #Declaracion de funciones
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
            volverLobby #despedida
        }else{
            $pass = ConvertTo-SecureString "abc123." -AsPlainText -Force
            & Import-SmigServerSetting -User All -Group -Path $path -Verbose -Password $pass
            Write-Host ""
        }
        Write-Warning "Usuarios importados con éxito"
        Write-Host ""
        net user
    }
    
    #Iniciar Migration Tools
    #$answ = Read-Host "¿Deseas iniciar las Migration Tools? (s,n)"
    #if ($answ -eq "Exit"){
    #    despedida
    #}

    #if ($answ -eq "s"){
    #    Add-PSSnapin Microsoft.Windows.ServerManager.Migration
    #    Write-Host ""
    #    Write-Warning "Iniciadas correctamente"

        #Exportacion de usuarios
    #    importUsers

    #}

    #$answ = Read-Host "¿Deseas  Importar los usuarios ahora? (s,n)"
    #if ($answ -eq "s"){
    #    importUsers 
    #}
    #if ($answ -eq "n"){
    #    lobby
    #}

    #Importar usuarios
    importUsers
    
    $resp = Read-Host "¿Deseas habilitar los usuarios?(s,n)"

    if ($resp -eq "n"){
        lobby
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
        }
    }

}

function carpeteador {
    
    Write-Host ""
    Write-Host "##############################"
    Write-Host "#                            #"
    Write-Host "# Bienvenido al Carpeteador® #"
    Write-Host "#                            #"
    Write-Host "##############################"
    Write-Host "# Introduce Exit para salir  #"
    Write-Host "##############################"
    Write-Host ""

    #Declaración de funciones

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
    }

    $path = Read-Host 'Introduce el nombre de la carpeta'
    if ($path -eq "Exit"){
        Write-Host ""
        Write-Host "# Hasta pronto! #"
        Write-Host ""
        Exit
    }else{
        if ($path){
	        & mkdir $path -Force
	        $pass = ConvertTo-SecureString "abc123." -AsPlainText -Force
	        & Receive-SmigServerData -Password $pass
        }else{
	        Write-Warning 'No has introducido nada, larpeirán!'
        }
        carpeteadorBucle
    }
}#fin carpeteador

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

    Write-Warning "Es imprescindible haber realizado la exportación del servidor FilleZila en el Servidor Legacy"
    Write-Host ""
    $fzPath = Read-Host ">Indica la ruta de la carpeta donde se a exportado FileZilla (solo ruta de la carpeta contenedora)"
    Write-Host ""
    $cpPath = Read-Host ">Indica la ruta de instalación de FileZilla"
    Write-Host ""
    & cd $fzPath
    & cp '.\FileZilla Server.xml' $cpPath
    cd \

    if (($fzPath -eq "Exit") -or ($cpPath -eq "Exit")){
        volverLobby
    }

    Write-Warning "Completado"
    Write-Host ""
    Write-Warning "Ahora debes modificar el Admin PassWord en 'FileZilla Server.xml' (linea 20) por la contraseña del Admin del FileZilla Server de la máquina actual"
    Write-Warning "Después de hacerlo, reinicia FileZilla"
    Write-Host ""
    $ans = Read-Host "¿Volver al lobby?(s,n)"

    if ($ans -eq "s"){
        lobby
    }

    if ($ans -eq "n"){
        Exit
    }

}
##
##
##
##


Function mGuiado{

    #declaracion de funciona ModoGuiado
    Function compartidorMG {
        Clear-Host
        Write-Host ""
        Write-Host "################################"
        Write-Host "#                              #"
        Write-Host "#  Bienvenido al Compartidor®  #"
        Write-Host "#    -Edición Modo Guiado-     #"
        Write-Host "#                              #"
        Write-Host "################################"
        Write-Host "#  Introduce Exit para salir   #"
        Write-Host "################################"
        Write-Host ""

        #Declaración de funciones
        Function sigOriginador {
            $siguiente = Read-Host "¿Listo para el siguiente apartado?(s,n)"
            if ($siguiente -eq "s"){
                originadorMG
            }else{
                volverMG
            }    
        }

        Function despedida {
	        Write-Host ""
	        Write-Host "# ¡Hasta pronto! #"
	        Write-Host ""
            Exit
        }

        #23
        Function comparticion {
            Write-Host ""
            Write-Warning "El nombre con el que la carpeta se verá para otros equipos de la red"
            Write-Host ""
            $name = Read-Host ">Introduce nombre para el recurso compartido"
            if ($name -eq "Exit"){
            volverMG #despedida
            }else{
                Write-Host ""
                $path = Read-Host ">Introduce ruta completa de la carpeta a compartir"
                if ($path -eq "Exit"){
                    volverMG #despedida
                }else{
                    & New-SmbShare -Name $name -Path $path -FullAccess "Todos"
                }
            }
        
        }#fin declaracion

        #modo guiado

        Write-Warning "Aqui creará el punto de unión entre el Servidor Legacy (WS2003) y el Servidor Destino (WS2012 R2), que es este."
        Write-Warning "Servirá para transferir algunos archivos del Legacy al Destino"
        Write-Warning "Si ya dispones de otro nexo de unión, omite este apartado"
        Write-Host ""

        $omitir = Read-Host "¿Deseas omitir este apartado?(s,n)"
        if ($omitir -eq "s"){
            sigOrginador    
        }
        Write-Host ""
        Write-Warning "Si ya tienes carpeta para compartir, omite este paso"

        #Crear carpeta a compartir
        Write-Host ""
        $answ = Read-Host "¿Quieres crear la carpeta a compartir?(s,n)" 

        if ($answ -eq "Exit"){
            volverMG #despedida
        }

        if ($answ -eq "s"){
            Write-Host ""
            $folder = Read-Host ">Introduce nombre para la carpeta (y ruta si quieres una ubicación distinta de la actual)"

            if ($folder -eq "Exit"){
            volverMG #despedida
            }else{
                & mkdir $folder
            }
            #Compartir carpeta
            comparticion
            Write-Warning "Completado"
            sigOriginador
        }

        if ($answ -eq "n"){
            #Compartir carpeta
            comparticion
            Write-Warning "Completado"
            sigOriginador
        }   

    }#fin compartidorMG

    Function originadorMG {
        Clear-Host
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
                if ($keyWord2 -eq "la"){
                    despliegadorMG
                }else{
                    Write-Host "Buen intento, larpeiro, vai leer!"
                }
                if ($keyWord2 -eq "Exit"){
                    volverMG
                }
            }Until($keyWord2 -eq "la")    
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

    }#fin originadorMG

    Function despliegadorMG {
        
        Clear-Host
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
        $omitir = Read-Host "¿Deseas omitir este apartado?(s,n)"
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

    }#fin recopilador

    Function carpeteadorMG {
        
        Clear-Host
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

        $omitir = Read-Host "¿Deseas omitir este apartado?(s,n)"
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

    }#fin carpeteador

    Function filezillerMG {
        
        Clear-Host
        Write-Host ""
        Write-Host "################################"
        Write-Host "#                              #"
        Write-Host "#  Bienvenido al FileZiller®   #"
        Write-Host "#    -Edición Modo Guiado-     #"
        Write-Host "#                              #"
        Write-Host "################################"
        Write-Host "#  Introduce Exit para salir   #"
        Write-Host "################################"
        Write-Host ""

        Write-Warning "El ultimo paso será migrar el servidor FileZilla"
        Write-Host ""
        Write-Warning "Es imprescindible haber realizado la exportación del servidor FilleZila en el Servidor Legacy"
        Write-Host ""
        Write-Warning "Introducimos la carpeta creada en el Compartidor®"
        Write-Host ""
        $fzPath = Read-Host ">Indica la ruta de la carpeta donde se a exportado FileZilla (solo ruta de la carpeta contenedora)"
        Write-Host ""
        $cpPath = Read-Host ">Indica la ruta de instalación de FileZilla (sin comillas)"
        Write-Host ""
        & cd $fzPath
        & cp '.\FileZilla Server.xml' $cpPath
        cd \

        if (($fzPath -eq "Exit") -or ($cpPath -eq "Exit")){
            Write-Warning "Modo guiado finalizado"
            $nota = Read-Host "¿Que nota le pondrías?(1-10"
            volverLobby
        }

        Write-Warning "Completado"
        Write-Host ""
        Write-Warning "Ahora debes modificar el Admin PassWord en 'FileZilla Server.xml' (linea 20) por la contraseña del Admin del FileZilla Server de la máquina actual"
        Write-Warning "Después de hacerlo, reinicia FileZilla"
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

    }#fin fileziller

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
        Write-Host "                    Introducción                    " 
        Write-Host "----------------------------------------------------"
        Write-Host ""
        Write-Host "·La migracion de un equipo Windows Server 2003 de 32 bits a un Windows Server 2012 R2 es un trabajo arduo y complejo."
        Write-Host ""
        Write-Host "·El Migrador (semi)Definitivo® facilita esta labor agrupando todo lo necesario para llevar a cabo un correcta migracion."
        Write-Host ""
        Write-Host "·El MODO GUIADO, donde ahora te encuentras, te llevará de la mano a lo largo de este proceso."
        Write-Host ""
        Write-Host "·Ponte cómodo y disfruta del paseo :)"
        Write-Host ""
        Write-Warning "Debes leer el documento previo antes de contiuar"
        Write-Host ""

        Do{
            $keyWord = Read-Host ">Introduce palabra clave para continuar"
            if ($keyWord -eq "opresion"){
                compartidorMG
            }else{
                Write-Host "Buen intento, larpeiro, vai leer!"
            }
            if ($keyWord -eq "Exit"){
                volverLobby
            }
        }Until($keyWord -eq "opresion")

    }
    #Fin declaracion funciones Modo Guiado

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
    Write-Host "                    Introducción                    " 
    Write-Host "----------------------------------------------------"
    Write-Host ""
    Write-Host "·La migracion de un equipo Windows Server 2003 de 32 bits a un Windows Server 2012 R2 es un trabajo arduo y complejo."
    Write-Host ""
    Write-Host "·El Migrador (semi)Definitivo® facilita esta labor agrupando todo lo necesario para llevar a cabo un correcta migracion."
    Write-Host ""
    Write-Host "·El MODO GUIADO, donde ahora te encuentras, te llevará de la mano a lo largo de este proceso."
    Write-Host ""
    Write-Host "·Ponte cómodo y disfruta del paseo :)"
    Write-Host ""
    Write-Warning "Debes leer el documento previo antes de contiuar"
    Write-Host ""

    Do{
        $keyWord = Read-Host ">Introduce palabra clave para continuar"
        if ($keyWord -eq "opresion"){
            compartidorMG
        }else{
            Write-Host "Buen intento, larpeiro, vai leer!"
        }
        if ($keyWord -eq "Exit"){
            volverLobby
        }
    }Until($keyWord -eq "opresion")
}#fin mguiado

 


##
##
##
##
Function lobby {

    #Solo el listado de opciones
    #Añadir un clear host para
    cd C:\
    Clear-Host
    Write-Host ""
    Write-Host "####################################################"
    Write-Host "####################################################"
    Write-Host "##                                                ##"
    Write-Host "##                                                ##"
    Write-Host "##    Bienvenido al Migrador (semi)Definitivo®    ##"
    Write-Host "##                                                ##"
    Write-Host "##                                                ##"
    Write-Host "####################################################"
    Write-Host "###############Versión 0.8.7 (Alpha)################"
    Write-Host ""
    Write-Host "----------------------------------------------------"
    Write-Host "Lista de opciones para el Servidor Destino          "
    Write-Host "----------------------------------------------------"
    Write-Host ""
    Write-Host "1 - Modo guiado (experimental)"
    Write-Host "2 - Compartidor®"
    Write-Host "3 - Originador®"
    Write-Host "4 - Desplegador®"
    Write-Host "5 - Carpeteador®"
    Write-Host "6 - Fileziller®"
    Write-Host ""
    Write-Host "? - Help"
    Write-Host "M - Manual"
    Write-Host "E - Salir"
    Write-Host ""
    $opcion = Read-Host ">Introduce la opción deseada"
    Write-Host ""

    if (($opcion -eq "Exit") -or ($opcion -eq "E") -or ($opcion -eq "exit")){
        despedida
    }


    if ($opcion -eq "?"){
    
        Write-Host ""
        Write-Host "Modo guiado:	Lleva al usuario por el recorrido a realizar para una correcta migración."
        Write-Host ""
        Write-Host "Compartidor®: 	Crea y comparte la carpeta compartida que ayudará durante la migración"
        Write-Host ""
        Write-Host "Originador®: 	Instala las herramientas necesarias para llevar a cabo la migración"
        Write-Host ""
        Write-Host "Despliegador®: 	Importa y habilita los usuarios del Servidor Legacy"
        Write-Host ""
        Write-Host "Carpeteador®: 	Acepta las peticiones de migración de datos del Servidor Legacy y crea una carpeta para almacenar dichos datos"
        Write-Host ""
        Write-Host "Fileziller®:    Herramienta para migrar un servidor FileZilla."
        Write-Host ""
        Write-Warning "Para información más detallada, vaya al Manual (M)"
        Write-Host ""
        #volver al lobby
        lobbySinBorrar
    }

    if ($opcion -eq "1"){
    
        mGuiado

    }

    if ($opcion -eq "2"){
        Clear-Host
        compartidor
        lobby
    }

    if ($opcion -eq "3"){
        Clear-Host
        originador
        lobby
    }

    if ($opcion -eq "4"){
        Clear-Host
        despliegador
        volverLobby
    }

    if ($opcion -eq "5"){
        Clear-Host
        carpeteador
        lobby
    }

    if ($opcion -eq "6"){
        Clear-Host
        fileziller
        volverLobby
    }

    if ($opcion -eq "M"){
        Clear-Host
        manual
        lobby
    }

    if (($opcion -eq "ver") -or ($opcion -eq "v") -or ($opcion -eq "version")){
        version
        lobby
    }

}

Function lobbySinBorrar {

    #Lobby sin Clear-Host para opciones como "?"
    cd C:\
    Write-Host ""
    Write-Host "####################################################"
    Write-Host "####################################################"
    Write-Host "##                                                ##"
    Write-Host "##                                                ##"
    Write-Host "##    Bienvenido al Migrador (semi)Definitivo®    ##"
    Write-Host "##                                                ##"
    Write-Host "##                                                ##"
    Write-Host "####################################################"
    Write-Host "###############Versión 0.8.7 (Alpha)################"
    Write-Host ""
    Write-Host "----------------------------------------------------"
    Write-Host "Lista de opciones para el Servidor Destino          "
    Write-Host "----------------------------------------------------"
    Write-Host ""
    Write-Host "1 - Modo guiado (experimental)"
    Write-Host "2 - Compartidor®"
    Write-Host "3 - Originador®"
    Write-Host "4 - Desplegador®"
    Write-Host "5 - Carpeteador®"
    Write-Host "6 - Fileziller®"
    Write-Host ""
    Write-Host "? - Help"
    Write-Host "M - Manual"
    Write-Host "E - Salir"
    Write-Host ""
    $opcion = Read-Host ">Introduce la opción deseada"
    Write-Host ""

    if (($opcion -eq "Exit") -or ($opcion -eq "E") -or ($opcion -eq "exit")){
        despedida
    }


    if ($opcion -eq "?"){
    
        Write-Host ""
        Write-Host "Modo guiado:	Lleva al usuario por el recorrido a realizar para una correcta migración."
        Write-Host ""
        Write-Host "Compartidor®: 	Crea y comparte la carpeta compartida que ayudará durante la migración"
        Write-Host ""
        Write-Host "Originador®: 	Instala las herramientas necesarias para llevar a cabo la migración"
        Write-Host ""
        Write-Host "Despliegador®: 	Importa y habilita los usuarios del Servidor Legacy"
        Write-Host ""
        Write-Host "Carpeteador®: 	Acepta las peticiones de migración de datos del Servidor Legacy y crea una carpeta para almacenar dichos datos"
        Write-Host ""
        Write-Host "Fileziller®:    Herramienta para migrar un servidor FileZilla."
        Write-Host ""
        Write-Warning "Para información más detallada, vaya al Manual (M)"
        Write-Host ""
        #volver al lobby
        lobbySinBorrar
    }

    if ($opcion -eq "1"){
    
        mGuiado

    }

    if ($opcion -eq "2"){
        Clear-Host
        compartidor
        lobby
    }

    if ($opcion -eq "3"){
        Clear-Host
        originador
        lobby
    }

    if ($opcion -eq "4"){
        Clear-Host
        despliegador
        volverLobby
    }

    if ($opcion -eq "5"){
        Clear-Host
        carpeteador
        lobby
    }

    if ($opcion -eq "6"){
    Clear-Host
    fileziller
    volverLobby
    }

    if ($opcion -eq "M"){
        Clear-Host
        manual
        lobby
    }

    if (($opcion -eq "ver") -or ($opcion -eq "v") -or ($opcion -eq "version")){
        version
        lobby
    }

}

Function manual {
    Write-Host ""
    Write-Warning "Has intentado utilizar una función premium."
    Write-Warning "Ponte en contacto con el desarrollador para conocer las ofertas actuales"
}

Function despedida {
	Write-Host ""
	Write-Host "# ¡Hasta pronto! #"
	Write-Host ""
    Exit
}

Function volverLobby {
    Write-Host ""
    $ans = Read-Host "¿Volver al lobby?(s,n)"
    if ($ans -eq "s"){
        lobby
    }
    if ($ans -eq "n"){
        Exit
    }
}
#} Fin declaración de funciones principales

#arrancar migration tool
Write-Host ""
$smtService = Read-Host "¿Quieres iniciar las Server Migration tools? [No si es la primera vez que usas este programa o si ya las has iniciado en este prompt](s,n)"
if ($smtService -eq "s"){
    Add-PSSnapin Microsoft.Windows.ServerManager.Migration
    Clear-Host
}

if ($smtService -eq "n"){
    Clear-Host
}

#Lobby
Write-Host ""
Write-Host "####################################################"
Write-Host "####################################################"
Write-Host "##                                                ##"
Write-Host "##                                                ##"
Write-Host "##    Bienvenido al Migrador (semi)Definitivo®    ##"
Write-Host "##                                                ##"
Write-Host "##                                                ##"
Write-Host "####################################################"
Write-Host "###############Versión 0.8.7 (Alpha)################"
Write-Host ""

Write-Host "----------------------------------------------------"
Write-Host "Lista de opciones para el Servidor Destino          "
Write-Host "----------------------------------------------------"
Write-Host ""
Write-Host "1 - Modo guiado (experimental)"
Write-Host "2 - Compartidor®"
Write-Host "3 - Originador®"
Write-Host "4 - Despliegador®"
Write-Host "5 - Carpeteador®"
Write-Host "6 - Fileziller®"
Write-Host ""
Write-Host "? - Help"
Write-Host "M - Manual"
Write-Host "E - Salir"
Write-Host ""

$opcion = Read-Host ">Introduce la opción deseada"
Write-Host ""

if (($opcion -eq "Exit") -or ($opcion -eq "E") -or ($opcion -eq "exit")){
    despedida
}


if ($opcion -eq "?"){
    
    Write-Host ""
    Write-Host "Modo guiado:	Lleva al usuario por el recorrido a realizar para una correcta migración."
    Write-Host ""
    Write-Host "Compartidor®: 	Crea y comparte la carpeta compartida que ayudará durante la migración"
    Write-Host ""
    Write-Host "Originador®: 	Instala las herramientas necesarias para llevar a cabo la migración"
    Write-Host ""
    Write-Host "Despliegador®: 	Importa y habilita los usuarios del Servidor Legacy"
    Write-Host ""
    Write-Host "Carpeteador®: 	Acepta las peticiones de migración de datos del Servidor Legacy y crea una carpeta para almacenar dichos datos"
    Write-Host ""
    Write-Host "Fileziller®:    Herramienta para migrar un servidor FileZilla."
    Write-Host ""
    Write-Warning "Para información más detallada, vaya al Manual (M)"
    Write-Host ""
    #volver al lobby
    lobbySinBorrar
}

if ($opcion -eq "1"){
    
    mGuiado

}

if ($opcion -eq "2"){
    Clear-Host
    compartidor
    lobby
}

if ($opcion -eq "3"){
    Clear-Host
    originador
    lobby
}

if ($opcion -eq "4"){
    Clear-Host
    despliegador
    volverLobby
}

if ($opcion -eq "5"){
    Clear-Host
    carpeteador
    lobby
}

if ($opcion -eq "6"){
    Clear-Host
    fileziller
    lobby
}

if ($opcion -eq "M"){
    manual
    lobbySin
}

if (($opcion -eq "ver") -or ($opcion -eq "v") -or ($opcion -eq "version")){
    version
    lobbySinBorrar
}