class Board
  def initialize
    @board = []
    81.times { @board << Tile.new }
  end
end

class Tile
end