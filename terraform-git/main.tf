#### Pre-requisite
# Make sure to export github access token
# export GITHUB_TOKEN=


provider "github" {
}

variable "repo_name" {
  description = "repository name"
}
variable "repo_type" {
  description = "private or public repo"
}


resource "github_repository" "repo" {
  name        = var.repo_name
  visibility  = var.repo_type
}

########### Creating Different Teams using loop ###############

resource "github_team" "all_teams" {
  for_each = { for team in csvdecode(file("github_teams.csv")) : team.team => team }
  name        = each.value.team
  privacy     = each.value.privacy
  create_default_maintainer = true
}

########## Associating teams with repository and giving appropriate permission ########

resource "github_team_repository" "team_access" {
  for_each = { for team in csvdecode(file("github_teams.csv")) : team.team => team }
  team_id    = github_team.all_teams[each.value.team].id
  repository = github_repository.repo.id
  permission = each.value.permission
}

###########  Adding users to the team ###########

resource "github_team_membership" "user_access" {

  for_each = { for user in csvdecode(file("github_users.csv")) : user.username => user }

  team_id  = github_team.all_teams[each.value.team].id
  username = each.value.username
  role     = each.value.role
}
