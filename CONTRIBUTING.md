# Contributing

## Commit format
type(scope): subject

Types: feat, fix, chore, docs, refactor, test, ci

## Branch naming
feature/[name]/short-description
fix/[name]/short-description
docs/[name]/short-description

## PR rules
- 1 approval required before merge
- No self-merge
- Squash merge only
## Commit scopes
api-gateway     — API gateway service
deployment-service — Deployment service
frontend-service   — Frontend service
log-service     — Log service
platform        — Platform/infrastructure
docs            — Documentation
infra           — Terraform / Kubernetes configs

## Examples
feat(api-gateway): add user login endpoint
fix(log-service): handle nil pointer on startup
chore(infra): update terraform provider version
docs(readme): add branch strategy section
ci(platform): add github actions workflow
