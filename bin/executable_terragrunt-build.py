#!/usr/bin/env python3
"""
Detecta e constroi variáveis para o terraform
"""
import sys
import json

def buildvars(region_path, terragrunt_path,relative_path):
    region_dir = region_path[:-10]
    env_path = terragrunt_path[len(region_dir):]
    formated = env_path.split("/")
    environment = formated[0]
    instance_path = terragrunt_path
    return { "environment": environment, "instance_path": relative_path}


def main():
    """ cria scripts de variaveis.tf
    """
    terragrunt_path = sys.argv[1]
    region_path     = sys.argv[2]
    relative_path   = sys.argv[3]
    common_vars = buildvars(region_path, terragrunt_path,relative_path)
    with open("{}/custom.tfvars".format(terragrunt_path), 'w') as file:  # Use file to refer to the file object
        vars =  """
                base_tags = {{ 
                    "environment": "{environment}",
                    "instance_path": "{instance_path}"
                    }} 
                """.format(**common_vars)
        file.write(vars)

if __name__ == "__main__":
    main()

