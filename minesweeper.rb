class Board
  def initialize
    @board = []
    81.times { @board << Tile.new() }
    @bombs = 10
  end

  def place_bombs
    arry = @board.combination(@bombs).sample
  end
end

class Tile
  def initialize(flag, x, y, board, bomb)
    @flag = flag
    @pos = [x, y]
    @board = board
    @bomb = bomb
  end

  def reveal
  end

  def bomb_count
  end
end