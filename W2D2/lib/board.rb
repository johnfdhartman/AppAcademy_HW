class Board
  attr_accessor :cups
  attr_reader :player1, :player2

  STORE_ONE = 6
  STORE_TWO = 13

  def initialize(name1, name2)
    @player1 = name1
    @player2 = name2
    @cups = place_stones
    @player_stores = { @player1 => STORE_ONE, @player2 => STORE_TWO }
    @opponent_stores = { @player2 => STORE_ONE, @player1 => STORE_TWO }
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    empty_cups = Array.new(14) { Array.new }

    empty_cups.map.with_index do |cup, idx|
      if idx == STORE_ONE || idx == STORE_TWO
        cup
      else
        4.times { cup << :stone }
        cup
      end
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos < 0 || start_pos > 12
    raise "Invalid starting cup" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = cups[start_pos]
    cups[start_pos] = Array.new

    pos = start_pos
    until stones.empty?
      pos += 1
      pos = 0 if pos > 13

      if pos == 6
        @cups[6] << stones.pop if current_player_name == @player1
      elsif pos == 13
        @cups[13] << stones.pop if current_player_name == @player2
      else
        @cups[pos] << stones.pop
      end
    end

    render
    next_turn(pos)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns#
    if ending_cup_idx == STORE_ONE || ending_cup_idx == STORE_TWO
      :prompt
    elsif @cups[ending_cup_idx].count == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    cups.slice(0, 6).all?(&:empty?) || cups.slice(7, 6).all?(&:empty?)
  end

  def winner
    if cups[STORE_ONE].size > cups[STORE_TWO].size
      player1
    elsif cups[STORE_TWO].size > cups[STORE_ONE].size
      player2
    else
      :draw
    end
  end
end
