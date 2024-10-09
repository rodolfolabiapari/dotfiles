#!/usr/bin/env python3
"""
Detecta e constroi variáveis para o terraform
"""
import sys
import json

def buildvars(hclpath, terragruntpath):
    formated = hclpath.split("/")
    region = formated[2]
    if region == "_global":
      region = "us-east-1"
    account = formated[1]
    environment = formated[3]
    instance_path = terragruntpath
    return {"region": region, "account": account, "environment": environment, "instance_path": instance_path}

def buildprovider(region):
    return """
provider "aws" {{
    region = "{}"
}}
    """.format(region)

def main():
    """ cria scripts de variaveis.tf
    """
    path_to_include = sys.argv[1]
    terragrunt_path = sys.argv[2]
    common_vars = buildvars(path_to_include, terragrunt_path)
    with open("{}/custom.tfvars".format(terragrunt_path), 'w') as file:  # Use file to refer to the file object
        vars =  """
                aws_region = "{region}"
                base_tags = {{ 
                    "environment": "{environment}",
                    "instance_path": "{instance_path}"
                    }} 
                """.format(**common_vars)
        file.write(vars)
    with open( "provider.tf", "w") as file:
        file.write( buildprovider(common_vars["region"]))
    #print "{}".format(buildvars(sys.argv[1],sys.argv[2]))

if __name__ == "__main__":
    main()
