require_relative "./stat_tracker"
require_relative "./stat_helper"
class SeasonStatistics < StatHelper

  def initialize(files)
    super
  end

  def record_of_each_coach
    coaches = Hash.new
  
    @game_teams.each do |team|
      coach = team.head_coach
      results = team.result
      if !coaches.key?(coach)
        coaches[coach] = {games_coached: 1, wins: 0, losses: 0, ties: 0}
        if results == "WIN"
          coaches[coach][:wins] += 1
        elsif results == "LOSS"
          coaches[coach][:losses] += 1
        else
          coaches[coach][:ties] += 1
        end
      else
        coaches[coach][:games_coached] += 1
        if results == "WIN"
          coaches[coach][:wins] += 1
        elsif results == "LOSS"
          coaches[coach][:losses] += 1
        else
          coaches[coach][:ties] += 1
        end
      end
    end
    coaches
  end
  
  def winningest_coach
    coaches_winning_percentage = Hash.new
    record_of_each_coach.each do |coach, record|
      coaches_winning_percentage[coach]

    end
  end

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

  def fewest_tackles
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
