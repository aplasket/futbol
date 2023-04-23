# The below is copie from the example in iteration 2 under File I/0
# runner.rb
require_relative 'stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
pp stat_tracker.teams
pp stat_tracker.game_teams.sample
p stat_tracker.game_stats.highest_total_score
p stat_tracker.league_stats.highest_scoring_home_team
p stat_tracker.season_stats.worst_coach