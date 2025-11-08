# Claude Code Plugin and Agent System Analysis

## Executive Summary

Your Claude Code installation has 4 installed plugins from the `wshobson/agents` marketplace, providing access to 10 specialized agents and 13 skills. The configuration is properly managed with a symlinked settings file in your dotfiles, though there's evidence of cleanup that removed old plugin and skill data.

## Directory Structure

### Active Claude Code Directory: `~/.claude/`

```
~/.claude/
├── settings.json                          # Main Claude settings (managed by system)
├── settings.local.json -> ../dotfiles/... # Symlinked to dotfiles (user settings)
├── plugins/
│   ├── installed_plugins.json            # Registry of installed plugins
│   ├── known_marketplaces.json          # Marketplace configurations
│   └── marketplaces/
│       └── claude-code-workflows/       # Git repo: wshobson/agents
│           ├── plugins/                 # 63 available plugins
│           │   ├── data-engineering/
│           │   ├── machine-learning-ops/
│           │   ├── python-development/
│           │   └── shell-scripting/
│           └── .claude-plugin/
│               └── marketplace.json     # Plugin catalog
├── projects/                            # Project-specific configs
├── todos/                              # Task tracking
├── history.jsonl                       # Command history
└── debug/                              # Debug logs
```

### Dotfiles Claude Directory: `/Users/jack/dotfiles/claude/`

```
/Users/jack/dotfiles/claude/.claude/
└── settings.local.json                 # User-specific settings (empty)
```

**Note**: Most files in `/Users/jack/dotfiles/claude/.claude/` were deleted (shown as `D` in git status), including:
- Old plugin configurations
- Community skills (collaboration, debugging, problem-solving, etc.)
- Commands and tools
- Plugin marketplace directories

## Installed Plugins

### 1. Python Development (`python-development@claude-code-workflows`)

**Installation Details:**
- Version: unknown
- Installed: 2025-11-05
- Path: `/Users/jack/.claude/plugins/marketplaces/claude-code-workflows/plugins/python-development`
- Git Commit: 51c85a8

**Agents (3):**

#### python-pro
- **Description**: Master Python 3.12+ with modern features, async programming, performance optimization, and production-ready practices
- **Capabilities**:
  - Python 3.12+ features (pattern matching, improved error messages, type system)
  - Modern tooling: uv, ruff, pyright, mypy
  - Testing: pytest, Hypothesis, pytest-cov
  - Web frameworks: FastAPI, Django, Flask
  - Data science: NumPy, Pandas, Scikit-learn
  - DevOps: Docker, Kubernetes, cloud deployment
  - Advanced patterns: SOLID, design patterns, metaprogramming
- **Use Cases**: General Python development, optimization, advanced patterns

#### fastapi-pro
- **Description**: Build high-performance async APIs with FastAPI, SQLAlchemy 2.0, and Pydantic V2
- **Capabilities**:
  - FastAPI 0.100+ with async/await patterns
  - Pydantic V2 validation and serialization
  - SQLAlchemy 2.0+ async support
  - Authentication: OAuth2, JWT, RBAC
  - Testing: pytest-asyncio, TestClient
  - Performance: caching, query optimization, batching
  - Deployment: Docker, Kubernetes, ASGI servers
- **Use Cases**: FastAPI development, async optimization, API architecture

#### django-pro
- **Description**: Master Django 5.x with async views, DRF, Celery, and Django Channels
- **Capabilities**:
  - Django 5.x with async views and ORM
  - Django REST Framework (DRF)
  - Testing: pytest-django, factory_boy
  - Background tasks: Celery, Redis
  - Real-time: Django Channels, WebSockets
  - Security: CSRF, XSS, SQL injection prevention
  - Deployment: Gunicorn, Docker, cloud platforms
- **Use Cases**: Django development, ORM optimization, complex Django patterns

**Skills (5):**
- `async-python-patterns`: AsyncIO and concurrent programming
- `python-testing-patterns`: Pytest, fixtures, mocking, TDD
- `python-packaging`: Creating distributable packages, PyPI publishing
- `python-performance-optimization`: Profiling, optimization, bottleneck analysis
- `uv-package-manager`: Fast dependency management with uv

**Commands (1):**
- `python-scaffold`: Project scaffolding tool

---

### 2. Data Engineering (`data-engineering@claude-code-workflows`)

**Installation Details:**
- Version: unknown
- Installed: 2025-11-05
- Path: `/Users/jack/.claude/plugins/marketplaces/claude-code-workflows/plugins/data-engineering`
- Git Commit: 51c85a8

**Agents (2):**

#### data-engineer
- **Description**: Build scalable data pipelines, modern data warehouses, and real-time streaming architectures
- **Capabilities**:
  - Modern data stack: dbt, Fivetran, Snowflake, BigQuery
  - Batch processing: Apache Spark, Airflow, Databricks
  - Streaming: Kafka, Flink, Kinesis
  - Data lakehouse: Delta Lake, Iceberg, Hudi
  - Cloud platforms: AWS, Azure, GCP data services
  - Data quality: Great Expectations, data validation
  - Workflow orchestration: Airflow, Prefect, Dagster
- **Use Cases**: Data pipeline design, analytics infrastructure, modern data stack

#### backend-architect
- **Description**: Expert backend architect for scalable API design, microservices, and distributed systems
- **Capabilities**:
  - API design: REST, GraphQL, gRPC, WebSockets
  - Microservices: service boundaries, communication patterns
  - Event-driven: Kafka, RabbitMQ, pub/sub patterns
  - Authentication: OAuth2, JWT, mTLS, RBAC
  - Resilience: circuit breakers, retries, timeouts
  - Observability: logging, metrics, tracing
  - Performance: caching, async processing, load balancing
- **Use Cases**: Backend service design, API architecture, microservices

**Skills:** None

**Commands:** Available but not documented in the file structure

---

### 3. Machine Learning Operations (`machine-learning-ops@claude-code-workflows`)

**Installation Details:**
- Version: unknown
- Installed: 2025-11-05
- Path: `/Users/jack/.claude/plugins/marketplaces/claude-code-workflows/plugins/machine-learning-ops`
- Git Commit: 51c85a8

**Agents (3):**

#### data-scientist
- **Description**: Expert data scientist for advanced analytics, ML, and statistical modeling
- **Capabilities**:
  - Statistical analysis: hypothesis testing, A/B testing, causal inference
  - Machine learning: supervised/unsupervised, deep learning
  - Programming: Python (pandas, NumPy, scikit-learn), R, SQL
  - Visualization: matplotlib, seaborn, plotly, dashboards
  - Business analytics: marketing, finance, operations
  - NLP, computer vision, graph analytics
  - Model deployment: MLflow, APIs, cloud platforms
- **Use Cases**: Data analysis, ML modeling, statistical analysis, business insights

#### ml-engineer
- **Description**: Build production ML systems with PyTorch 2.x, TensorFlow, and modern frameworks
- **Capabilities**:
  - ML frameworks: PyTorch 2.x, TensorFlow 2.x, JAX
  - Model serving: TensorFlow Serving, TorchServe, BentoML
  - Feature stores: Feast, Tecton
  - Distributed training: Horovod, Ray, DeepSpeed
  - Cloud ML: SageMaker, Azure ML, Vertex AI
  - Model optimization: quantization, pruning, distillation
  - Testing: pytest-asyncio, model validation
- **Use Cases**: ML model deployment, inference optimization, production ML

#### mlops-engineer
- **Description**: Build comprehensive ML pipelines with MLflow, Kubeflow, and MLOps tools
- **Capabilities**:
  - Pipeline orchestration: Kubeflow, Airflow, Prefect
  - Experiment tracking: MLflow, W&B, Neptune
  - Model registry: MLflow, DVC, cloud registries
  - Cloud platforms: AWS, Azure, GCP MLOps stacks
  - Kubernetes: ML workloads, KServe, Kubeflow
  - Infrastructure as Code: Terraform, CloudFormation
  - Monitoring: drift detection, model performance
- **Use Cases**: ML infrastructure, experiment management, pipeline automation

**Skills (1):**
- `ml-pipeline-workflow`: End-to-end MLOps pipelines

**Commands:** Available but not documented

---

### 4. Shell Scripting (`shell-scripting@claude-code-workflows`)

**Installation Details:**
- Version: unknown
- Installed: 2025-11-05
- Path: `/Users/jack/.claude/plugins/marketplaces/claude-code-workflows/plugins/shell-scripting`
- Git Commit: 51c85a8

**Agents (2):**

#### bash-pro
- **Description**: Master of defensive Bash scripting for production automation and CI/CD
- **Capabilities**:
  - Defensive programming: strict error handling, `set -Eeuo pipefail`
  - Safe patterns: proper quoting, input validation, trap cleanup
  - Modern Bash 5.x features
  - Testing: Bats framework, shellspec
  - Static analysis: ShellCheck, shfmt
  - CI/CD integration: GitHub Actions, pre-commit
  - Performance optimization
  - Security: input sanitization, injection prevention
- **Use Cases**: Production automation, CI/CD pipelines, system utilities

#### posix-shell-pro
- **Description**: Expert in strict POSIX sh for maximum portability
- **Capabilities**:
  - POSIX compliance: works on dash, ash, sh, bash --posix
  - Portable patterns: no arrays, no `[[`, no bash-specific features
  - Cross-platform: Linux, BSD, Solaris, macOS, Alpine
  - BusyBox compatibility for embedded systems
  - Testing: dash, ash validation
  - Static analysis: ShellCheck POSIX mode, checkbashisms
- **Use Cases**: Portable shell scripts, embedded systems, cross-platform utilities

**Skills (3):**
- `bash-defensive-patterns`: Production-grade Bash scripting
- `bats-testing-patterns`: Comprehensive shell script testing
- `shellcheck-configuration`: Static analysis setup

**Commands:** None

---

## Plugin Marketplace

### Claude Code Workflows Marketplace

**Source**: `wshobson/agents` (GitHub repository)
- **Total plugins available**: 63 plugins
- **Total agents available**: 85 specialized agents
- **Total skills available**: 47 agent skills
- **Total commands/tools**: 44 development tools
- **Last updated**: 2025-11-05
- **Repository**: https://github.com/wshobson/agents

**Categories (23):**
- Development (4): debugging, backend, frontend, multi-platform
- Documentation (2): code docs, API specs
- Workflows (3): git, full-stack, TDD
- Testing (2): unit testing, TDD workflows
- Quality (3): code review, performance
- AI & ML (4): LLM apps, agent orchestration, MLOps
- Data (2): data engineering, validation
- Database (2): design, migrations
- Operations (4): incident response, diagnostics, observability
- Performance (2): application, database/cloud optimization
- Infrastructure (5): deployment, Kubernetes, cloud, CI/CD
- Security (4): scanning, compliance, backend/frontend
- Languages (7): Python, JS/TS, systems, JVM, scripting, functional, embedded
- Blockchain (1): smart contracts, DeFi, Web3
- Finance (1): quantitative trading
- Payments (1): Stripe, PayPal
- Gaming (1): Unity, Minecraft
- Marketing (4): SEO content, technical SEO
- Business (3): analytics, HR/legal, sales

**Notable Available Plugins** (not installed):
- `javascript-typescript`: JS/TS development with 4 skills
- `backend-development`: Backend APIs with 3 architecture skills
- `kubernetes-operations`: K8s with 4 deployment skills
- `cloud-infrastructure`: AWS/Azure/GCP with 4 cloud skills
- `security-scanning`: SAST with security skill
- `code-review-ai`: AI-powered code review
- `full-stack-orchestration`: Multi-agent workflows
- `llm-application-dev`: LangChain, RAG, prompt engineering
- `frontend-mobile-development`: React, Vue, React Native
- `database-design`: Database architecture and optimization

---

## Configuration Files

### 1. Installed Plugins (`~/.claude/plugins/installed_plugins.json`)

```json
{
  "version": 1,
  "plugins": {
    "data-engineering@claude-code-workflows": {
      "version": "unknown",
      "installedAt": "2025-11-05T00:50:36.564Z",
      "lastUpdated": "2025-11-05T00:50:36.564Z",
      "installPath": "~/.claude/plugins/marketplaces/claude-code-workflows/plugins/data-engineering",
      "gitCommitSha": "51c85a89771ef6ae2d7e8996c66c953f741caff4",
      "isLocal": true
    },
    // ... (3 more plugins)
  }
}
```

### 2. Known Marketplaces (`~/.claude/plugins/known_marketplaces.json`)

```json
{
  "claude-code-workflows": {
    "source": {
      "source": "github",
      "repo": "wshobson/agents"
    },
    "installLocation": "~/.claude/plugins/marketplaces/claude-code-workflows",
    "lastUpdated": "2025-11-05T00:43:59.579Z"
  }
}
```

### 3. Main Settings (`~/.claude/settings.json`)

```json
{
  "enabledPlugins": {
    "data-engineering@claude-code-workflows": true,
    "machine-learning-ops@claude-code-workflows": true,
    "python-development@claude-code-workflows": true,
    "shell-scripting@claude-code-workflows": true
  }
}
```

### 4. Local Settings (`~/.claude/settings.local.json` -> dotfiles)

**File**: `/Users/jack/dotfiles/claude/.claude/settings.local.json`
**Content**: `{}` (empty, available for user customization)

---

## Integration with Dotfiles

### Current Setup

1. **Symlink Configuration**:
   - `~/.claude/settings.local.json` -> `../dotfiles/claude/.claude/settings.local.json`
   - This allows user settings to be version-controlled in dotfiles

2. **Deleted from Dotfiles**:
   - Old plugin configurations (`installed_plugins.json`, `known_marketplaces.json`)
   - Marketplace directories (multiple marketplaces)
   - Community skills (collaboration, debugging, problem-solving, etc.)
   - Commands and custom tools
   - Neovim configuration (moved elsewhere)

3. **What Remains in Dotfiles**:
   - Empty `settings.local.json` file (for future customization)
   - Git history of previous configurations

### Recommendations

#### Current State Analysis

**Conflicts**: None detected
- Settings are properly separated between system-managed (`settings.json`) and user-managed (`settings.local.json`)
- Plugin data lives in `~/.claude/plugins/` (not in dotfiles)
- No duplicated or conflicting configurations

**Directory Relationship**:
```
~/.claude/                           # System-managed Claude Code directory
├── settings.json                    # Managed by Claude Code (don't version control)
├── settings.local.json -> dotfiles  # User overrides (version control this)
├── plugins/                         # Managed by Claude Code (don't version control)
├── history.jsonl                    # Local session data (don't version control)
└── ...

/Users/jack/dotfiles/claude/.claude/
└── settings.local.json              # User settings (empty currently)
```

#### Configuration Recommendations

1. **Keep Current Setup**:
   - The symlink approach is correct
   - Plugin installations should remain in `~/.claude/plugins/` (not in dotfiles)
   - Only `settings.local.json` should be in dotfiles

2. **Settings.local.json Usage**:
   - Use this file to override Claude Code settings
   - Examples of what to put here:
     ```json
     {
       "theme": "dark",
       "fontSize": 14,
       "customShortcuts": {},
       "preferredModel": "sonnet"
     }
     ```

3. **Do NOT Version Control**:
   - `~/.claude/plugins/` (managed by plugin system)
   - `~/.claude/history.jsonl` (session data)
   - `~/.claude/settings.json` (system managed)
   - `~/.claude/debug/` (debug logs)
   - `~/.claude/projects/` (project-specific data)

4. **Git Configuration**:
   Add to `/Users/jack/dotfiles/.gitignore`:
   ```
   # Claude Code - don't version control these
   claude/.claude/plugins/
   claude/.claude/commands/
   claude/.claude/skills/
   claude/.claude/*.jsonl
   claude/.claude/debug/
   claude/.claude/projects/
   ```

5. **Stow Configuration**:
   The cleanup you did was correct. Old plugin data and skills should not be in dotfiles.

---

## Skills System

### What are Skills?

Skills are modular knowledge packages that follow a progressive disclosure architecture:

1. **Metadata** (always loaded): Name and activation criteria
2. **Instructions** (loaded when activated): Core guidance
3. **Resources** (on-demand): Examples and templates

### Available Skills (13 total)

**Python Development (5):**
- `async-python-patterns`: AsyncIO, concurrent programming, async/await
- `python-testing-patterns`: pytest, fixtures, mocking, TDD
- `python-packaging`: Distributable packages, PyPI publishing
- `python-performance-optimization`: Profiling, optimization techniques
- `uv-package-manager`: Modern Python package management

**Machine Learning (1):**
- `ml-pipeline-workflow`: End-to-end MLOps pipelines

**Shell Scripting (3):**
- `bash-defensive-patterns`: Production-grade Bash scripting
- `bats-testing-patterns`: Shell script testing
- `shellcheck-configuration`: Static analysis setup

**Data Engineering (0):**
- No skills in this plugin currently

**Backend Architecture (0):**
- No skills in backend-architect plugin currently

### Skills vs Agents

**Agents**: Full specialized personas with comprehensive capabilities
- Loaded into conversation context
- Can be invoked directly
- Have behavioral traits and knowledge bases
- Example: `python-pro`, `fastapi-pro`

**Skills**: Modular knowledge packages that extend agent capabilities
- Loaded progressively when needed
- Invoked automatically based on context
- Provide specialized guidance within a domain
- Example: `async-python-patterns`, `python-testing-patterns`

---

## Agent Catalog by Use Case

### Python Development

**General Python Work**:
- Agent: `python-pro`
- Skills: All 5 Python skills
- Use for: Modern Python 3.12+, tooling, general development

**FastAPI APIs**:
- Agent: `fastapi-pro`
- Skills: `async-python-patterns`, `python-testing-patterns`
- Use for: Async APIs, microservices, WebSockets

**Django Applications**:
- Agent: `django-pro`
- Skills: `python-testing-patterns`
- Use for: Django 5.x, DRF, async views, ORM optimization

### Data & Analytics

**Data Pipelines**:
- Agent: `data-engineer`
- Skills: None (but comprehensive built-in knowledge)
- Use for: ETL/ELT, streaming, batch processing, data warehouses

**Data Science & ML**:
- Agent: `data-scientist`
- Skills: None
- Use for: Statistical analysis, ML modeling, visualization

**ML Production Systems**:
- Agent: `ml-engineer`
- Skills: `ml-pipeline-workflow`
- Use for: Model serving, inference optimization, feature engineering

**MLOps Infrastructure**:
- Agent: `mlops-engineer`
- Skills: `ml-pipeline-workflow`
- Use for: ML pipelines, experiment tracking, cloud ML platforms

### Backend Architecture

**API Design**:
- Agent: `backend-architect`
- Skills: None
- Use for: REST/GraphQL/gRPC, microservices, event-driven architecture

### Shell Scripting

**Production Bash Scripts**:
- Agent: `bash-pro`
- Skills: `bash-defensive-patterns`, `bats-testing-patterns`, `shellcheck-configuration`
- Use for: CI/CD pipelines, automation, system utilities

**Portable Shell Scripts**:
- Agent: `posix-shell-pro`
- Skills: `bash-defensive-patterns`, `shellcheck-configuration`
- Use for: Cross-platform scripts, embedded systems, BusyBox

---

## Agent Invocation Examples

### Direct Agent Invocation

```
Use the python-pro agent to help me set up a modern Python project with uv, ruff, and pytest
```

```
Use the fastapi-pro agent to design a high-performance API with async SQLAlchemy
```

```
Use the data-engineer agent to design a real-time data pipeline with Kafka and Spark
```

### Skills Activation

Skills are typically activated automatically based on context, but you can request them:

```
Show me async Python patterns for this code (activates async-python-patterns skill)
```

```
Help me set up pytest with fixtures and mocking (activates python-testing-patterns skill)
```

```
Optimize this Bash script for production (activates bash-defensive-patterns skill)
```

### Multi-Agent Workflows

While full-stack orchestration isn't installed, you can manually coordinate agents:

```
1. Use backend-architect to design the API
2. Use fastapi-pro to implement the endpoints
3. Use bash-pro to create deployment scripts
```

---

## Installation Commands

### Adding New Plugins

```bash
# View available plugins
/plugin

# Install specific plugins
/plugin install javascript-typescript
/plugin install kubernetes-operations
/plugin install cloud-infrastructure
/plugin install security-scanning
/plugin install full-stack-orchestration
```

### Managing Plugins

```bash
# List installed plugins
/plugin list

# Update plugins
/plugin update

# Remove plugin
/plugin uninstall plugin-name@marketplace-name
```

### Managing Marketplaces

```bash
# Add marketplace
/plugin marketplace add username/repo

# Update marketplace
/plugin marketplace update claude-code-workflows

# Remove marketplace
/plugin marketplace remove marketplace-name
```

---

## Best Practices

### 1. Plugin Selection

**Install only what you need**:
- Each plugin loads agents/skills into context
- Too many plugins increase token usage
- Start with core plugins, add as needed

**Currently Installed (10 agents, 13 skills)**:
- Python development (3 agents, 5 skills)
- Data engineering (2 agents, 0 skills)
- ML operations (3 agents, 1 skill)
- Shell scripting (2 agents, 3 skills)

**Consider Adding**:
- `javascript-typescript` if doing frontend work
- `kubernetes-operations` if deploying to K8s
- `security-scanning` for security audits
- `code-review-ai` for code review assistance

### 2. Agent Usage

**Be Specific**:
- Name the agent you want: "Use python-pro to..."
- Describe the task clearly
- Mention relevant skills if applicable

**Leverage Skills**:
- Skills provide specialized knowledge
- They're loaded progressively (token-efficient)
- Reference them when needed: "Use async-python-patterns"

### 3. Configuration Management

**Dotfiles Setup**:
- Keep only `settings.local.json` in dotfiles
- Don't version control plugin data
- Use symlink for user settings
- Let Claude Code manage plugins/marketplaces

**Settings Organization**:
- System settings: `~/.claude/settings.json` (don't modify)
- User overrides: `~/.claude/settings.local.json` (symlinked to dotfiles)
- Plugin data: `~/.claude/plugins/` (managed by system)

### 4. Workflow Optimization

**For Python Projects**:
1. Use `python-pro` for project setup
2. Use `fastapi-pro` or `django-pro` for web frameworks
3. Activate skills as needed (testing, packaging, performance)

**For Data Projects**:
1. Use `data-engineer` for pipeline design
2. Use `data-scientist` for analysis and modeling
3. Use `ml-engineer` or `mlops-engineer` for production ML

**For Infrastructure**:
1. Use `backend-architect` for service design
2. Use `bash-pro` for deployment automation
3. Consider installing `kubernetes-operations` or `cloud-infrastructure`

---

## Summary

### Installed Components

**Plugins**: 4
- python-development
- data-engineering
- machine-learning-ops
- shell-scripting

**Agents**: 10
- python-pro, fastapi-pro, django-pro
- data-engineer, backend-architect
- data-scientist, ml-engineer, mlops-engineer
- bash-pro, posix-shell-pro

**Skills**: 13
- 5 Python skills
- 1 ML skill
- 3 Shell scripting skills

**Marketplace**: wshobson/agents
- 63 plugins available
- 85 agents total
- 47 skills total

### Configuration Status

**Integration**: Properly configured
- Settings symlinked to dotfiles correctly
- Plugin data managed by Claude Code
- No conflicts detected
- Old plugin data cleaned up from dotfiles

**Recommendations**:
1. Current setup is optimal
2. Keep only `settings.local.json` in dotfiles
3. Let Claude Code manage plugin installations
4. Add `.gitignore` entries for Claude directories
5. Install additional plugins as needed

### Next Steps

**Immediate**:
1. Add `.gitignore` entries to dotfiles
2. Populate `settings.local.json` with preferences
3. Familiarize yourself with installed agents

**Consider Installing**:
- `javascript-typescript` for frontend work
- `kubernetes-operations` for K8s deployments
- `security-scanning` for security audits
- `cloud-infrastructure` for cloud work
- `full-stack-orchestration` for multi-agent workflows

**Usage**:
- Invoke agents by name: "Use python-pro to..."
- Reference skills when needed
- Let skills activate automatically based on context
- Start simple, add plugins as requirements grow
