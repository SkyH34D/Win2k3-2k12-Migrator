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