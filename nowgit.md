# Git Repositories

## Main App (iOS Application)

| Item | Value |
|------|-------|
| **Repository Name** | Lullab |
| **Git URL** | git@github.com:asunnyboy861/Lullab.git |
| **Repo URL** | https://github.com/asunnyboy861/Lullab |
| **Visibility** | Public |
| **Primary Language** | Swift |
| **GitHub Pages** | ENABLED (from `/docs` folder) |

## Policy Pages (Deployed from Main Repository /docs)

| Page | URL | Status |
|------|-----|--------|
| Landing Page | https://asunnyboy861.github.io/Lullab/ | Pending |
| Support | https://asunnyboy861.github.io/Lullab/support.html | Pending |
| Privacy Policy | https://asunnyboy861.github.io/Lullab/privacy.html | Pending |
| Terms of Use | https://asunnyboy861.github.io/Lullab/terms.html | Pending |

## Repository Structure

```
Lullab/
├── Lullab/                        # iOS App Source Code
│   ├── Lullab.xcodeproj/          # Xcode Project
│   ├── Lullab/                    # Swift Source Files
│   │   ├── Views/
│   │   │   ├── Home/
│   │   │   ├── Feed/
│   │   │   ├── Sleep/
│   │   │   ├── Diaper/
│   │   │   ├── Growth/
│   │   │   ├── Timeline/
│   │   │   ├── Settings/
│   │   │   └── Onboarding/
│   │   ├── ViewModels/
│   │   ├── Models/
│   │   ├── Services/
│   │   ├── DesignSystem/
│   │   └── Extensions/
│   ├── LullabTests/
│   └── LullabUITests/
├── docs/                          # Policy Pages (GitHub Pages source)
│   ├── index.html
│   ├── support.html
│   ├── privacy.html
│   └── terms.html
├── .github/workflows/
│   └── deploy.yml
├── us.md
├── capabilities.md
├── icon.md
├── price.md
└── nowgit.md
```
