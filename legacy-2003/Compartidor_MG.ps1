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