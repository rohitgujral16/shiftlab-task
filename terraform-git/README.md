The directory contains 2 csv files.
1. github_teams.csv -> which contains teams name, their privacy and permission.
    Any new team which needs to be created, should be added to this file

2. github_users.csv -> whihc contains usernames, their respective team and role.
   Any new user which needs to be created, should be added to this csv file along with its team and role.
   
   Below commands can be executed post the change
   1. terraform init
   2. terraform plan
   3. terraform apply
