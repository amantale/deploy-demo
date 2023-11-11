#!/bin/bash -e

CLEAR='\033[0m'
RED='\033[0;31m'

function usage() {
  if [ -n "$1" ]; then
    echo -e "${RED}$1${CLEAR}\n"
  fi
  echo "Usage: $0 -c account-name -v version -k key-file -a aws-profile-name --dryrun"
  echo "  -c, --account-name      account       The account to create medusa in [lab, lab_west, lab_eu_central, prod, prod_west, prod_eu_central, prod_eu_west]"
  echo "  -v, --version           version       Medusa application version"
  echo "  -k, --key-file          keyfile       Vault key file path"
  echo "  -d, --dryrun            (optional)    Create CFN changesets in lieu of updating"
  echo ""
  echo "Example: $0 -c lab -v v2020-01-aaaa -k ../vault_password --dryrun"
  exit 1
}

while [[ "$#" -gt 0 ]]; do case $1 in
  -h | --help)
    usage
    exit 0
    ;;
  -c | --account-name)
    ACCOUNT_NAME="$2"
    shift
    shift
    ;;
  -v | --version)
    VERSION="$2"
    shift
    shift
    ;;
  -k | --key-file)
    KEY_FILE="$2"
    shift
    shift
    ;;
  -d | --dryrun)
    IS_DRY_RUN="true"
    shift
    ;;
  *)
    usage "Unknown parameter passed: $1"
    shift
    shift
    ;;
  esac done

# verify params
if [[ -z "$ACCOUNT_NAME" ]]; then usage "Account name name is not set"; fi
if [[ -z "$VERSION" ]]; then usage "Version is not set"; fi
if [[ -z "$KEY_FILE" ]]; then usage "Key file path is not set"; fi
if [[ -z "$IS_DRY_RUN" ]]; then IS_DRY_RUN="false"; fi

# check param values so we don't mess up
if ! [[ "$ACCOUNT_NAME" =~ ^(lab|lab_west|lab_eu_central|prod|prod_west|prod_eu_central|prod_eu_west)$ ]]; then
  echo "Valid values for account name are one of [lab, lab_west, lab_eu_central, prod, prod_west, prod_eu_central, prod_eu_west]"
  exit 1
fi

env no_proxy='*' ansible-playbook -vv \
  --vault-password-file="$KEY_FILE" \
  -i ansible/inventories/"$ACCOUNT_NAME" \
  -e version_tag="$VERSION" \
  -e dryrun="$IS_DRY_RUN" ansible/deploy-aws.yml
