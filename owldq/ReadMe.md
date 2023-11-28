project-root/
│
├── .github/
│   └── workflows/
│       └── deploy.yaml
│
├── scripts/
│   ├── setup_environment.sh
│   ├── helm_config.sh
│   └── generate_helmfile.sh
│
├── configs/
│   ├── config.json
│   ├── repo-key.json
│   ├── cilium-values.yaml
│   └── k8s-dashboard-values.yaml
│
├── helmcharts/
│   ├── cilium/
│   │   ├── Chart.yaml
│   │   ├── templates/
│   │   │   └── ...  # Cilium Helm chart templates
│   │   └── values.yaml
│   │
│   ├── kubernetes-dashboard/
│   │   ├── Chart.yaml
│   │   ├── templates/
│   │   │   └── ...  # Kubernetes Dashboard Helm chart templates
│   │   └── values.yaml
│   │
│   └── index.yaml
│
├── helmfile.yaml
├── Dockerfile
└── README.md
