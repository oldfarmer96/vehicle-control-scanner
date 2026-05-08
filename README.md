# vehicle-control-scanner

Base inicial del proyecto `vehicle-control-scanner` orientado a OCR de placas y envio de eventos al backend.

## Estado actual

- API base creada con FastAPI.
- Ruta `GET /` devuelve nombre de app y version.
- Ruta `GET /health` devuelve estado de salud del servicio.
- Configuracion central por variables de entorno.
- Estructura preparada para crecer con OCR, SQLite y backup.

## Estructura

```txt
src/
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

## Siguiente paso recomendado

Implementar modulos:

- OCR pipeline (captura + deteccion + lectura).
- Cola de envio con reintentos.
- Persistencia SQLite.
- Backup de SQLite accionable desde UI (boton en app de escritorio).
