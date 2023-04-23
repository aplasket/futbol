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

  def most_tackles(season)
    team_tackles = Hash.new(0)
    seasonal_team_games = @game_teams.group_by(&:game_id)

    game_id.start_with?(season)
    # @game_teams.select do |team|
    #   if 
    # end

    require 'pry'; binding.pry
    seasonal_team_games.each do |team|
      team_id = team.team_id
      tackles = team.tackles
      team_tackles[team_id] += tackles
    end
    most_tacks = team_tackles.max_by {|id, avg| avg}  
    @teams.find {|team| team.team_id == most_tacks.first}.team_name
  end

  def fewest_tackles(season)
    team_tackles = Hash.new(0)
    total_games = Hash.new(0)

    @game_teams.each do |team|
      team_id = team.team_id
      tackles = team.tackles
      team_tackles[team_id] += tackles
      total_games[team_id] += 1
    end

    fewest_tacks = team_tackles.min_by {|id, avg| avg}  
    @teams.find {|team| team.team_id == fewest_tacks.first}.team_name
  end
end 
