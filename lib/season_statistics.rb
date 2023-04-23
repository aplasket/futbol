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
          elsif results == "TIE"
            coaches[coach][:ties] += 1
          end
        else
          coaches[coach][:games_coached] += 1
          if results == "WIN"
            coaches[coach][:wins] += 1
          elsif results == "LOSS"
            coaches[coach][:losses] += 1
          elsif results == "TIE"
            coaches[coach][:ties] += 1
          end
        end
      else
        next
      end
    end
    season_record
  end
  
  # def eligible_coaches(season)
  #   eligible_coaches = coaches_record(season)[season].reject do |coach, record|
  #     record[:games_coached] < 82
  #   end
  # end

  def winning_percentages(season)
    return false if !find_seasons.include?(season)
    coaches_winning_percentage = Hash.new
    coaches_record(season)[season].map do |coach, record|
      coaches_winning_percentage[coach] = (record[:wins].to_f) / (record[:games_coached].to_f) * 100
    end
    coaches_winning_percentage
  end

  def winningest_coach(season)
    return false if !find_seasons.include?(season)
    coaches = winning_percentages(season)
    best_percentage = coaches.values.max
    best_coaches = coaches.select {|coach, winning_percentage|winning_percentage == best_percentage}.keys
    best_coaches[0]
  end

  def losing_percentages(season)
    return false if !find_seasons.include?(season)
    coaches_losing_percentage = Hash.new
    coaches_record(season)[season].map do |coach, record|
      coaches_losing_percentage[coach] = (record[:losses].to_f) / (record[:games_coached].to_f) * 100
    end
    coaches_losing_percentage
  end

  # def biggest_loser_percentage(season)
  #   coaches = losing_percentages(season)
  #   worst_percentage = coaches.values.max
  # end

  def worst_coach(season)
    return false if !find_seasons.include?(season)
    coaches = losing_percentages(season)
    worst_percentage = coaches.values.max
    worst_coaches = coaches.select {|coach, losing_percentage|losing_percentage == worst_percentage}.keys
    worst_coaches[0]
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
