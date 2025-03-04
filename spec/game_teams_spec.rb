require "csv"
require "spec_helper"

RSpec.describe GameTeams do
  let(:game_teams) {GameTeams.new(row)}
  let(:row) do {
    game_id: "2012030221",
    team_id: "3",
    hoa: "away",
    result: "LOSS",
    settled_in: "OT",
    head_coach: "John Tortorella",
    goals: 2,
    shots: 8,
    tackles: 44,
    pim: 8,
    powerplayopportunities: 3,
    powerplaygoals: 0,
    faceoffwinpercentage: 44.8,
    giveaways: 17,
    takeaways: 7
    }
  end

  describe "#initialize" do
    it " exists" do
      expect(game_teams).to be_a(GameTeams)
    end

    it " has attributes" do
      expect(game_teams.game_id).to eq("2012030221")
      expect(game_teams.game_id).to be_a(String)

      expect(game_teams.team_id).to eq("3")
      expect(game_teams.team_id).to be_a(String)

      expect(game_teams.hoa).to eq("away")
      expect(game_teams.hoa).to be_a(String)

      expect(game_teams.result).to eq("LOSS")
      expect(game_teams.result).to be_a(String)

      expect(game_teams.settled_in).to eq("OT")
      expect(game_teams.settled_in).to be_a(String)

      expect(game_teams.head_coach).to eq("John Tortorella")
      expect(game_teams.head_coach).to be_a(String)

      expect(game_teams.goals).to eq(2)
      expect(game_teams.goals).to be_a(Integer)

      expect(game_teams.shots).to eq(8)
      expect(game_teams.shots).to be_a(Integer)

      expect(game_teams.tackles).to eq(44)
      expect(game_teams.tackles).to be_a(Integer)

      expect(game_teams.pim).to eq(8)
      expect(game_teams.pim).to be_a(Integer)

      expect(game_teams.powerplayopp).to eq(3)
      expect(game_teams.powerplayopp).to be_a(Integer)

      expect(game_teams.powerplaygoals).to eq(0)
      expect(game_teams.powerplaygoals).to be_a(Integer)

      expect(game_teams.faceoffwinperc).to eq(44.8)
      expect(game_teams.faceoffwinperc).to be_a(Float)

      expect(game_teams.giveaways).to eq(17)
      expect(game_teams.giveaways).to be_a(Integer)

      expect(game_teams.takeaways).to eq(7)
      expect(game_teams.takeaways).to be_a(Integer)
    end
  end
end
