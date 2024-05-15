resource "kubernetes_service_account" "service-account" {
  count = var.service-account-create ? 1 : 0

  dynamic "metadata" {
    for_each = var.metadata
    content {
      name        = try(metadata.value.name, "")
      namespace   = try(metadata.value.namespace, "kube-system")
      annotations = try(metadata.value.annotations, {})
      labels      = try(metadata.value.labels, {})
    }
  }
}

resource "kubernetes_cluster_role_v1" "this" {

  dynamic "metadata" {
    for_each = var.metadata
    content {
      name        = try(metadata.value.name, "")
      annotations = try(metadata.value.annotations, {})
      labels      = try(metadata.value.labels, {})
    }
  }

  dynamic "rule" {
    for_each = var.rules
    content {
      api_groups = try(rule.value.api_groups, [""])
      resources  = try(rule.value.resources, ["namespaces", "pods"])
      verbs      = try(rule.value.verbs, ["get", "list", "watch"])
    }
  }
}

resource "kubernetes_cluster_role_binding_v1" "this" {

  dynamic "metadata" {
    for_each = var.metadata
    content {
      name        = try(metadata.value.name, "")
      annotations = try(metadata.value.annotations, {})
      labels      = try(metadata.value.labels, {})
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.this.metadata[0].name
  }

  dynamic "subject" {
    for_each = var.subjects
    content {
      kind      = try(subject.value.kind, "")
      name      = try(subject.value.name, "")
      api_group = subject.value.kind == "ServiceAccount" ? "" : "rbac.authorization.k8s.io"
      namespace = try(subject.value.namespace, "")
    }
  }

}