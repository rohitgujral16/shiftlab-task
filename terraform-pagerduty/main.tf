### Pre-requisite  #######
# Export pagerduty token #
#Keep user.csv and team.csv files in the same directory#

provider "pagerduty" {
}



resource "pagerduty_team" "all_teams" {
  for_each = { for team in csvdecode(file("pagerduty_teams.csv")) : team.name => team }
  name        = each.value.name
  description = each.value.description
}


# Create a PagerDuty users
resource "pagerduty_user" "user" {
  for_each = { for user in csvdecode(file("pagerduty_users.csv")) : user.name => user }
  name  = each.value.name
  email = each.value.email
}

# Create a team membership for all users
resource "pagerduty_team_membership" "membership" {
  for_each = { for user in csvdecode(file("pagerduty_users.csv")) : user.name => user }
  user_id = pagerduty_user.user[each.value.name].id
  team_id = pagerduty_team.all_teams[each.value.pagerduty_team].id
}
