# A text-based adventure game! 10/31/13

# Still to do:
# Allow the player to enter shorthand directions ("n" for "north" "nw" for "northwest" etc.)
# Puts an error message if the player enters a direction not allowed
# if block for gender of the dragon (????)
# switch trapped so that it puts the rat ASCII
# more items
# dragon moves around...time dependent
# pick up food. You can only feed the dragon if you have food.
# breakup the while loop into smaller functions
# room sub-classes...dragonroom, traproom, etc.
# room instance variables instead of trapped etc.
# Class for user IO
# reject (array/hash) instead of using the trapped etc. variables. 

require "./dragon.rb"
require "colorize"
require "./ASCII.rb"
require "./dungeon.rb"

def first_greeting
  puts "\nWelcome to Allyria: a text-based roleplaying game for the easily amused.".white.on_red
end

def subsequent_greetings
  puts "\nWelcome back to Allyria: you are easily amused *and* a masochist.".white.on_red
end

play_again = "yes"
count = 0

while play_again[0] == "y"
  if count == 0
    first_greeting
  else
    subsequent_greetings
  end

  puts "\nIdentify yourself: "
   name = gets.chomp

  puts "\nCeci est l'empire du mort, chere ".red + name.red
  puts "\n**********************************************".red

 # Create the main dungeon object
  my_dungeon = Dungeon.new(name)

 # Add rooms to the dungeon 
  my_dungeon.add_room(:largecave, "\nLarge Cave", "a large cavernous cave", {:south => :smallcave, :north => :traproom })
  my_dungeon.add_room(:traproom, "\nRoom 101", "The Ministry of Love", {:south => :largecave}) 
  my_dungeon.add_room(:smallcave, "\nSmall Cave", "a small, claustrophobic cave", {:north => :largecave, :south => :smallercave})
  my_dungeon.add_room(:smallercave, "\nSmaller Cave", "a really, really small cave. Your head scrapes on some stalagtites.",
  {:north => :smallcave, :east => :treasureroom, :west => :dragoncave}) # The digit at the end of treasure room is because I want treasureroom to be a repeated find
  my_dungeon.add_room(:treasureroom, "\nTreasure room", "a room with a treasure chest in it!", {:west => :smallercave}) 
  my_dungeon.add_room(:dragoncave, "\nSmaug's Lair", "a stiflingly hot cave with a rancid, musty odor.", {:east => :smallercave} )

  #Start the dungeon by placing the player in the large cave my_dungeon.start(:largecave)
  my_dungeon.start(:largecave)

  trapped = false #room instance variable
  burnt = false #room instance variable
  rich = false #room instance variable
  alive = my_dungeon.player.alive?

  while alive == true
    puts "\nChoose your path.".red
    where = gets.chomp.to_sym
    my_dungeon.go(where)
    trapped = my_dungeon.traproom_test
    burnt = my_dungeon.dragonroom_test
    rich = my_dungeon.treasureroom_test
    if burnt == true
      beast = Dragon.new("Smaug")
      sleeping_dragon
      puts "\nA enormous dragon slumbers peacefully in a corner...for now.".red
      puts "\nThe void calls. Would you like to poke him?".red
      answer = gets.chomp
      if answer[0].downcase == "y"
        beast.poke
        you_woke_the_dragon
        puts "\nUh-oh. You should probably feed him.".red
        puts "Would you like to feed him?".red
        response = gets.chomp
        if response[0].downcase == "y"
          beast.feed
          puts "\nPhew. That was a close one. You should probably get out of here before he wakes up again.".red
        else
          dragonfire
          puts "\nThe dragon bathes you in dragonfire. You have just enough time to contemplate your poor decision making skills before your synapses singe.".red
          alive = false
        end
      else
        puts "\nGood call. You'd go far in a more forgiving dungeon.".red
      end
    end
    if rich == true
      puts "Would you like to open the chest?".red
      response = gets.chomp.downcase
      if response[0] == "y"
        puts "\nYou open the chest to discover a dazzling blue diamond.".red
        sparkly_diamond
        diamond = "diamond"
        my_dungeon.player.add_to_bag(diamond)
      else
        puts "You back out of the room distrustfully.".red
      end
    end
    if trapped == true
      worst_fear
      alive = false
    end
  end

  puts "\nYou died horribly and gruesomely. Sorry :(".white.on_red

  puts "\nPlay again?".red
  play_again = gets.chomp.downcase

  count = count + 1 # use += ??

end


