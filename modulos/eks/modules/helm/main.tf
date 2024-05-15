resource "helm_release" "this" {

  name             = var.helm_release["name"]
  namespace        = var.helm_release["namespace"]
  repository       = try(var.helm_release["repository"], null)
  chart            = var.helm_release["chart"]
  version          = try(var.helm_release["version"], null)
  create_namespace = try(var.helm_release["create_namespace"], false)

  values = try(var.helm_release["values"], null)

  dynamic "set" {
    for_each = var.set
    content {
      name  = set.value.name
      value = set.value.value
      type  = try(set.value.type, null)
    }

  }

}
