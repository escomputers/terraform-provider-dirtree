data "dirtree_files" "example" {
  root = "${path.module}/root"
}

output "full_tree" {
  value = jsondecode(data.dirtree_files.example.tree)
}

data "dirtree_files" "apps" {
  root = "${path.module}/root/apps"
}

# Demo how we can filter for dirs and files, and disregard bits of the tree
# (e.g. the deeper/data files under each app)
# The tree consists of maps where keys are names, and values are:
#   + null for regular files
#   + maps for directories (wherein the definition repeats)
output "apps" {
  # apps are defined by all top-level directories in some root "apps"
  value = { for app, pipelines in jsondecode(data.dirtree_files.apps.tree) : app => [
    # anything in an app directory that's not itself a directory is a pipeline definition
    # in this imaginary codebase
    for pipeline, file in pipelines : pipeline if file == null
  ] if pipelines != null }
}


# e.g. given this directory structure:
# 
# root
# ├── 1
# ├── a
# │   ├── 2
# │   ├── 3
# │   └── b
# │       ├── 4
# │       ├── 5
# │       ├── 6
# │       └── c
# └── apps
#     ├── app1
#     │   ├── deeper
#     │   │   └── data
#     │   ├── pipeline1
#     │   ├── pipeline2
#     │   └── pipeline3
#     ├── app2
#     │   ├── deeper
#     │   │   └── data
#     │   ├── pipeline1
#     │   ├── pipeline2
#     │   └── pipeline3
#     ├── app3
#     │   ├── deeper
#     │   │   └── data
#     │   ├── pipeline1
#     │   ├── pipeline2
#     │   └── pipeline3
#     └── config
# 
# The following outputs result:
# 
#   + apps      = {
#       + app1 = [
#           + "pipeline1",
#           + "pipeline2",
#           + "pipeline3",
#         ]
#       + app2 = [
#           + "pipeline1",
#           + "pipeline2",
#           + "pipeline3",
#         ]
#       + app3 = [
#           + "pipeline1",
#           + "pipeline2",
#           + "pipeline3",
#         ]
#     }
#   + full_tree = {
#       + 1    = null
#       + a    = {
#           + 2 = null
#           + 3 = null
#           + b = {
#               + 4 = null
#               + 5 = null
#               + 6 = null
#               + c = {
#                   + .gitkeep = null
#                 }
#             }
#         }
#       + apps = {
#           + app1   = {
#               + deeper    = {
#                   + data = null
#                 }
#               + pipeline1 = null
#               + pipeline2 = null
#               + pipeline3 = null
#             }
#           + app2   = {
#               + deeper    = {
#                   + data = null
#                 }
#               + pipeline1 = null
#               + pipeline2 = null
#               + pipeline3 = null
#             }
#           + app3   = {
#               + deeper    = {
#                   + data = null
#                 }
#               + pipeline1 = null
#               + pipeline2 = null
#               + pipeline3 = null
#             }
#           + config = null
#         }
#     }