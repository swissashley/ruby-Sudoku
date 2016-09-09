require 'colorize'

class Tile
  attr_accessor :value, :given

  def initialize(value = 0, given = false)
    @value = value
    @given = given
  end

  def to_s
    if @given
      @value.to_s.colorize(:blue)
    else
      @value.to_s.colorize(:red)
    end
  end
end
