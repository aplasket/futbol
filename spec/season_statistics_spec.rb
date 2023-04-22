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

# Commented out tests below for now so running `rspec spec` will pass tests since we have not yet begun our code. 
  
  describe "#winningest_coach" do
    it " names the Coach with the best win percentage for the season" do 
      expect(@season_stats.winningest_coach).to eq([])
      # return value string
    end
  end

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
    it "names the Team with the most tackles in the season" do 
      expect(@season_stats.most_tackles).to eq("FC Cincinnati")
      expect(@season_stats.most_tackles).to be_a(String)
    end
  end

  describe "#fewest_tackles" do
    it "names the Team with the fewest tackles in the season" do 
      expect(@season_stats.fewest_tackles).to eq("Reign FC")
      expect(@season_stats.fewest_tackles).to be_a(String)
    end
  end
end
