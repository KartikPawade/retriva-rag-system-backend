<div align="center">

<br/>

<!-- Animated Title -->
<h1>
  <img src="https://readme-typing-svg.demolab.com?font=Orbitron&weight=900&size=42&duration=3000&pause=1000&color=6366F1&center=true&vCenter=true&width=600&lines=Retriva+RAG+System" alt="Retriva RAG System" />
</h1>

<p>
  <img src="https://img.shields.io/badge/-%E2%9A%A1%20Production--Ready%20RAG%20Backend-6366f1?style=for-the-badge&labelColor=0f0f0f&color=6366f1" />
</p>

<h3>
  <p>A production-ready RAG system built for accuracy — remembers context, supports web search, configurable retrieval strategies, guradrails for multi-agents flow along with RAG agent, multimodal support for images & tables across different formats, smart chunking for accuracy, and high RAGAS evaluation scores.</p>
</h3>

<br/>

<!-- Badges Row -->
<p>
  <img src="https://img.shields.io/badge/Python-3.10+-3776AB?style=flat-square&logo=python&logoColor=white" />
  <img src="https://img.shields.io/badge/FastAPI-009688?style=flat-square&logo=fastapi&logoColor=white" />
  <img src="https://img.shields.io/badge/RAG-Powered-6366f1?style=flat-square&logo=openai&logoColor=white" />
  <img src="https://img.shields.io/badge/Vector_DB-Ready-10b981?style=flat-square&logo=databricks&logoColor=white" />
  <img src="https://img.shields.io/badge/🤖 Agentic_RAG-Enabled-7c3aed?style=flat-square" />
  <img src="https://img.shields.io/badge/🎯 Accuracy-High-16a34a?style=flat-square" />
  <img src="https://img.shields.io/badge/🌐 Web_Search-Enabled-0ea5e9?style=flat-square&logo=googlechrome&logoColor=white" />
  <img src="https://img.shields.io/badge/🦜 LangChain-Integrated-1c3f59?style=flat-square&logo=chainlink&logoColor=white" />
  <img src="https://img.shields.io/badge/🕸️ LangGraph-Integrated-ef4444?style=flat-square" />
  <img src="https://img.shields.io/badge/🧠 Multi_Agent_RAG-Powered-8b5cf6?style=flat-square" />
  <img src="https://img.shields.io/badge/✅ High_Accuracy-Optimized-22c55e?style=flat-square" />
  <img src="https://img.shields.io/badge/🖼️ Multimodal-Supported-f59e0b?style=flat-square&logo=files&logoColor=white" />
</p>

<br/>



<!-- CTA Buttons --
<a href="https://retriva-rag-system-client.vercel.app/">
  <img src="https://img.shields.io/badge/🌐 Live Website-Visit Now-6366f1?style=for-the-badge&labelColor=0f0f0f" />
</a>
-->
&nbsp;
<a href="https://www.loom.com/share/d673ed7d86e441b688230eba1c4b18a7">
  <img src="https://img.shields.io/badge/▶ Watch Demo-Loom Video-e11d48?style=for-the-badge&labelColor=0f0f0f" />
</a>

<br/>
</div>

---

## ✨ Key Features

| Feature | Description |
|---|---|
| 📄 **Multi-format Ingestion** | PDF, DOCX, PPTX, TXT, MD, HTML — and live URLs via web crawling |
| 🧠 **4 RAG Strategies** | Basic Vector · Hybrid · Multi-Query Vector · Multi-Query Hybrid |
| 🤖 **Two Agent Modes** | Simple RAG Agent and Agentic Supervisor with Web Search |
| 🛡️ **Input Guardrails** | Toxic content · Prompt injection · PII detection — before any LLM call |
| 🖼️ **Multimodal RAG** | Retrieves and reasons over text, tables, and images together |
| 📚 **Citations** | Every answer traces back to source document + page number |
| ⚡ **Async Processing** | Celery + Redis queue — document ingestion runs fully in the background |
| 🔐 **Auth** | Clerk JWT authentication with per-request user context |
| 📊 **Structured Logging** | structlog JSON logs with request\_id · user\_id · project\_id on every line |
| 📏 **RAG Evaluation** | RAGAS framework integration for measuring retrieval quality |

---


```
                                👤 User
                                   │
                                   ▼
                              ⚡ FastAPI
                             /          \
                   File / URL            Chat Message
                        /                      \
                       ▼                        ▼
              🌿 Celery + Redis          🕸️ LangGraph Agent
              (Async Ingestion)               /       \
                       │               Simple RAG   🧠 Supervisor
                       ▼                   │          /         \
              📥 Ingestion Pipeline         │   📚 RAG        🌐 Web
              │                            │   Sub-Agent     Sub-Agent
              ├── 📝 Text                  │   (pgvector)    (Tavily /
              ├── 📊 Tables                │                  DuckDuckGo)
              └── 🖼️  Images               │          \         /
                       │                  │           Synthesize
                       ▼                  │                │
       ✂️  Chunk → Summarize + original   │                │
              🧠 GPT-4o (tables/images)   │                │
              🔢 Embed (1536-dim)         │                │
                       │                  └────────────────┘
                       └──────────────────────────┬──────────────────
                                                  ▼
                                     🐘 Supabase + pgvector
                                  (document_chunks · vector · fts)
```
---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| **API** | FastAPI · Uvicorn · Pydantic |
| **Auth** | Clerk (JWT) |
| **Database** | Supabase (PostgreSQL + pgvector) |
| **File Storage** | AWS S3 |
| **Task Queue** | Celery · Redis |
| **Document Parsing** | Unstructured |
| **Web Crawling** | ScrapingBee |
| **LLM & Embeddings** | OpenAI (GPT-4o · text-embedding-3-large 1536) |
| **Agent Framework** | LangChain · LangGraph |
| **Web Search** | Tavily · DuckDuckGo |
| **Logging** | structlog |
| **Evaluation** | RAGAS |

---

## 📥 Ingestion Pipeline

> Triggered asynchronously via Celery when a file or URL is confirmed.

```mermaid
flowchart TD

    USER(["👤 User"]) -->|Upload File or URL| API["⚡ FastAPI"]

    API -->|Queue Task| CELERY["🌿 Celery + Redis\nAsync Task Queue"]

    CELERY --> ACQUIRE{"Source Type?"}

    ACQUIRE -->|file| S3["☁️ Download from S3"]
    ACQUIRE -->|url| CRAWL["🕷️ Crawl with ScrapingBee"]

    S3 --> PARTITION{"📄 File Type?"}
    CRAWL --> PARTITION

    PARTITION -->|pdf| PDF["partition_pdf\nhi_res · tables · images"]
    PARTITION -->|docx| DOCX["partition_docx\nhi_res · tables"]
    PARTITION -->|pptx| PPTX["partition_pptx\nhi_res · tables"]
    PARTITION -->|txt| TXT["partition_text"]
    PARTITION -->|md| MD["partition_md"]
    PARTITION -->|html / url| HTML["partition_html"]

    PDF --> ELEMENTS["🧩 Unstructured Elements\nTitle · NarrativeText · Table · Image"]
    DOCX --> ELEMENTS
    PPTX --> ELEMENTS
    TXT --> ELEMENTS
    MD --> ELEMENTS
    HTML --> ELEMENTS

    ELEMENTS --> CHUNK["✂️ Semantic Chunking\nchunk_by_title\nmax 3000 chars"]

    CHUNK --> SUMMARIZE{"Has Table\nor Image?"}

    SUMMARIZE -->|Yes| AI["🤖 GPT-4o\nAI Summary"]
    SUMMARIZE -->|No| RAW["📝 Raw Text"]

    AI --> EMBED
    RAW --> EMBED

    EMBED["🧠 OpenAI Embeddings\ntext-embedding-3-large\n1536 dimensions"]

    EMBED --> STORE[("🐘 Supabase pgvector\ndocument_chunks")]

    STORE -->|status updates throughout| DB[("🗄️ Supabase\nprocessing_status")]
```

**Processing stages tracked in real-time:**
`uploading` → `partitioning` → `chunking` → `summarising` → `vectorization` → `completed`

---

## 🔍 RAG Retrieval — 4 Strategies

Configurable per project via `project_settings`:

| Strategy | How it works |
|---|---|
| `basic` | Vector similarity search only |
| `hybrid` | Vector + full-text keyword search, fused with RRF |
| `multi-query-vector` | LLM generates N query variations → vector search → RRF |
| `multi-query-hybrid` | LLM generates N query variations → hybrid search → RRF |

> **RRF (Reciprocal Rank Fusion)** merges ranked lists from multiple searches with configurable `vector_weight` and `keyword_weight`.

---

## 🤖 Agent Modes

### Mode 1 — Simple RAG Agent

Best for: **project document Q&A**

```mermaid
flowchart TD

    USER(["👤 User"]) -->|send message| API["⚡ FastAPI"]

    API --> SETUP["Load project_settings\nLoad chat history"]
    SETUP --> GRAPH

    subgraph GRAPH ["🕸️ LangGraph — Simple RAG Agent"]

        START_NODE(["START"]) --> GUARDRAIL

        GUARDRAIL["🛡️ Guardrail Node\nGPT-4o-mini\nCheck: toxic · injection · PII"]

        GUARDRAIL -->|unsafe| REJECT(["❌ Reject → END"])
        GUARDRAIL -->|safe| AGENT

        AGENT["🤖 RAG Agent — GPT-4o\nChat history injected\nMust call rag_search tool"]

        AGENT -->|calls tool| RAG_TOOL

        subgraph RAG_TOOL ["📚 RAG Tool — retrieve_context"]
            R1["Vector · Hybrid\nMulti-Query · RRF\nTop K chunks"]
            R1 --> R2["prepare_prompt_and_invoke_llm\ntext · tables · images\nGPT-4o grounded answer"]
        end

        RAG_TOOL -->|ToolMessage + citations| AGENT
        AGENT -->|done| END_NODE(["END"])
    end

    END_NODE --> SAVE["Save to Supabase\nmessages table"]
    SAVE --> RESPONSE["📤 Response\nanswer + citations"]
```

---

### Mode 2 — Agentic RAG (Supervisor)

Best for: **complex queries needing both internal docs and live web search**

The Supervisor intelligently decides whether to search project documents, the web, or both — then synthesizes the results into a single coherent answer.

```mermaid
flowchart TD

    USER(["👤 User"]) -->|send message| API["⚡ FastAPI"]

    API --> SETUP["Load project_settings\nLoad chat history"]
    SETUP --> GRAPH

    subgraph GRAPH ["🕸️ LangGraph — Supervisor Agent"]

        START_NODE(["START"]) --> GUARDRAIL

        GUARDRAIL["🛡️ Guardrail Node\nGPT-4o-mini\nCheck: toxic · injection · PII"]

        GUARDRAIL -->|unsafe| REJECT(["❌ Reject → END"])
        GUARDRAIL -->|safe| SUPERVISOR

        SUPERVISOR["🧠 Supervisor — GPT-4o\nCurrent date + chat history\nDecides which tools to call"]

        SUPERVISOR -->|project docs query| RAG_TOOL
        SUPERVISOR -->|web info needed| WEB_TOOL
        SUPERVISOR -->|greeting only| DIRECT(["💬 Direct Reply"])

        subgraph RAG_TOOL ["📚 RAG Sub-Agent"]
            R1["retrieve_context\nVector · Hybrid\nMulti-Query · RRF"]
            R1 --> R2["GPT-4o\nGrounded answer\n+ citations"]
        end

        subgraph WEB_TOOL ["🌐 Web Sub-Agent"]
            W1["Tavily / DuckDuckGo\nSearch internet"]
            W1 --> W2["GPT-4o\nSynthesized\nweb answer"]
        end

        RAG_TOOL -->|ToolMessage + citations| SYNTHESIZE
        WEB_TOOL -->|ToolMessage| SYNTHESIZE

        SYNTHESIZE["📝 Supervisor\nCombines results\nFinal answer"]
        SYNTHESIZE --> END_NODE(["END"])
    end

    END_NODE --> SAVE["Save to Supabase\nmessages table"]
    SAVE --> RESPONSE["📤 Response\nanswer + citations"]
```

---

## 🗄️ Database Schema

```
users
 └── projects
      ├── project_settings   (rag_strategy · agent_type · thresholds · weights)
      ├── project_documents  (s3_key · source_url · processing_status · processing_details)
      │    └── document_chunks  (content · embedding vector(1536) · fts tsvector · original_content · page_number)
      └── chats
           └── messages      (role · content · created_at)
```

---

## 📁 Project Structure

```
src/
├── server.py                  # FastAPI app, middleware, routes
├── config/                    # Settings, structured logging
├── middleware/                # Request logging middleware
├── models/                    # Pydantic models & enums
├── routes/                    # userRoutes · projectRoutes · projectFilesRoutes · chatRoutes
├── services/                  # supabase · celery · awsS3 · clerkAuth · llm · webScrapper
├── rag/
│   ├── ingestion/             # process_document · partition · chunk · summarise · vectorize
│   └── retrieval/             # retrieve_context · vector/hybrid/multi-query search · RRF
└── agents/
    ├── simple_agent/          # LangGraph RAG agent with guardrails
    └── supervisor_agent/      # LangGraph multi-agent supervisor
```

---
