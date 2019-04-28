# Create Player
class Player
  attr_accessor :full_name, :money, :hand, :bet, :score

  def initialize
    @full_name = 'Player'
    @money = 200
    @hand = []
    @bet = 0
  end
end
