provider "aws" {
  alias  = "infra"
  region = var.aws_region

  profile = var.account_profiles["infra"]

  default_tags {
    tags = {
      Source               = "managed-by-terraform"
      Repo                 = "aws-multi-account-platform"
      Environment          = "global"
      Application          = "platform"
      ApplicationComponent = "aws-base-accounts-init"
    }
  }
}

provider "aws" {
  alias  = "management"
  region = var.aws_region

  profile = var.account_profiles["management"]

  default_tags {
    tags = {
      Source               = "managed-by-terraform"
      Repo                 = "aws-multi-account-platform"
      Environment          = "global"
      Application          = "platform"
      ApplicationComponent = "aws-base-accounts-init"
    }
  }
}

provider "aws" {
  alias  = "security"
  region = var.aws_region

  profile = var.account_profiles["security"]

  default_tags {
    tags = {
      Source               = "managed-by-terraform"
      Repo                 = "aws-multi-account-platform"
      Environment          = "global"
      Application          = "platform"
      ApplicationComponent = "aws-base-accounts-init"
    }
  }
}

provider "aws" {
  alias  = "shared"
  region = var.aws_region

  profile = var.account_profiles["shared"]

  default_tags {
    tags = {
      Source               = "managed-by-terraform"
      Repo                 = "aws-multi-account-platform"
      Environment          = "global"
      Application          = "platform"
      ApplicationComponent = "aws-base-accounts-init"
    }
  }
}

provider "aws" {
  alias  = "staging"
  region = var.aws_region

  profile = var.account_profiles["staging"]

  default_tags {
    tags = {
      Source               = "managed-by-terraform"
      Repo                 = "aws-multi-account-platform"
      Environment          = "global"
      Application          = "platform"
      ApplicationComponent = "aws-base-accounts-init"
    }
  }
}

provider "aws" {
  alias  = "prod"
  region = var.aws_region

  profile = var.account_profiles["prod"]

  default_tags {
    tags = {
      Source               = "managed-by-terraform"
      Repo                 = "aws-multi-account-platform"
      Environment          = "global"
      Application          = "platform"
      ApplicationComponent = "aws-base-accounts-init"
    }
  }
}

provider "aws" {
  alias  = "data-science-sandbox"
  region = var.aws_region

  profile = var.account_profiles["data-science-sandbox"]

  default_tags {
    tags = {
      Source               = "managed-by-terraform"
      Repo                 = "aws-multi-account-platform"
      Environment          = "global"
      Application          = "platform"
      ApplicationComponent = "aws-base-accounts-init"
    }
  }
}
