require_relative "./stat_tracker"
require_relative "./stat_helper"

class LeagueStatistics < StatHelper

  def initialize(files)
    super
  end

  def count_of_teams
    @teams.length
  end

  def best_offense
    team_goals = Hash.new(0)
    total_games = Hash.new(0)

    @game_teams.each do |team|
      team_id = team.team_id
      goals = team.goals
      team_goals[team_id] += goals
      total_games[team_id] += 1
    end
    
    team_averages = Hash.new(0)
    team_goals.each do |team_id, goals|
      team_averages[team_id] = goals.to_f / total_games[team_id]
    end

    best_offense = team_averages.max_by {|id, avg| avg}  
    @teams.find {|team| team.team_id == best_offense.first}.team_name
  end

  def worst_offense
    team_goals = Hash.new(0)
    total_games = Hash.new(0)

    @game_teams.each do |team|
      team_id = team.team_id
      goals = team.goals
      team_goals[team_id] += goals
      total_games[team_id] += 1
    end
    
    team_averages = Hash.new(0)
    team_goals.each do |team_id, goals|
      team_averages[team_id] = goals.to_f / total_games[team_id]
    end

    worst_offense = team_averages.min_by {|id, avg| avg}  
    @teams.find {|team| team.team_id == worst_offense.first}.team_name
  end
  
  def highest_scoring_visitor
    visitors = @games.group_by(&:away_team_id)
    avg_score = Hash.new(0)

    visitors.map do |team, games|
      total_score = games.map do |game|
        game.away_goals
      end
      avg_score_per_game = total_score.sum.fdiv(total_score.count)
      avg_score[team] = avg_score_per_game
    end

    highest_avg_score = avg_score.max_by {|id, avg| avg}  
    @teams.find {|team| team.team_id == highest_avg_score.first}.team_name
  end

  def highest_scoring_home_team
    homers = @games.group_by(&:home_team_id)
    avg_score = Hash.new(0)

    homers.map do |team, games|
      total_score = games.map do |game|
        game.home_goals
      end
      avg_score_per_game = total_score.sum.fdiv(total_score.count)
      avg_score[team] = avg_score_per_game
    end

    highest_avg_score = avg_score.max_by {|id, avg| avg}  
    @teams.find {|team| team.team_id == highest_avg_score.first}.team_name
  end

  def lowest_scoring_visitor
    visitors = @games.group_by(&:away_team_id)
    avg_score = Hash.new(0)

    visitors.map do |team, games|
      total_score = games.map do |game|
        game.away_goals
      end
      avg_score_per_game = total_score.sum.fdiv(total_score.count)
      avg_score[team] = avg_score_per_game
    end

    lowest_avg_score = avg_score.min_by {|id, avg| avg}
    @teams.find {|team| team.team_id == lowest_avg_score.first}.team_name
  end

  def lowest_scoring_home_team
    homers = @games.group_by(&:home_team_id)
    avg_score = Hash.new(0)

    homers.map do |team, games|
      total_score = games.map do |game|
        game.home_goals
      end
      avg_score_per_game = total_score.sum.fdiv(total_score.count)
      avg_score[team] = avg_score_per_game
    end

    lowest_avg_score = avg_score.min_by {|id, avg| avg}  
    @teams.find {|team| team.team_id == lowest_avg_score.first}.team_name
  end
end
