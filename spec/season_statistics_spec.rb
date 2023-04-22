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

  describe "#coach_record" do 
  it "can list the loss, ties, and wins of each coach" do 
    expected = {"Adam Oates" => {:games_coached=>183, :losses=>79, :ties=>44, :wins=>60},
                "Alain Vigneault" => {:games_coached=>523, :losses=>192, :ties=>100, :wins=>231},
                "Barry Trotz" => {:games_coached=>521, :losses=>179, :ties=>99, :wins=>243},
                "Bill Peters" => {:games_coached=>328, :losses=>141, :ties=>62, :wins=>125},
                "Bob Boughner" => {:games_coached=>82, :losses=>28, :ties=>16, :wins=>38},
                "Bob Hartley" => {:games_coached=>305, :losses=>148, :ties=>52, :wins=>105},
                "Bruce Boudreau" => {:games_coached=>511, :losses=>161, :ties=>108, :wins=>242}}
    expect(@season_stats.coach_record).to eq(expected)
  end
end
  
  describe "#winningest_coach" do
    it " names the Coach with the best win percentage for the season" do 
      expect(@season_stats.winningest_coach).to be_a(String)
      expect(@season_stats.winningest_coach).to eq("Dan Lacroix")
    end
  end

  describe "#worst_coach" do
    it " names the Coach with the worst win percentage for the season" do 
      expect(@season_stats.worst_coach).to be_a(String)
      expect(@season_stats.worst_coach).to eq("Martin Raymond")
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
