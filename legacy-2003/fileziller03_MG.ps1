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