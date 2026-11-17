data "aws_ssoadmin_instances" "instances" {
}

data "aws_identitystore_group" "management_admin" {
  for_each = { for idx, name in var.management_admin_groups : name => idx }

  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key
    }
  }
}

data "aws_identitystore_group" "management_engineer" {
  for_each = { for idx, name in var.management_engineer_groups : name => idx }

  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key
    }
  }
}

data "aws_identitystore_group" "security_admin" {
  for_each = { for idx, name in var.security_admin_groups : name => idx }

  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key
    }
  }
}

data "aws_identitystore_group" "security_engineer" {
  for_each = { for idx, name in var.security_engineer_groups : name => idx }

  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key
    }
  }
}

data "aws_identitystore_group" "infra_admin" {
  for_each = { for idx, name in var.infra_admin_groups : name => idx }

  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key
    }
  }
}

data "aws_identitystore_group" "infra_engineer" {
  for_each = { for idx, name in var.infra_engineer_groups : name => idx }

  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key
    }
  }
}

data "aws_identitystore_group" "shared_admin" {
  for_each = { for idx, name in var.shared_admin_groups : name => idx }

  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key
    }
  }
}

data "aws_identitystore_group" "shared_engineer" {
  for_each = { for idx, name in var.shared_engineer_groups : name => idx }

  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key
    }
  }
}

data "aws_identitystore_group" "staging_admin" {
  for_each = { for idx, name in var.staging_admin_groups : name => idx }

  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key
    }
  }
}

data "aws_identitystore_group" "staging_engineer" {
  for_each = { for idx, name in var.staging_engineer_groups : name => idx }

  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key
    }
  }
}

data "aws_identitystore_group" "prod_admin" {
  for_each = { for idx, name in var.prod_admin_groups : name => idx }

  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key
    }
  }
}

data "aws_identitystore_group" "prod_engineer" {
  for_each = { for idx, name in var.prod_engineer_groups : name => idx }

  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key
    }
  }
}

data "aws_identitystore_group" "data_science_sandbox_admin" {
  for_each = { for idx, name in var.data_science_sandbox_admin_groups : name => idx }

  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key
    }
  }
}

data "aws_identitystore_group" "data_science_sandbox_engineer" {
  for_each = { for idx, name in var.data_science_sandbox_engineer_groups : name => idx }

  identity_store_id = tolist(data.aws_ssoadmin_instances.instances.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key
    }
  }
}