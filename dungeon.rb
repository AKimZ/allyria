require "colorize"

class Dungeon
  attr_accessor :player

  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms = []
  end

  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end

  def start(location)
    @player.location = location
    show_current_description
  end

  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description.red
  end

  def find_room_in_dungeon(reference)
    @rooms.detect{ |room| room.reference == reference}
  end

  def traproom_test
    location = @player.location.to_s
    if location == "traproom"
      return true
      # return location == traproom instead of if block (possibility)  
    end
  end

  def dragonroom_test
    location = @player.location.to_s
    if location == "dragoncave"
      return true
    end
  end

  def treasureroom_test
    location = @player.location.to_s
    if location == "treasureroom"
      return true
    end
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
  end

=begin  def search_connections(direction, connections)
    if .keys.include?(connections)
      # allow player to do their thing
    else 
      puts "You just walked into a wall. Try another"
  end
=end

  def go(direction)
    puts "You go ".red + direction.to_s.red
    @player.location = find_room_in_direction(direction)
    show_current_description
  end

  # might change to player = Struct.new (:name, :location)
 
  class Player
    attr_accessor :name, :location, :bag, :alive

    def initialize(player_name)
      @name = player_name
      @bag = []
      @alive = true
    end

    def alive?
      if @alive == true
        return true
      end
    end

    def add_to_bag(object)
      @bag << object
      puts "You have added #{object} to your bag!".red
    end
  end

  # might change to Room = Struct.new (:reference, :name, :description, :connections)
  class Room
    attr_accessor :reference, :name, :description, :connections

    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end

    def full_description
      @name + "\nYou are in ".red + @description.red
    end

  end
end