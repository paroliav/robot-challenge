require_relative 'table'

class Robot
  class InvalidCommandError < StandardError; end

  attr_accessor :table, :x, :y, :face, :placed

  REGEX_PLACE = /^(PLACE|Place|place) \d,\d,(NORTH|SOUTH|EAST|WEST)$/
  REGEX_MOVE = /^(MOVE|Move|move)$/
  REGEX_LEFT = /^(LEFT|Left|left)$/
  REGEX_RIGHT = /^(RIGHT|Right|right)$/
  REGEX_REPORT = /^(REPORT|Report|report)$/

  def initialize
    @table = Table.new
    puts 'Robot ready...'
    puts 'Please place me on the table'
  end

  def process_command(command)
    case command
    when REGEX_PLACE
      process_place(command)
    when REGEX_MOVE
      @placed && @face.move(self)
    when REGEX_LEFT
      @placed && @face.left(self)
    when REGEX_RIGHT
      @placed && @face.right(self)
    when REGEX_REPORT
      puts @placed && report
    else
      raise InvalidCommandError
    end
  end

  class North

    def self.name
      "North"
    end

    def self.move(robot)
      return unless robot.table.valid?(x: robot.x, y: robot.y+1)
      robot.y += 1
    end

    def self.left(robot)
      robot.face = West
    end

    def self.right(robot)
      robot.face = East
    end

  end

  class South

    def self.name
      "South"
    end

    def self.move(robot)
      return unless robot.table.valid?(x: robot.x, y: robot.y-1)
      robot.y -= 1
    end

    def self.left(robot)
      robot.face = East
    end

    def self.right(robot)
      robot.face = West
    end

  end

  class East

    def self.name
      "East"
    end

    def self.move(robot)
      return unless robot.table.valid?(x: robot.x+1, y: robot.y)
      robot.x += 1
    end

    def self.left(robot)
      robot.face = North
    end

    def self.right(robot)
      robot.face = South
    end

  end

  class West

    def self.name
      "West"
    end

    def self.move(robot)
      return unless robot.table.valid?(x: robot.x-1, y: robot.y)
      robot.x -= 1
    end

    def self.left(robot)
      robot.face = South
    end

    def self.right(robot)
      robot.face = North
    end

  end

  private

  def process_place(command)
    regexp = /\d,\d,(NORTH|SOUTH|EAST|WEST)$/
    coordinates = regexp.match(command)[0].split(",")
    return unless @table.valid?(x: coordinates[0].to_i, y: coordinates[1].to_i)
    @x = coordinates[0].to_i
    @y = coordinates[1].to_i
    @face = FACE_CLASS.fetch coordinates[2]
    @placed = true
  end

  def report
    return 'Current position: '+@x.to_s+','+@y.to_s+','+@face.name
  end

  FACE_CLASS = { 'NORTH' => North, 'SOUTH' => South, 'EAST' => East, 'WEST' => West }

end
