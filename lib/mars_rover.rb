class Coordinate
  attr_accessor :x, :y

  def initialize(x, y)
    self.x = x
    self.y = y
  end

  def ==(other)
    self.x == other.x && self.y == self.y
  end
end

class Direction
  def rotate_left
    fail NotImplementedError
  end

  def rotate_right
    fail NotImplementedError
  end
  def move_forward(coordinate)
    fail NotImplementedError
  end

  def move_backward(coordinate)
    fail NotImplementedError
  end
end

class North < Direction
  def rotate_left
    West.new
  end
  def rotate_right
    East.new
  end
  def move_forward(coordinate)
    Coordinate.new(coordinate.x - 1, coordinate.y)
  end
  def move_backward(coordinate)
    Coordinate.new(coordinate.x + 1, coordinate.y)
  end
end


class South < Direction
  def rotate_left
    East.new
  end
  def rotate_right
    West.new
  end
  def move_forward(coordinate)
    Coordinate.new(coordinate.x + 1, coordinate.y)
  end
  def move_backward(coordinate)
    Coordinate.new(coordinate.x - 1, coordinate.y)
  end
end

class West < Direction
  def rotate_left
    South.new
  end
  def rotate_right
    North.new
  end
  def move_forward(coordinate)
    Coordinate.new(coordinate.x, coordinate.y - 1)
  end
  def move_backward(coordinate)
    Coordinate.new(coordinate.x, coordinate.y + 1)
  end
end

class East < Direction
  def rotate_left
    North.new
  end
  def rotate_right
    South.new
  end
  def move_forward(coordinate)
    Coordinate.new(coordinate.x, coordinate.y + 1)
  end
  def move_backward(coordinate)
    Coordinate.new(coordinate.x, coordinate.y - 1)
  end
end

class MarsRover
  attr_accessor :coordinate, :direction

  def initialize(coordinate = Coordinate.new(0,0), direction = North.new)
    self.coordinate = Coordinate.new(x=0,y=0)
    self.direction = direction
  end

  def receive_command(commands)
    individual_commands = commands.split('')
    individual_commands.each { |command|
      case command
        in 'f'
          move_forwards
        in 'b'
          move_backwards
        in 'l'
          rotate_left
        in 'r'
          rotate_right
        else
          raise("error en la lectura del comando")
        end
    }
  end

  private
  def move_forwards
    self.coordinate = self.direction.move_forward(coordinate)
  end

  private
  def move_backwards
    self.coordinate = self.direction.move_backward(coordinate)
  end

  private
  def rotate_left
    self.direction = self.direction.rotate_left
  end

  private
  def rotate_right
    self.direction = self.direction.rotate_right
  end
end