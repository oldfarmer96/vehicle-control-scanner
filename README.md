# vehicle-control-scanner

Base inicial del proyecto `vehicle-control-scanner` orientado a OCR de placas y envio de eventos al backend.

## Estado actual

- API base creada con FastAPI.
- Ruta `GET /` devuelve nombre de app y version.
- Ruta `GET /health` devuelve estado de salud del servicio.
- Configuracion central por variables de entorno.
- Estructura preparada para crecer con OCR, SQLite y backup.
- Flujo de empaquetado `.exe` y setup NSIS listo.

## Estructura

```txt
src/
  launcher.py
  api/
    routes/
      health.py
      root.py
  core/
    config.py
  main.py
```

## Ejecucion (Miniconda, Python 3.12)

```bash
conda create --name scanner-ocr python=3.12 -y
conda activate scanner-ocr
pip install -r requirements.txt
uvicorn main:app --reload --app-dir src --host 0.0.0.0 --port 8001
```

Version esperada de Python en ese entorno: `3.12.13`.

## Endpoints iniciales

- `GET /`
- `GET /health`

## Makefile

Puedes correr el servidor con:

```bash
make dev
```

Build de ejecutable:

```bash
make build-exe
```

Build de instalador NSIS:

```bash
make build-setup
```

## Empaquetado para Windows

- El ejecutable se construye con PyInstaller usando `src/launcher.py`.
- El launcher crea/usa estas rutas persistentes:
  - `C:/ProgramData/vehicle-control-scanner/data`
  - `C:/ProgramData/vehicle-control-scanner/backups`
  - `C:/ProgramData/vehicle-control-scanner/logs`
- Si no existe `.env` en ProgramData, se crea desde `.env.example`.

Archivos clave:

- `installer/vehicle-control-scanner.spec`
- `scripts/build_exe.ps1`
- `installer/vehicle-control-scanner.nsi`
- `assets/app.ico`
- `docs/WINDOWS_BUILD_AND_INSTALLER.md`

### Salidas esperadas

- Ejecutable: `dist/vehicle-control-scanner/vehicle-control-scanner.exe`
- Instalador: `dist/VehicleControlScanner-Setup-0.1.0.exe`

### Comandos directos (sin Make)

```bash
conda run -n scanner-ocr python -m pip install -r requirements.txt -r requirements-build.txt
conda run -n scanner-ocr pyinstaller --noconfirm --clean installer/vehicle-control-scanner.spec
makensis installer/vehicle-control-scanner.nsi
```

## Siguiente paso recomendado

Implementar modulos:

- OCR pipeline (captura + deteccion + lectura).
- Cola de envio con reintentos.
- Persistencia SQLite.
- Backup de SQLite accionable desde UI (boton en app de escritorio).
