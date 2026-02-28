import fastapi
from fastapi.middleware.cors import CORSMiddleware
from fastapi.exceptions import HTTPException
from routes import users, files, projects, chats


app = fastapi.FastAPI(
    title="Retriva RAG System Server",
    description="Server for the Retriva RAG System",
    version="0.1.0",
    docs_url="/docs",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(users.router)
app.include_router(projects.router)
app.include_router(files.router)
app.include_router(chats.router)

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/health")
async def health():

    return {"message": "server is healthy"}

