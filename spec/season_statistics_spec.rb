require "csv"
require "spec_helper"

RSpec.describe SeasonStatistics do
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
    @season_stats = SeasonStatistics.new(locations)
  end

  describe "#initialize" do
    it "exists" do
      expect(@season_stats).to be_a(SeasonStatistics)
      expect(@stat_tracker).to be_a(StatTracker)
    end
  end

  describe "#find_seasons" do
    it "list the seasons that have data available" do
      expect(@season_stats.find_seasons).to be_a(Array)
      expect(@season_stats.find_seasons).to eq(["20122013", "20132014", "20142015", "20152016", "20162017", "20172018"])
    end
  end

  describe "find_season_games(season)" do
    xit "lists each game played in a season" do
      # we may need to use a mock or stub here
      expect(@season_stats.find_season_games("20122013")).to be_a(Array)
    end
  end


  describe "#validate_season(season)" do
    xit "validates if data for that season is available" do
      expect(@season_stats.validate_season("20122013")).to be(true)
      expect(@season_stats.validate_season("20112012")).to be(false)
    end
  end


  describe "#coach_record(season)" do 
    xit "can list the loss, ties, and wins of each coach for each season" do 
      expect(@season_stats.coaches_record("20122013")).to be_a(Hash)
      expect(@season_stats.coaches_record("20122013")).to eq({})
    end
  end
  
  describe "#winningest_coach(season)" do
    it " names the Coach with the best win percentage for the season" do 
      expect(@season_stats.winningest_coach("20122013")).to be_a(String)
      expect(@season_stats.winningest_coach("20132014")).to eq("Claude Julien")
      expect(@season_stats.winningest_coach("20142015")).to eq("Alain Vigneault")
    end
  end

  describe "#worst_coach(season)" do
    it " names the Coach with the worst win percentage for the season" do 
      expect(@season_stats.worst_coach("20142015")).to be_a(String)
      expect(@season_stats.worst_coach("20132014")).to eq("Peter Laviolette")
      expect(@season_stats.worst_coach("20142015")).to eq("Dallas Eakins")
      expect(@season_stats.worst_coach("20152016")).to eq("Todd Richards")
      
    end
  end

#   describe "#most_accurate_team" do
#     xit " names the Team with the best ratio of shots to goals for the season" do 

#       # return value string
#     end
#   end

#   describe "#least_accurate_team" do
#     xit " names the Team with the worst ratio of shots to goals for the season" do 

#       # return value string
#     end
#   end

  describe "#most_tackles" do
    xit "names the Team with the most tackles in the season" do 
      expect(@season_stats.most_tackles).to eq("FC Cincinnati")
      expect(@season_stats.most_tackles).to be_a(String)
    end
  end

  describe "#fewest_tackles" do
    xit "names the Team with the fewest tackles in the season" do 
      expect(@season_stats.fewest_tackles).to eq("Reign FC")
      expect(@season_stats.fewest_tackles).to be_a(String)
    end
  end
end
