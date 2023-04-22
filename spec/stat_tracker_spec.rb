require 'spec_helper'

RSpec.describe StatTracker do
  before(:each) do 
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe "initialize" do 
    it "exists" do 
      expect(@stat_tracker).to be_a(StatTracker)
    end

    it "can create an object from StatTracker from games.csv" do  
      expect(@stat_tracker.games[0].game_id).to eq("2012030221")
      expect(@stat_tracker.games).to be_an(Array)
      expect(@stat_tracker.games.sample).to be_a(Game)
      expect(@stat_tracker.games).to all(be_a(Game))
    end
  
    it "can create an object from StatTracker from game_teams.csv" do  
      expect(@stat_tracker.game_teams[0].game_id).to eq("2012030221")
      expect(@stat_tracker.game_teams).to be_an(Array)
      expect(@stat_tracker.game_teams.sample).to be_a(GameTeams)
      expect(@stat_tracker.game_teams).to all(be_a(GameTeams))
    end

    it "can create an object from StatTracker from teams.csv" do
      expect(@stat_tracker.teams[0].team_id).to eq("1")
      expect(@stat_tracker.teams).to be_an(Array)
      expect(@stat_tracker.teams.sample).to be_a(Teams)
      expect(@stat_tracker.teams).to all(be_a(Teams))
    end
  end

  describe "Game Statistics" do
    it "finds the game with the highest score." do
      expect(@stat_tracker.highest_total_score).to eq(11)
    end

    it "fnds the game with the lowest score." do
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end

    it "#percentage_home_wins" do
      expect(@stat_tracker.percentage_home_wins).to eq(0.44)
    end

    it "#percentage_visitor_wins" do
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.36)
    end

    it "#percentage_ties" do
      expect(@stat_tracker.percentage_ties).to eq(0.20)
    end

    it "#count_of_games_by_season" do
      expected = {
        "20122013"=>806,
        "20162017"=>1317,
        "20142015"=>1319,
        "20152016"=>1321,
        "20132014"=>1323,
        "20172018"=>1355
      }
      expect(@stat_tracker.count_of_games_by_season).to eq(expected)
      expect(@stat_tracker.count_of_games_by_season).to be_a(Hash)
    end

    it "calculates average number of goals per game" do
      expect(@stat_tracker.average_goals_per_game).to be_a(Float)
      expect(@stat_tracker.average_goals_per_game).to eq(4.22)
    end

    it "calculates average number of goals per game per season" do
      expect(@stat_tracker.average_goals_by_season).to be_a(Hash)
    end
  end

  describe "league statistics" do
    it "#count_of_teams" do
      expect(@stat_tracker.count_of_teams).to eq(32)
    end

    it "#best_offense" do
      expect(@stat_tracker.best_offense).to eq("Reign FC")
    end

    it "#worst_offense" do
      expect(@stat_tracker.worst_offense).to eq("Utah Royals FC")
    end

    it "#highest_scoring_visitor" do
      expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
    end

    it "#highest_scoring_home_team" do
      expect(@stat_tracker.highest_scoring_home_team).to eq("Reign FC")
    end

    it "#lowest_scoring_visitor" do
      expect(@stat_tracker.lowest_scoring_visitor).to eq("San Jose Earthquakes")
    end

    it "#lowest_scoring_home_team" do
      expect(@stat_tracker.lowest_scoring_home_team).to eq("Utah Royals FC")
    end
  end
  
  describe "season statistics" do
    it "#winningest_coach" do
      expect(@stat_tracker.winningest_coach("20132014")).to eq("Claude Julien")
      expect(@stat_tracker.winningest_coach("20142015")).to eq("Alain Vigneault")
    end

    it "#worst_coach" do
      expect(@stat_tracker.worst_coach("20132014")).to eq("Peter Laviolette")
      expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
    end

    it "#most_accurate_team" do
      expect(@stat_tracker.most_accurate_team("20132014")).to eq("Real Salt Lake")
      expect(@stat_tracker.most_accurate_team("20142015")).to eq("Toronto FC")
    end

    it "#least_accurate_team" do
      expect(@stat_tracker.least_accurate_team("20132014")).to eq("New York City FC")
      expect(@stat_tracker.least_accurate_team("20142015")).to eq("Columbus Crew SC")
    end

    it "#most_tackles" do
      expect(@stat_tracker.most_tackles("20132014")).to eq("FC Cincinnati")
      expect(@stat_tracker.most_tackles("20142015")).to eq("Seattle Sounders FC")
    end

    it "#fewest_tackles" do
      expect(@stat_tracker.fewest_tackles("20132014")).to eq("Atlanta United")
      expect(@stat_tracker.fewest_tackles("20142015")).to eq("Orlando City SC")
    end
end
