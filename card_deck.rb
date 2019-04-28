# Create a Card Deck
class CardDeck
  attr_accessor :deck

  def initialize
    @deck = create([])
  end

  def create(deck)
    card_types = get_card_type
    face_card = %w[J Q K A]
    card_types.each do |type|
      (2..10).each { |card| deck << "#{card}#{type}" }
      face_card.each { |card| deck << "#{card}#{type}" }
    end

    deck.shuffle
  end

  def get_card_type(color = false)
    color ? ['♥️', '♠️', '♦️', '♣️'] : ['♥', '♠', '♦', '♣']
  end
end
