require "colorize"

class Dragon
  
  def initialize name
    @name = name
    @asleep = true
    @my_babies = []
  end

  def poke
    puts "\nYou approach silently and gently prod #{@name}'s flank.".red
    @asleep = false
    puts "#{@name} stirs. His eyes open to narrow, angry slits.".red
  end

  def feed
    puts "\nYou offer the dragon a sweet from your pocket.".red
    if @asleep == false
      puts "He swipes it greedily from your hand, eats it and promptly falls back into a deep slumber.".red
      @asleep = true
    elsif @asleep == true
      puts "#{@name} sleeps. Pray he stays that way.".red
    end
  end

  def adds_baby(babydragon)
    @my_babies << babydragon
  end


end