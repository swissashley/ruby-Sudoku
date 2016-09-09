require_relative "tile.rb"

class Board
  attr_accessor :grid
  GOLDEN = "123456789"

  def initialize(grid = Array.new(9) {Array.new(9)})
    @grid = grid
  end

  def self.from_file(input_file = "sudoku_solved.txt")
    idx = 0
    new_grid = Array.new(9) {Array.new(9)}
    File.readlines(input_file).map(&:chomp).each do |lines|
      lines.split("").each_with_index do |tile, jdx|
        if tile.to_i != 0
          new_grid[idx][jdx] = Tile.new(tile.to_i, true)
        else
          new_grid[idx][jdx] = Tile.new
        end
      end
      idx += 1
    end
    Board.new(new_grid)
  end

  def position(new_val, pos)
    @grid[pos[0]][pos[1]].value = new_val if !@grid[pos[0]][pos[1]].given
  end

  def render
    @grid.length.times do |i|
      @grid[0].length.times do |j|
        print " #{@grid[i][j].to_s} "
      end
      puts "\n"
    end
  end

  def solved?
    check_rows && check_cols && check_blks
  end

  def check_rows

    @grid.all? do |row|
      row.map { |tile| tile.value.to_s }.sort.join("") == GOLDEN
    end
  end

  def check_cols
    @grid.transpose.all? do |row|
      row.map { |tile| tile.value.to_s }.sort.join("") == GOLDEN
    end
  end

  def check_blks
    squares_array = []
    0.upto(2) do |i|
      one_square_array = []
      0.upto(2) do |j|
        one_square_array << @grid[(i * 3)][(j * 3)..(j * 3 + 2)].flatten.map{ |tile| tile.value.to_s}.sort.join("")
        one_square_array << @grid[(i * 3 + 1)][(j * 3)..(j * 3 + 2)].flatten.map{ |tile| tile.value.to_s}.sort.join("")
        one_square_array << @grid[(i * 3 + 2)][(j * 3)..(j * 3 + 2)].flatten.map{ |tile| tile.value.to_s}.sort.join("")
        squares_array << one_square_array.join("").split("").sort.join
        one_square_array = []
        p squares_array
      end
    end
    squares_array.all? do |string|
      string == GOLDEN
    end
  end



end
