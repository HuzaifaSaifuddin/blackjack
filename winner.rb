# Check & Declare Winner
class Winner
  def initialize; end

  def check_winner(p_score, d_score, player_bet)
    winnings = if p_score == 21 && d_score != 21
                 player_bet * 2.5
               elsif p_score <= 21 && (d_score > 21 || p_score > d_score)
                 player_bet * 2
               elsif (p_score == d_score) && (p_score <= 21)
                 player_bet
               else
                 0
               end

    declare_winner(winnings, player_bet)
  end

  def declare_winner(winnings, player_bet)
    message = winnings.zero? ? ['lose', player_bet] : ['win', winnings]
    output = "You #{message[0]} #{message[1]} Coins".green

    [winnings, output]
  end
end
