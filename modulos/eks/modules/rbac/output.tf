output "name" {
    value = kubernetes_cluster_role_v1.this.metadata[0].name
}