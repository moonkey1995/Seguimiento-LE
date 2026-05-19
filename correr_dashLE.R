
setwd("C:/Users/gustavo.garduno/OneDrive - Corporación Televisa, S.A. de C.V/2026/Seguimiento LE/Seguimiento-LE")



# 1. Renderizar el archivo .Rmd
# Esto creará un archivo .html en la misma carpeta
rmarkdown::render("index.Rmd")

# (Opcional) Mensaje de confirmación en la consola
print("¡Reporte generado exitosamente!")

library(gert)
# --- 2. Interactuar con Git ---
print("Iniciando proceso de Git...")

# 0. Traer cambios del remoto (git pull)
print("Actualizando repositorio local ('git pull')...")
git_pull(rebase = TRUE)


# 1. Revisar estado
# Devuelve un data frame con los archivos modificados, nuevos, etc.
status <- git_status()
print("Estado del repositorio:")
print(status)


# 3. Añadir los archivos al "staging area" (como 'git add')
# Vamos a añadir el reporte HTML que acabamos de generar.
# También podríamos añadir el propio .Rmd si lo hemos modificado.
print("Añadiendo archivos modificados ('git add')...")
git_add(".") 

# 4. Hacer el commit (como 'git commit')
# Creamos un mensaje de commit dinámico con la fecha.
commit_message <- paste("Reporte actualizado automáticamente el", Sys.Date())
print(paste("Haciendo 'git commit' con el mensaje:", commit_message))

git_commit(message = commit_message)

# 5. Subir los cambios al repositorio remoto (como 'git push')
print("Subiendo los cambios al remoto ('git push')...")
git_push()

print("¡Proceso de Git finalizado exitosamente!")
