provider "aws" {
  alias  = "infra"
  region = var.aws_region

  default_tags {
    tags = {
      Source               = "managed-by-terraform"
      Repo                 = "aws-multi-account-platform"
      Environment          = "global"
      Application          = "platform"
      ApplicationComponent = "aws-github-roles"
    }
  }
}

provider "aws" {
  alias  = "management"
  region = var.aws_region

  # Comment this for local test
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_ids["management"]}:role/github-actions/${var.bootstrap_repository}-github-role"
    session_name = "aws-multi-account-platform"
  }

  default_tags {
    tags = {
      Source               = "managed-by-terraform"
      Repo                 = "aws-multi-account-platform"
      Environment          = "global"
      Application          = "platform"
      ApplicationComponent = "aws-github-roles"
    }
  }
}

provider "aws" {
  alias  = "security"
  region = var.aws_region

  # Comment this for local test
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_ids["security"]}:role/github-actions/${var.bootstrap_repository}-github-role"
    session_name = "aws-multi-account-platform"
  }

  default_tags {
    tags = {
      Source               = "managed-by-terraform"
      Repo                 = "aws-multi-account-platform"
      Environment          = "global"
      Application          = "platform"
      ApplicationComponent = "aws-github-roles"
    }
  }
}

provider "aws" {
  alias  = "shared"
  region = var.aws_region

  # Comment this for local test
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_ids["shared"]}:role/github-actions/${var.bootstrap_repository}-github-role"
    session_name = "aws-multi-account-platform"
  }

  default_tags {
    tags = {
      Source               = "managed-by-terraform"
      Repo                 = "aws-multi-account-platform"
      Environment          = "global"
      Application          = "platform"
      ApplicationComponent = "aws-github-roles"
    }
  }
}

provider "aws" {
  alias  = "staging"
  region = var.aws_region

  # Comment this for local test
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_ids["staging"]}:role/github-actions/${var.bootstrap_repository}-github-role"
    session_name = "aws-multi-account-platform"
  }

  default_tags {
    tags = {
      Source               = "managed-by-terraform"
      Repo                 = "aws-multi-account-platform"
      Environment          = "staging"
      Application          = "platform"
      ApplicationComponent = "aws-github-roles"
    }
  }
}

provider "aws" {
  alias  = "prod"
  region = var.aws_region

  # Comment this for local test
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_ids["prod"]}:role/github-actions/${var.bootstrap_repository}-github-role"
    session_name = "aws-multi-account-platform"
  }

  default_tags {
    tags = {
      Source               = "managed-by-terraform"
      Repo                 = "aws-multi-account-platform"
      Environment          = "prod"
      Application          = "platform"
      ApplicationComponent = "aws-github-roles"
    }
  }
}

provider "aws" {
  alias  = "data-science-sandbox"
  region = var.aws_region

  # Comment this for local test
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_ids["data-science-sandbox"]}:role/github-actions/${var.bootstrap_repository}-github-role"
    session_name = "aws-multi-account-platform"
  }

  default_tags {
    tags = {
      Source               = "managed-by-terraform"
      Repo                 = "aws-multi-account-platform"
      Environment          = "data-science-sandbox"
      Application          = "platform"
      ApplicationComponent = "aws-github-roles"
    }
  }
}