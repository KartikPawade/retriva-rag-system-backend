# =============================================================================
# Stage 1: BUILDER - Install all dependencies, then discard build tools
# =============================================================================
FROM python:3.13-slim AS builder

WORKDIR /build

# Install build-time system deps (compilers needed for some Python packages)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Install poetry
RUN pip install --no-cache-dir poetry

COPY pyproject.toml poetry.lock* ./

RUN poetry config virtualenvs.create false

# ---- KEY OPTIMIZATION: Install CPU-only PyTorch FIRST ----
# This prevents poetry/pip from pulling the CUDA version (~3-4GB of nvidia libs)
# PyTorch CPU wheel is ~200MB vs CUDA version at ~2.5GB + ~3GB nvidia libs
RUN pip install --no-cache-dir \
    torch torchvision \
    --index-url https://download.pytorch.org/whl/cpu

# Now run poetry install - torch is already satisfied so it won't re-download CUDA version
RUN poetry install --no-interaction --no-ansi --no-root

# =============================================================================
# Stage 2: RUNTIME - Only what's needed to run the app
# =============================================================================
FROM python:3.13-slim

WORKDIR /app

# Install ONLY runtime system dependencies (no compilers, no -dev packages)
RUN apt-get update && apt-get install -y --no-install-recommends \
    poppler-utils \
    tesseract-ocr \
    libmagic1 \
    libgl1 \
    libglib2.0-0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy installed Python packages from builder (no poetry, no compilers, no build artifacts)
COPY --from=builder /usr/local/lib/python3.13/site-packages /usr/local/lib/python3.13/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy application code
COPY . .

EXPOSE 8000
CMD ["uvicorn", "src.server:app", "--host", "0.0.0.0", "--port", "8000"]