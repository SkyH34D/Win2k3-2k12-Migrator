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

    Write-Warning "El ultimo paso será importar el servidor FileZilla"
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
        $nota = Read-Host "¿Que nota le pondrías?(1-10)"
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