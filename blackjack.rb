require 'colorize'

require_relative 'card_deck.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'winner.rb'

# BlackJack Game
class Blackjack
  attr_accessor :decks, :player, :dealer

  def initialize
    set_player # Player Info

    loop do
      break if player.money.zero?

      puts '----------------------------------------'
      puts "NEW GAME! You have #{player.money.to_s.green} Coins"

      set_deck # Initialize Deck

      betting # Bet Money

      start # Start Game
    end
  end

  def start
    initial_hand
    initial_score

    puts player_hand_details

    play if player.score != 21

    get_winner(player.score, dealer.score)
  end

  def play
    loop do
      break if player.score > 21

      hit = player_hit

      puts player_hand_details

      break unless hit
    end

    dealer_hit
  end

  def dealer_hit
    return if dealer.score >= 16

    dealer.hand << decks.pop
    dealer.score = set_score(dealer.hand)
  end

  def initial_hand
    player.hand = [decks.pop, decks.pop]
    dealer.hand = [decks.pop, decks.pop]
  end

  def initial_score
    player.score = set_score(player.hand)
    dealer.score = set_score(dealer.hand)
  end

  def set_player
    self.player = Player.new
    self.dealer = Dealer.new
  end

  def set_deck
    card_deck = CardDeck.new
    self.decks = card_deck.deck
  end

  def set_score(hand, score = 0)
    card_scores = {
      'A' => 11, 'J' => 10, 'Q' => 10, 'K' => 10, '2' => 2, '3' => 3, '4' => 4,
      '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10
    }

    hand.each do |card|
      card_value = card[0..-2] # To Remove Symbols
      score += card_scores[card_value]
      score -= 10 if card == 'A' && score > 21
    end

    score
  end

  def player_hit
    print "Use 'h' to HIT or 's' to STOP: "
    player_action = gets.chomp.downcase

    return false if player_action != 'h'

    player.hand << decks.pop
    player.score = set_score(player.hand)
  end

  def betting
    money = player.money
    amount = 0
    while amount.zero? || amount > money
      print "Bet should be within 1 to #{money}\nPlace bet: "
      amount = gets.chomp.to_i
    end

    player.bet += amount
    player.money -= amount
  end

  def get_winner(p_score, d_score)
    puts player_hand_details
    puts dealer_hand_details

    winner = Winner.new
    winnings, message = winner.check_winner(p_score, d_score, player.bet)

    puts message

    player.money += winnings
    player.bet = 0
  end

  def player_hand_details
    "Your Hand: #{player.hand.join(' ')} | Score: #{player.score}"
  end

  def dealer_hand_details
    "Dealer's Hand: #{dealer.hand.join(' ')} | Score: #{dealer.score}"
  end
end

puts 'Welcome to BlackJack!'
Blackjack.new
