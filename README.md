# Seguimiento-LE

Tablero interactivo para el seguimiento y análisis de variaciones de rating del programa "Las Estrellas" (lunes a viernes). Genera gráficos de tendencia por franja horaria, comparativos en grid y tablas de alertas cuando hay variaciones mayores a ±10%.

## Resumen rápido
- Proyecto en R que genera un dashboard HTML a partir de dos fuentes Excel: `Programmes Seguimiento LE_2.xlsx` y `Time LE Franjas_2.xlsx`.
- El proceso puede ejecutarse manualmente desde R/RStudio o automatizarse con Power Automate (script `correr_dashLE.R`).

## Stack
- Lenguaje: R
- Framework / runtime: R + RMarkdown / flexdashboard
- Paquetes principales: tidyverse (dplyr, tibble, readr...), rmarkdown, flexdashboard, plotly, ggplot2, readxl, data.table, lubridate, knitr

## Estructura del repositorio (entradas top-level)
- .RData
- .Rhistory
- .gitignore
- Manual Seguimiento LE.Rmd       — manual de operación y configuración
- Manual-Seguimiento-LE.html     — versión HTML del manual
- Programmes Seguimiento LE_2.xlsx — datos fuente (export desde HR-Media)
- README.md                      — (este archivo)
- Seguimiento-LE.Rproj
- TelevisaU2.jpg                 — logo usado en el dashboard
- Time LE Franjas_2.xlsx         — datos de franjas (export desde HR-Media)
- correr_dashLE.R                — script para generar el dashboard y hacer git commit/push
- images/                        — imágenes usadas en el manual/dashboard
- index.Rmd                      — archivo que genera el dashboard HTML (flexdashboard)
- index.html                     — dashboard ya renderizado
- log_final.txt

## Cómo ejecutar (ruta mínima desde un equipo con R instalado)
1. Coloca los archivos Excel exportados desde HR-Media en la carpeta raíz del proyecto:
   - `Programmes Seguimiento LE_2.xlsx`
   - `Time LE Franjas_2.xlsx`

2. Abrir el proyecto en RStudio (opcional): abrir `Seguimiento-LE.Rproj`.

3. Opciones para generar el dashboard:
   - Manual (desde una sesión R):
     ```r
     # desde la raíz del proyecto
     rmarkdown::render("index.Rmd")
     ```
   - Automatizado (Power Automate o tarea programada) utilizando el script `correr_dashLE.R`.
     - Antes de ejecutar `correr_dashLE.R` edita las rutas dentro del script para que apunten a tu instalación (líneas con `Sys.setenv()` y ruta del repo).
     - El script:
       - renderiza `index.Rmd`
       - ejecuta comandos git (pull, add, commit, push)
     - Comando ejemplo para ejecutar el script desde Rscript:
       ```
       Rscript correr_dashLE.R
       ```

4. Validación:
   - Verifica que `index.html` se actualizó en el repositorio y/o que la ejecución mostró el mensaje de éxito.
   - En el Manual se especifica una validación basada en duración (>40s) y mensajes de confirmación.

## Dependencias / paquetes (instalación recomendada)
Instala en R los paquetes necesarios (lista extraída de `index.Rmd`):
```r
install.packages(c("rio","shinydashboard","tidyverse","flexdashboard","reshape",
                   "dplyr","lubridate","ggplot2","tibble","data.table",
                   "reshape2","cowplot","shiny","kableExtra","knitr",
                   "gridExtra","readxl","stringr","formattable","caret",
                   "plotly","ggrepel","purrr","fpp2","zoo","tseries"))
```
Nota: algunos paquetes como `fpp2` requieren paquetes adicionales o versiones específicas de R.

## Automatización (Power Automate)
- El repo incluye instrucciones en `Manual Seguimiento LE.Rmd` sobre cómo configurar el flujo en Power Automate.
- El flujo típico:
  1. Actualizar y exportar las consultas desde HR-Media a los archivos Excel indicados.
  2. Ejecutar `correr_dashLE.R` (por Power Automate).
  3. El script genera `index.html` y realiza `git commit` / `git push`.
  4. Notificaciones por correo (según flujo configurado).

## Buenas prácticas y notas importantes
- No modificar `index.Rmd` si no se entiende la lógica del dashboard (advertencia en el manual).
- Mantener los nombres exactos de los archivos Excel como se indica.
- Antes de automatizar, probar el script manualmente y ajustar rutas absolutas en `correr_dashLE.R`.
- El script actual usa rutas absolutas tipo `C:/Seguimiento-LE` — cambiarlas si corresponde.

## Cómo contribuir
- Abrir un issue para discutir cambios importantes.
- Para tareas menores: crear una rama nueva, editar el archivo correspondiente y abrir un pull request.
- Si vas a cambiar `index.Rmd`, por favor documenta los cambios en el manual y verifica la ejecución completa.

## Preguntas frecuentes / Solución de problemas
- Q: El script falla al ejecutar git. A: Asegúrate de tener Git instalado y accesible desde la ruta en `correr_dashLE.R`. Configura credenciales o utiliza un token si es necesario.
- Q: El dashboard no muestra datos actualizados. A: Verifica que los archivos Excel en la raíz estén correctamente exportados y sin versiones antiguas.
- Q: Errores por paquetes faltantes. A: Instala los paquetes listados arriba y reinicia RStudio.

## Contacto
- Autor / Responsable: Mónica Olivares y Gustavo Garduño
- Repo: https://github.com/moonkey1995/Seguimiento-LE

## Licencia
- No se incluye un archivo de licencia en el repositorio. Añade un `LICENSE` si quieres clarificar derechos de uso.
