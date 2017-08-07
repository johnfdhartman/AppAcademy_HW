class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    p 'New game!'
    until @game_over
      take_turn
    end
    @game_over = true
    game_over_message
    reset_game
  end

  def take_turn
    @sequence_length += 1
    show_sequence
    require_sequence
    round_success_message unless @game_over
  end

  def show_sequence
    add_random_color
    seq.each {|colour| p colour}
  end

  def require_sequence
    @sequence_length.times do |i|
      colour = gets.chomp
      break unless colour == @sequence[i]
    end
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    p "hooray, good job"

  end

  def game_over_message
    p "boo, you suck"
  end

  def reset_game
    initialize
  end
end
