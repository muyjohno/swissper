require "spec_helper"

RSpec.describe Swissper do
  it "has a version number" do
    expect(Swissper::VERSION).not_to be nil
  end

  describe '#pair' do
    10.times do |i|
      let("player#{i}") { Swissper::Player.new }
    end

    let(:players) do
      [player0, player1, player2, player3, player4,
        player5, player6, player7, player8, player9]
    end
    let(:paired) { Swissper.pair(players) }

    it 'pairs correctly' do
      expect(paired.length).to eq(5)
      expect(paired.flatten).to match_array(players)
    end

    context 'with some games played' do
      before do
        player1.delta = 3
        player2.delta = 3
        player3.delta = 1
        player4.delta = 1
      end

      let(:paired) { Swissper.pair(players) }

      it 'pairs players on matching score' do
        paired.each do |p|
          expect(p).to match_array([player1, player2]) if p.include?(player1)
          expect(p).to match_array([player3, player4]) if p.include?(player3)
        end
      end
    end

    context 'with some matchups excluded' do
      before do
        player1.exclude = (players - [player0, player1])
        player2.exclude = [player1]
      end

      let(:paired) { Swissper.pair(players) }

      it 'excludes those matchups' do
        paired.each do |p|
          expect(p).to match_array([player1, player0]) if p.include?(player1)
        end
      end
    end
  end
end
