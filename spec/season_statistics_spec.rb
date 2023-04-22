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

#   describe "#winningest_coach" do
#     xit " names the Coach with the best win percentage for the season" do 

#       # return value string
#     end
#   end

#   describe "#worst_coach" do
#     xit " names the Coach with the worst win percentage for the season" do 

#       # return value string
#     end
#   end

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
    it "names the Team with the most tackles for a given season" do 
      expect(@season_stats.most_tackles).to be_a(String)
      # expect(@season_stats.most_tackles(20122013)).to eq("TEAMNAME")
      expect(@season_stats.most_tackles(20132014)).to eq("FC Cincinnati")
      expect(@season_stats.most_tackles(20142015)).to eq("Seattle Sounders FC")
      # expect(@season_stats.most_tackles(20152016)).to eq("TEAMNAME")
      # expect(@season_stats.most_tackles(20162017)).to eq("TEAMNAME")
      # expect(@season_stats.most_tackles(20172018)).to eq("TEAMNAME")
    end
  end

  describe "#fewest_tackles" do
    it "names the Team with the fewest tackles for a given season" do 
      expect(@season_stats.fewest_tackles).to be_a(String)
      # expect(@season_stats.fewest_tackles(20122013)).to eq("TEAMNAME")
      expect(@season_stats.fewest_tackles(20132014)).to eq("Atlanta United")
      expect(@season_stats.fewest_tackles(20142015)).to eq("Orlando City SC")
      # expect(@season_stats.fewest_tackles(20152016)).to eq("TEAMNAME")
      # expect(@season_stats.fewest_tackles(20162017)).to eq("TEAMNAME")
      # expect(@season_stats.fewest_tackles(20172018)).to eq("TEAMNAME")
    end
  end
end
