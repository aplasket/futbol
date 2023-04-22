require_relative "./stat_tracker"
require_relative "./stat_helper"
class SeasonStatistics < StatHelper

  def initialize(files)
    super
  end
  
#   def winningest_coach
#     method
#   end

#   def worst_coach
#     method
#   end

#   def most_accurate_team
#     method
#   end

#   def least_accurate_team
#     method
#   end

  def most_tackles
    team_tackles = Hash.new(0)
    total_games = Hash.new(0)

    @game_teams.each do |team|
      team_id = team.team_id
      tackles = team.tackles
      team_tackles[team_id] += tackles
      total_games[team_id] += 1
    end

    most_tacks = team_tackles.max_by {|id, avg| avg}  
    @teams.find {|team| team.team_id == most_tacks.first}.team_name
  end

# Description: Name of the Team with the most tackles in the season
# Return Value: String



  def fewest_tackles
    # method
  end

# Description: Name of the Team with the fewest tackles in the season
# Return Value: String

end 
