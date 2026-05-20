# ── CONFIGURACIÓN NECESARIA PARA POWER AUTOMATE ────────────────────────────────
.libPaths(c(
  "C:/Users/gustavo.garduno/AppData/Local/R/win-library/4.5",
  "C:/Program Files/R/R-4.5.2/library"
))
Sys.setenv(HOME   = "C:/Seguimiento-LE")
Sys.setenv(R_USER = "C:/Seguimiento-LE")
Sys.setenv(TMPDIR = "C:/Seguimiento-LE/tmp")
Sys.setenv(TMP    = "C:/Seguimiento-LE/tmp")
Sys.setenv(TEMP   = "C:/Seguimiento-LE/tmp")
dir.create("C:/Seguimiento-LE/tmp", showWarnings = FALSE, recursive = TRUE)
rmarkdown::find_pandoc(
  dir   = "C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools",
  cache = FALSE
)
setwd("C:/Seguimiento-LE")

# ── 1. Renderizar el archivo .Rmd ──────────────────────────────────────────────
rmarkdown::render("index.Rmd")
print("¡Reporte generado exitosamente!")

# ── 2. Interactuar con Git ─────────────────────────────────────────────────────
GIT  <- '"C:/Program Files/Git/cmd/git.exe"'
repo <- "C:/Seguimiento-LE"

run_git <- function(args) {
  cmd <- paste0(GIT, ' -C "', repo, '" ', args)
  result <- system(cmd, intern = TRUE, ignore.stderr = FALSE)
  cat(result, sep = "\n")
  return(result)
}

print("Iniciando proceso de Git...")

# 0. Traer cambios del remoto (git pull)
print("Actualizando repositorio local ('git pull')...")
run_git("pull origin main")

# 1. Revisar estado
status <- system(paste0(GIT, ' -C "', repo, '" status'), intern = TRUE)
print("Estado del repositorio:")
print(status)

# 2. Añadir TODOS los archivos (equivalente a git_add("."))
print("Añadiendo archivos modificados ('git add')...")
run_git("add .")

# 3. Hacer el commit
commit_message <- paste("Reporte actualizado automaticamente el", Sys.Date())
print(paste("Haciendo 'git commit' con el mensaje:", commit_message))
run_git(paste0('commit -m "', commit_message, '"'))

# 4. Subir los cambios al repositorio remoto (git push)
print("Subiendo los cambios al remoto ('git push')...")
run_git("push origin main")

print("¡Proceso de Git finalizado exitosamente!")