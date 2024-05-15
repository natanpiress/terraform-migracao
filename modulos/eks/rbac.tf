module "rbac" {
  source = "./modules/rbac"

  for_each = var.rbac

  metadata               = try(each.value.metadata, [{}])
  service-account-create = try(each.value.service-account-create, false)
  rules                  = try(each.value.rules, [{}])
  subjects               = try(each.value.subjects, [{}])
}
