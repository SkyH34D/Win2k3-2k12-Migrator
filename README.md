# Win2003-to-2012 Migration Toolkit (2020 Edition)

> **Estado:** _“as-is / historical”_.  
> Estos fueron mis **primeros scripts en PowerShell** (año 2020). Se publican con fines formativos y porque les tengo un cariño especial al ser mis primeros pasos en powershell.
> La calidad del código es muy mejorable, se nota mucho que son mis primeros pasos en programación y en powershell.

## 🚀 Qué hace

1. **Prepara** ambos servidores (2003 y 2012) habilitando PowerShell, RDP y permisos de ejecución.
2. **Crea** una carpeta compartida accesible desde ambos nodos.
3. **Exporta** usuarios y grupos del servidor 2003.
4. **Copia** datos seleccionados (robocopy/xcopy o FileZilla CLI) al recurso compartido.
5. **Importa** los datos y cuentas en el servidor 2012.
6. **Guía interactiva:** scripts “Modo Guiado” conducen todo el proceso a través de palabras clave.

## 🗂️ Estructura rápida

```text
legacy-2003/      # Scripts que corren en el origen
interim-2012/     # Scripts que corren en el destino
docs/             # Manuales TXT con pasos previos y guion del modo guiado
examples/         # (opcional) logs o CSV de ejemplo
```

## 📂 Estructura de carpetas recomendada (detallada)

```text
win2003-to-2012-migration/
│
├─ legacy-2003/              # Scripts que se ejecutan en el servidor Windows Server 2003
│   ├─ MigradorTotal_2003.ps1
│   ├─ originador_MG.ps1
│   ├─ Compartidor_MG.ps1
│   ├─ migrador_MG.ps1
│   ├─ recopilador_MG.ps1
│   ├─ FileZiller_MG.ps1
│   ├─ fileziller03_MG.ps1
│   └─ Modo guiado 2003.ps1
│
├─ interim-2012/             # Scripts que se ejecutan en el servidor Windows Server 2012
│   ├─ MigradorTotal_2012.ps1
│   ├─ carpeteador_MG.ps1
│   ├─ deployer_MG.ps1
│   ├─ despliegador_MG.ps1
│   ├─ Modo guiado.ps1
│   └─ Todo.ps1
│
├─ docs/                     # Documentación y guías
│   ├─ ANTES DE EMPEZAR.txt
│   └─ Modo guiado.txt
│
└─ examples/                 # (Opcional) logs, CSV o capturas de ejemplo
```




## 📄 Resumen de scripts

| Script | Servidor objetivo | Descripción breve |
|--------|------------------|-------------------|
| MigradorTotal_2003.ps1 | 2003 | Orquestador todo‑en‑uno en el servidor origen. |
| MigradorTotal_2012.ps1 | 2012 | Orquestador en el servidor destino (intermedio). |
| Todo.ps1 | Meta | Wrapper que llama a los orquestadores según parámetro. |
| carpeteador_MG.ps1 | 2012 | Crea la carpeta de red compartida. |
| Compartidor_MG.ps1 | 2003 | Comparte la carpeta desde el servidor legacy. |
| originador_MG.ps1 | 2003 | Copia/instala utilidades en el servidor 2003. |
| deployer_MG.ps1 | 2012 | Copia binarios finales en el recurso compartido. |
| despliegador_MG.ps1 | 2012 | Sinónimo de **deployer_MG.ps1**. |
| migrador_MG.ps1 | 2003 | Copia datos (robocopy/xcopy) al recurso compartido. |
| recopilador_MG.ps1 | 2003 | Exporta usuarios y grupos a CSV. |
| FileZiller_MG.ps1 | 2003 → 2012 | Utiliza FileZilla CLI para transferencias FTP. |
| fileziller03_MG.ps1 | 2003 | Variante orientada a 2003, pruebas de red. |
| Modo guiado.ps1 | 2012 | Asistente interactivo paso a paso. |
| Modo guiado 2003.ps1 | 2003 | Asistente interactivo para el servidor legacy. |
| ANTES DE EMPEZAR.txt | Docs | Checklist previo y requisitos. |
| Modo guiado.txt | Docs | Guion del flujo interactivo y palabras clave. |


## ⚙️ Requisitos

| Servidor 2003 | Servidor 2012 |
| ------------- | ------------- |
| Windows Server 2003 SP2 | Windows Server 2012 (mínimo) |
| PowerShell 1.0 | PowerShell 5 recomendado |
| Conectividad de red bidireccional | Escritorio Remoto habilitado |
| `Set-ExecutionPolicy Unrestricted` | `Set-ExecutionPolicy Unrestricted` |

> **Nota 2025:** Microsoft ya no da soporte a 2003 ni a 2012. Considera migrar a 2022/2025 si es posible.

## 🧩 Instalación

```powershell
# En el servidor 2012
Set-ExecutionPolicy Unrestricted -Scope LocalMachine
.\interim-2012\carpeteador_MG.ps1   # Crea y comparte la carpeta de migración

# En el servidor 2003
Set-ExecutionPolicy Unrestricted
.\legacy-2003\originador_MG.ps1     # Copia las utilidades desde la carpeta compartida
.\legacy-2003\Modo guiado 2003.ps1  # Opción interactiva
```

## ▶️ Ejemplo rápido (modo guiado)

```powershell
# Servidor 2012
.\interim-2012\Modo guiado.ps1
# Introducir palabra clave: opresion
```

Sigue las instrucciones y las palabras clave indicadas en el terminal o en `docs/Modo guiado.txt`.

---

### 📌 Próximos pasos

* Revisar manualmente cada *.ps1* (algunos carecen de comentarios) y actualizar rutas/IP hardcodeadas.  
* Añadir logs de ejemplo y capturas de pantalla al directorio **examples/**.  
* (Opcional) Crear un ZIP automatizado antes del _commit_ final, como se muestra aquí.

_Creado con cariño en junio de 2020_
