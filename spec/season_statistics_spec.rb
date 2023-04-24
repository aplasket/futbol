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

  describe "#initialize(files)" do
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
    it "lists each game played in a season" do
      expect(@season_stats.find_season_games("2012013")).to be(false)
      expect(@season_stats.find_season_games("20122013")).to be_a(Array)
      expect(@season_stats.find_season_games("20122013").first).to be_a(String)
      expect(@season_stats.find_season_games("20122013").first).to eq("2012030221")
      expect(@season_stats.find_season_games("20172018").last).to eq("2017020726")
    end
  end

  describe "#validate_season(season)" do
    it "validates if data for that season is available" do
      expect(@season_stats.validate_season("20122013")).to be(true)
      expect(@season_stats.validate_season("20112012")).to be(false)
    end
  end

  describe "#coach_record(season)" do 
    it "can list the loss, ties, and wins of each coach for each season" do 
      expect(@season_stats.coaches_record("20122013")).to be_a(Hash)
      expect(@season_stats.coaches_record("20122013")["20122013"]["John Tortorella"]).to eq({:games_coached=>60, :losses=>27, :ties=>11, :wins=>22})
      expect(@season_stats.coaches_record("20132014")["20132014"]["John Tortorella"]).to eq({:games_coached=>82, :losses=>31, :ties=>18, :wins=>33})
      expect(@season_stats.coaches_record("20172018")["20172018"]["Bob Boughner"]).to eq({:games_coached=>82, :losses=>28, :ties=>16, :wins=>38})
      expect(@season_stats.coaches_record("20172018")["20172018"].keys.first).to eq("Peter DeBoer")
      expect(@season_stats.coaches_record("20172018")["20172018"].values.first).to eq({:games_coached=>92, :losses=>28, :ties=>20, :wins=>44})
    end
  end

  describe "#winning_percentages(season)" do
    it "lists the coach's winning percentage for the requested season" do 
      expect(@season_stats.winning_percentages("20132014")).to be_a(Hash)
      expect(@season_stats.winning_percentages("20132014").key?("Claude Julien")).to be(true)
      expect(@season_stats.winning_percentages("20132014").values.max).to eq(57.45)
      expect(@season_stats.winning_percentages("20132014")["Claude Julien"]).to eq(57.45)
      
      expect(@season_stats.winning_percentages("20142015")).to be_a(Hash)
      expect(@season_stats.winning_percentages("20142015").key?("Alain Vigneault")).to be(true)
      expect(@season_stats.winning_percentages("20142015").values.max).to eq(51.49)
      expect(@season_stats.winning_percentages("20142015")["Alain Vigneault"]).to eq(51.49)
    end
  end

  describe "#winningest_coach(season)" do
    it "names the coach with the best win percentage for the season" do 
      expect(@season_stats.winningest_coach("20132014")).to be_a(String)
      expect(@season_stats.winningest_coach("20132014")).to eq("Claude Julien")

      expect(@season_stats.winningest_coach("20142015")).to be_a(String)
      expect(@season_stats.winningest_coach("20142015")).to eq("Alain Vigneault")
    end
  end

  describe "#losing_percentages(season)" do
    it "lists the coach's losing percentage for the requested season" do 
      expect(@season_stats.losing_percentages("20132014")).to be_a(Hash)
      expect(@season_stats.losing_percentages("20132014").key?("Peter Laviolette")).to be(true)
      expect(@season_stats.losing_percentages("20132014").values.max).to eq(100.00)
      expect(@season_stats.losing_percentages("20132014")["Peter Laviolette"]).to eq(100.00)
      
      expect(@season_stats.losing_percentages("20142015")).to be_a(Hash)
      expect(@season_stats.losing_percentages("20142015").key?("Dallas Eakins")).to be(true)
      expect(@season_stats.losing_percentages("20142015").values.max).to eq(64.52)
      expect(@season_stats.losing_percentages("20142015")["Dallas Eakins"]).to eq(64.52)
    end
  end

  describe "#worst_coach(season)" do
    it "names the Coach with the worst win percentage for the season" do 
      expect(@season_stats.worst_coach("20132014")).to be_a(String)
      expect(@season_stats.worst_coach("20132014")).to eq("Peter Laviolette")

      expect(@season_stats.worst_coach("20142015")).to be_a(String)
      expect(@season_stats.worst_coach("20142015")).to eq("Dallas Eakins") 
    end
  end

  describe "#highest_percentage(season, reveal)" do
    it "reveals the top winner or loser." do 
      expect(@season_stats.highest_percentage("20132014","winner")).to be_a(String)
      expect(@season_stats.highest_percentage("20132014","winner")).to eq("Claude Julien")
      expect(@season_stats.highest_percentage("20142015","winner")).to be_a(String)
      expect(@season_stats.highest_percentage("20142015","winner")).to eq("Alain Vigneault")

      expect(@season_stats.highest_percentage("20132014","loser")).to be_a(String)
      expect(@season_stats.highest_percentage("20132014","loser")).to eq("Peter Laviolette")
      expect(@season_stats.highest_percentage("20142015","loser")).to be_a(String)
      expect(@season_stats.highest_percentage("20142015","loser")).to eq("Dallas Eakins")
    end
  end

  describe "#teams_each_season(season)" do 
    it "can list all the teams for each season" do
      expect(@season_stats.teams_each_season("20132014")).to eq(["Atlanta United",
      "Chicago Fire",
      "FC Cincinnati",
      "DC United",
      "FC Dallas",
      "Houston Dynamo",
      "Sporting Kansas City",
      "LA Galaxy",
      "Los Angeles FC",
      "Minnesota United FC",
      "Montreal Impact",
      "New England Revolution",
      "New York City FC",
      "New York Red Bulls",
      "Orlando City SC",
      "Portland Timbers",
      "Philadelphia Union",
      "Real Salt Lake",
      "San Jose Earthquakes",
      "Seattle Sounders FC",
      "Toronto FC",
      "Vancouver Whitecaps FC",
      "Chicago Red Stars",
      "Houston Dash",
      "North Carolina Courage",
      "Orlando Pride",
      "Portland Thorns FC",
      "Reign FC",
      "Sky Blue FC",
      "Utah Royals FC",
      "Washington Spirit FC",
      "Columbus Crew SC"])
    end
  end

  describe "#teams_with_id(seasons)" do
    it "can list each team name with its team id number" do
      expect(@season_stats.teams_with_id("20132014")).to be_a(Hash)
    end
  end

  describe "#team_records(season)" do
    it "can list the total amount of shots and goals of each team for each season" do 
      expect(@season_stats.team_records("20132014")).to be_a(Hash)
      expect(@season_stats.team_records("20132014")["20132014"]["Real Salt Lake"]).to eq({:goals=>5547, :shots=>18891})
      expect(@season_stats.team_records("20132014")["20132014"]["Toronto FC"]).to eq({:goals=>5547, :shots=>18891})
      
      expect(@season_stats.team_records("20132014")).to be_a(Hash)
      expect(@season_stats.team_records("20142015")["20142015"]["Toronto FC"]).to eq({:goals=>5461, :shots=>18781})
    end
  end

  describe "#team_accuracy_percentages(season)" do
    it "can list the total accuracy of each team for each season as float" do 
      expect(@season_stats.team_accuracy_percentages("20132014")).to be_a(Hash)
      expect(@season_stats.team_accuracy_percentages("20132014")["20132014"]).to eq([5])
      
      expect(@season_stats.team_accuracy_percentages("20132014")).to be_a(Hash)
      expect(@season_stats.team_accuracy_percentages("20142015")["20142015"]["Toronto FC"]).to eq(4)
    end
  end


  describe "#most_accurate_team" do
    it "names the team with the best ratio of shots to goals for the season" do 
      expect(@season_stats.most_accurate_team("20132014")).to eq ("Real Salt Lake")
      expect(@season_stats.most_accurate_team("20142015")).to eq ("Toronto FC")
      expect(@season_stats.most_accurate_team("20142015")).to be_a(String)
    end
  end

  describe "#least_accurate_team" do
    it "names the Team with the worst ratio of shots to goals for the season" do 
      expect(@season_stats.least_accurate_team("20132014")).to eq ("New York City FC")
      expect(@season_stats.least_accurate_team("20142015")).to eq ("Columbus Crew SC")
      expect(@season_stats.least_accurate_team("20142015")).to be_a(String)
    end
  end

  describe "#most_tackles" do
    it "names the Team with the most tackles for a given season" do 
      expect(@season_stats.most_tackles("20122013")).to be_a(String)
      expect(@season_stats.most_tackles("20122013")).to eq("FC Cincinnati")
      expect(@season_stats.most_tackles("20132014")).to eq("FC Cincinnati")
      expect(@season_stats.most_tackles("20142015")).to eq("Seattle Sounders FC")
      expect(@season_stats.most_tackles("20152016")).to eq("Seattle Sounders FC")
      expect(@season_stats.most_tackles("20162017")).to eq("Sporting Kansas City")
      expect(@season_stats.most_tackles("20172018")).to eq("Portland Timbers")
    end
  end

  describe "#fewest_tackles" do
    it "names the Team with the fewest tackles for a given season" do 
      expect(@season_stats.fewest_tackles("20122013")).to be_a(String)
      expect(@season_stats.fewest_tackles("20122013")).to eq("Atlanta United")
      expect(@season_stats.fewest_tackles("20132014")).to eq("Atlanta United")
      expect(@season_stats.fewest_tackles("20142015")).to eq("Orlando City SC")
      expect(@season_stats.fewest_tackles("20152016")).to eq("Montreal Impact")
      expect(@season_stats.fewest_tackles("20162017")).to eq("New England Revolution")
      expect(@season_stats.fewest_tackles("20172018")).to eq("New England Revolution")
    end
  end
end
