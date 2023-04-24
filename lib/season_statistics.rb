require_relative "./stat_tracker"
require_relative "./stat_helper"
class SeasonStatistics < StatHelper

  def initialize(files)
    super
  end

  def find_seasons
    seasons = @games.map {|game| game.season}
    edited_seasons = seasons.map {|season| season.to_i}
    revised_seasons = edited_seasons.uniq
    formated_seasons = revised_seasons.map {|rev_season| rev_season.to_s}
    formated_seasons.sort
  end

  def find_season_games(season)
    return false if validate_season(season) == false
    game_names = []
    @games.find_all do |game|
      game_name = game.game_id
      if game.season == season
        game_names << game_name
      else
        next
      end
    end
    game_names
  end

  def validate_season(season)
    return false if !find_seasons.include?(season)
    true
  end

  def coaches_record(season)
    return false if validate_season(season) == false
    coaches = Hash.new
    season_record = Hash.new
    season_record[season] = coaches
    played_games = find_season_games(season)
    @game_teams.each do |team|
      coach = team.head_coach
      results = team.result
      game = team.game_id
      if played_games.include?(game)
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
      else
        next
      end
    end
    season_record
  end

  def winning_percentages(season)
    return false if validate_season(season) == false
    coaches_winning_percentage = Hash.new
    coaches_record(season)[season].map do |coach, record|
      calculated_percentage = (record[:wins].to_f) / (record[:games_coached].to_f) * 100
      coaches_winning_percentage[coach] = calculated_percentage.round(2)
    end
    coaches_winning_percentage
  end

  def winningest_coach(season)
    return false if validate_season(season) == false
    highest_percentage(season, "winner")
  end

  def losing_percentages(season)
    return false if validate_season(season) == false
    coaches_losing_percentage = Hash.new
    coaches_record(season)[season].map do |coach, record|
      calculated_percentage = (record[:losses].to_f) / (record[:games_coached].to_f) * 100
      coaches_losing_percentage[coach] = calculated_percentage.round(2)
    end
    coaches_losing_percentage
  end

  def worst_coach(season)
    return false if validate_season(season) == false
    highest_percentage(season, "loser")
  end

  def highest_percentage(season, reveal)
    if reveal == "winner"
      coaches = winning_percentages(season)
    elsif reveal == "loser"
      coaches = losing_percentages(season)
    else
      false
    end
      top_percentage = coaches.values.max
      top_percentage = coaches.select {|coach, percentage|percentage == top_percentage}.keys
      top_percentage[0]
  end

  def most_accurate_team(season)
    team_goals_shots = Hash.new(0)
    seasonal_team_games = []

    @game_teams.each do |team|
      if team.game_id[0, 4] == season[0, 4] 
        seasonal_team_games << team
      end
    end
    seasonal_team_games.each do |team|
      team_id = team.team_id
      num_goals = team.goals
      num_shots = team.shots
      if team_goals_shots.keys.include?(team_id)
        team_goals_shots[team_id][:goals] += num_goals
        team_goals_shots[team_id][:shots] += num_shots
      else
        team_goals_shots[team_id] = {goals: num_goals, shots: num_shots}
      end
    end
    team_accuracy = {}
    team_goals_shots.each do |id, goal_shot|
      team_accuracy[id] = goal_shot[:goals] / goal_shot[:shots].to_f
    end
    most_acc = team_accuracy.max_by {|id, total| total}  
    @teams.find {|team| team.team_id == most_acc.first}.team_name
  end

  def least_accurate_team(season)
    team_goals_shots = Hash.new(0)
    seasonal_team_games = []

    @game_teams.each do |team|
      if team.game_id[0, 4] == season[0, 4] 
        seasonal_team_games << team
      end
    end
    seasonal_team_games.each do |team|
      team_id = team.team_id
      num_goals = team.goals
      num_shots = team.shots
      if team_goals_shots.keys.include?(team_id)
        team_goals_shots[team_id][:goals] += num_goals
        team_goals_shots[team_id][:shots] += num_shots
      else
        team_goals_shots[team_id] = {goals: num_goals, shots: num_shots}
      end
    end
    team_accuracy = {}
    team_goals_shots.each do |id, goal_shot|
      team_accuracy[id] = goal_shot[:goals] / goal_shot[:shots].to_f
    end
    least_acc = team_accuracy.min_by {|id, total| total}  
    @teams.find {|team| team.team_id == least_acc.first}.team_name
  end

  def most_tackles(season)
    team_tackles = Hash.new(0)
    seasonal_team_games = []

    @game_teams.each do |team|
      if team.game_id[0, 4] == season[0, 4] 
        seasonal_team_games << team
      end
    end
    seasonal_team_games.each do |team|
      team_id = team.team_id
      tackles = team.tackles
      team_tackles[team_id] += tackles
    end
    most_tacks = team_tackles.max_by {|id, total| total}  
    @teams.find {|team| team.team_id == most_tacks.first}.team_name
  end

  def fewest_tackles(season)
    team_tackles = Hash.new(0)
    seasonal_team_games = []

    @game_teams.each do |team|
      if team.game_id[0, 4] == season[0, 4] 
        seasonal_team_games << team
      end
    end
    seasonal_team_games.each do |team|
      team_id = team.team_id
      tackles = team.tackles
      team_tackles[team_id] += tackles
    end
    fewest_tacks = team_tackles.min_by {|id, total| total}  
    @teams.find {|team| team.team_id == fewest_tacks.first}.team_name
  end
end 
