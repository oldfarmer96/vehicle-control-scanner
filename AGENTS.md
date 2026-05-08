# AGENTS.md

## Contexto operativo de este workspace

- Este entorno tiene acceso operativo a `python`, `pip` y `conda`.
- Se pueden ejecutar builds, instalacion de dependencias y empaquetado `.exe` desde esta terminal.

## Que si puede hacer este agente

- Analizar contexto y documentacion del proyecto.
- Crear/editar estructura de codigo.
- Definir arquitectura inicial y mejores practicas.
- Preparar `requirements.txt`, `.env.example` y rutas API base.
- Ejecutar build con PyInstaller y crear instalador NSIS.

## Comandos que debes ejecutar tu (Miniconda + Python 3.12)

```bash
conda create --name scanner-ocr python=3.12 -y
conda activate scanner-ocr
pip install -r requirements.txt
uvicorn main:app --reload --app-dir src --host 0.0.0.0 --port 8001
```

Version esperada de Python en ese entorno: `3.12.13`.

## Validacion esperada

- `GET /` responde nombre/version de la app.
- `GET /health` responde `status: ok` y metadatos.

## Plan tecnico inmediato

1. Capa OCR (captura + deteccion + lectura).
2. Cola local de eventos con SQLite.
3. Reintentos HTTP con backoff y deduplicacion temporal por placa.
4. Accion de backup manual de SQLite (boton en app de escritorio).
5. Empaquetado a `.exe` cuando el flujo MVP este estable.

## Nota de empaquetado `.exe`

- Recomendado: PyInstaller en etapa de distribucion.
- Incluir carpeta de datos (`data/`) y backups (`backups/`) como rutas externas al ejecutable.
- Script build disponible: `scripts/build_exe.ps1`.
- Instalador NSIS disponible: `installer/vehicle-control-scanner.nsi`.
