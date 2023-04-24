require "csv"
require_relative "game"
require_relative "game_teams"
require_relative "game_statistics"
require_relative "league_statistics"
require_relative "season_statistics"
require_relative "teams"

class StatTracker
  attr_reader :games,
              :game_teams,
              :teams,
              :game_stats,
              :league_stats,
              :season_stats

  def self.from_csv(files)
    StatTracker.new(files)
  end

  def initialize(files)
    @games = (CSV.open files[:games], headers: true, header_converters: :symbol).map { |row| Game.new(row) }
    @game_teams = (CSV.open files[:game_teams], headers: true, header_converters: :symbol).map { |row| GameTeams.new(row) }
    @teams = (CSV.open files[:teams], headers: true, header_converters: :symbol).map { |row| Teams.new(row) }
    @game_stats = GameStatistics.new(files)
    @league_stats = LeagueStatistics.new(files)
    @season_stats = SeasonStatistics.new(files)
  end

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end

  def percentage_ties
    @game_stats.percentage_ties
  end

  def count_of_games_by_season
    @game_stats.count_of_games_by_season
  end

  def average_goals_per_game
    @game_stats.average_goals_per_game
  end

  def average_goals_by_season
    @game_stats.average_goals_by_season
  end

  def count_of_teams
    @league_stats.count_of_teams
  end

  def best_offense
    @league_stats.best_offense
  end

  def worst_offense
    @league_stats.worst_offense
  end

  def highest_scoring_visitor
    @league_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @league_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_stats.lowest_scoring_home_team
  end

  def winningest_coach(season)
    @season_stats.winningest_coach(season)
  end
  
  def worst_coach(season)
    @season_stats.worst_coach(season)
  end
  
  def most_accurate_team(season)
    @season_stats.most_accurate_team(season)
  end
  
  def least_accurate_team(season)
    @season_stats.least_accurate_team(season)
  end
  
  def most_tackles(season)
    @season_stats.most_tackles(season)
  end
  
  def fewest_tackles(season)
    @season_stats.fewest_tackles(season)
  end
end
