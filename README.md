# develop.env — GitOps manifests (repo học tập)

Repo này mô phỏng theo cấu trúc GitOps thường gặp ở các công ty thật, dùng để học ArgoCD.
**Không chứa secret/credential thật** — mọi giá trị nhạy cảm đều là placeholder.

## Cấu trúc

```
.github/workflows/   CI: validate kustomize build, terraform fmt, vault policy, dọn cache
kubernetes/          Hạ tầng cấp cluster (namespace, cert-manager, ingress controller...)
terraform/           Code hạ tầng cloud (GKE) và Vault — CHỈ LÀ VÍ DỤ, chưa apply
workload/             Từng service/app, mỗi app 1 folder riêng, dùng Kustomize base + overlays
```

## workload/pet-be

- `base/` — manifest gốc dùng chung mọi môi trường
- `overlays/dev/` — override riêng cho môi trường dev (namespace, image tag, replicas)

ArgoCD Application trỏ vào `overlays/<env>` tương ứng, không trỏ thẳng vào `base/`.

## Cách thêm 1 service mới

1. Tạo `workload/<ten-service>/base/` + `overlays/dev/`
2. Tạo thêm 1 ArgoCD Application mới trỏ vào `workload/<ten-service>/overlays/dev`

## Terraform

`terraform/gcloud` và `terraform/vault` chỉ là code mẫu để học cấu trúc — **chưa từng chạy
`terraform apply`**. Muốn dùng thật cần tự cấu hình backend + credentials riêng.
