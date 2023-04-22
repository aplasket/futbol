require_relative "./stat_tracker"
require_relative "./stat_helper"
class SeasonStatistics < StatHelper

  def initialize(files)
    super
  end

  def coach_record
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
    coach_record.map do |coach, record|
      coaches_winning_percentage[coach] = (record[:wins].to_f) / (record[:games_coached].to_f) * 100
    end
    best_coach = coaches_winning_percentage
    best_coach.max_by {|coach, winning_percentage|winning_percentage}[0]
  end

  def worst_coach
    coaches_losing_percentage = Hash.new
    coach_record.map do |coach, record|
      coaches_losing_percentage[coach] = (record[:losses].to_f) / (record[:games_coached].to_f) * 100
    end
    worst_coach = coaches_losing_percentage
    worst_coach.max_by {|coach, losing_percentage|losing_percentage}[0]
  end

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
