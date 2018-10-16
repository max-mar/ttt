require 'io/console'
require 'rainbow'

class Board
  def initialize #Initialise les différentes cases du Board, et l'array du curseur
    @a1 = BoardCase.new
    @b1 = BoardCase.new
    @c1 = BoardCase.new
    @a2 = BoardCase.new
    @b2 = BoardCase.new
    @c2 = BoardCase.new
    @a3 = BoardCase.new
    @b3 = BoardCase.new
    @c3 = BoardCase.new
    @print_array = [ "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   "]
  end

  def check_victory #Variable booleenne qui verifie si victoire il y a en verifiant les 8 possibilites de victoires dans un morpion
    if (@a1.value == @b1.value && @a1.value == @c1.value && @a1.value != 0) || (@a1.value == @a2.value && @a1.value == @a3.value && @a1.value != 0) || (@a2.value == @b2.value && @a2.value == @c2.value && @a2.value != 0) || (@a3.value == @b3.value && @a3.value == @c3.value && @a3.value != 0) || (@a1.value == @b2.value && @a1.value == @c3.value && @a1.value != 0) || (@c1.value == @b2.value && @c1.value == @a3.value && @c1.value != 0) || (@b1.value == @b2.value && @b1.value == @b3.value && @b1.value != 0) || (@c1.value == @c2.value && @c1.value == @c3.value && @c1.value != 0)
      return 1
    else
      return 0
    end
  end

  def change_values (which_one, new_value, n1, n2, s1, s2) #Permet de changer les valeurs des cases quand un joueur en choisit une. Garde les noms et scores en argument pour l'affichage.
    if which_one.downcase == "a1" && @a1.value == 0
      @a1.change_value(new_value)
    elsif which_one.downcase == "a2" && @a2.value == 0
      @a2.change_value(new_value)
    elsif which_one.downcase == "a3" && @a3.value == 0
      @a3.change_value(new_value)
    elsif which_one.downcase == "b1" && @b1.value == 0
      @b1.change_value(new_value)
    elsif which_one.downcase == "b2" && @b2.value == 0
      @b2.change_value(new_value)
    elsif which_one.downcase == "b3" && @b3.value == 0
      @b3.change_value(new_value)
    elsif which_one.downcase == "c1" && @c1.value == 0
      @c1.change_value(new_value)
    elsif which_one.downcase == "c2" && @c2.value == 0
      @c2.change_value(new_value)
    elsif which_one.downcase == "c3" && @c3.value == 0
      @c3.change_value(new_value)
    else 
      puts "Désolé mais tu ne peux pas faire ça, essaye encore"
      print ">>>"
      go_around(STDIN.getch, new_value, n1, n2, s1, s2)
    end
  end

  def go_around(input, value, name1, name2, s1, s2) #Permet de gC)rer le curseur et son affichage. En utilisant la methode read_char pour saisir les input. Elle renvois des lettres car la fonction "changes values" prenait un input en lettre avant cette amelioration. En sauvegardant la compatibilitC), pas besoin de tout recommencer !
    array = [ "a1", "a2", "a3", "b1", "b2", "b3", "c1", "c2", "c3"]
    j = 4 ; i = 0
    while j < 9
      @print_array[i] = '   '
      @print_array[j] = Rainbow('\ /').yellow.bright
      system 'clear' #permet de creer une impretion de continuite en effacant toujours le display precedant
      display(name1, name2, s1, s2)
      puts ">>> Utilise les flèches pour te déplacer et appuie sur ENTRÉE pour jouer"
      input = read_char
      if input == "\e[C" && j < 6
        i = j
        j += 3
      elsif input == "\e[B" && j != 2 && j != 5 && j != 8
        i = j
        j += 1
      elsif input == "\e[A" && j != 0 && j != 3 && j != 6
        i = j
        j -= 1
      elsif input == "\e[D" && j > 2 
        i = j
        j -= 3
      elsif input == "\r"
        @print_array[j] = '   '
        change_values(array[j], value, name1, name2, s1, s2)
        j = 9
      end
    end
  end

  def read_char #Methode trouvee sur Stack OverFlow permet d'avoir les fleches comme input plutot que ZQSD, amelioration non necessaire mais plutot jolie.
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
  ensure
    STDIN.echo = true
    STDIN.cooked!
    return input
  end

  def display(name1, name2, score1, score2) #Affichage avec comme variable le curseur et les cases.
    puts Rainbow("\n\n\n       _________________").bright
    puts Rainbow("      | #{@print_array[0]} | #{@print_array[3]} | #{@print_array[6]} |").bright
    puts Rainbow("      |  #{@a1.print_case}  |  #{@b1.print_case}  |  #{@c1.print_case}  |").bright
    puts Rainbow("      |_____|_____|_____|              [#{name1}] :").bright
    puts Rainbow("      | #{@print_array[1]} | #{@print_array[4]} | #{@print_array[7]} |              -> #{score1} SCORE").bright
    puts Rainbow("      |  #{@a2.print_case}  |  #{@b2.print_case}  |  #{@c2.print_case}  |").bright
    puts Rainbow("      |_____|_____|_____|              [#{name2}] :").bright
    puts Rainbow("      | #{@print_array[2]} | #{@print_array[5]} | #{@print_array[8]} |              -> #{score2} SCORE").bright
    puts Rainbow("      |  #{@a3.print_case}  |  #{@b3.print_case}  |  #{@c3.print_case}  |").bright
    puts Rainbow("      |_____|_____|_____|\n\n\n\n\n\n").bright
  end

end


class BoardCase
  attr_accessor :value
  
  def initialize #Creer les cases vides
    @value = 0
  end

  def change_value (new_value) #Les remplir
    @value = new_value
  end

  def print_case #Les afficher
    if @value == 0
      return " "
    elsif @value == 1
      return Rainbow("O").green.bright
    elsif @value == 2
      return Rainbow("X").red.bright
    end
  end
end


class Player
  attr_reader :name

  def initialize(name, i) #Permet d'appeler les 2 joueurs en leur attribuant une couleur.
    if i == 1
      @name = Rainbow(name).green.bright
    else
      @name = Rainbow(name).red.bright
    end
  end

end


class Game
  def initialize (i=0, p1=0, p2=0, name1="", name2="") #Lance le jeu avec des arguments vides, pour sauvegarder les donnees en cas de nouvelles parties
    if i == 0 #Commence ici en cas de premiere partie...
      print "Une petite partie ? Entre ton nom >>> "
      @player1 = Player.new(gets.chomp.upcase, 1)
      puts "Cool, #{@player1.name} mais tu ne vas pas jouer tout seul si ? Ton adversaire"
      print "c'est :"
      @player2 = Player.new(gets.chomp.upcase, 2)
      puts "Ok, c'est parti pour un match entre #{@player1.name} et #{@player2.name} !"
    else # ...et lC  pour les suivantes
      @player1 = Player.new(name1, 1)
      @player2 = Player.new(name2, 2)
      puts "C'est reparti avec #{p1} victoires pour #{Rainbow(@player1.name).green.bright} et #{p2} victoires pour #{Rainbow(@player2.name).red.bright} !"
    end
    playing(i, p1, p2)
  end

  def playing (i, p1, p2)
    @da_game = Board.new #Initialise le tableau
    print "N'importe quelle touche pour continuer"
    STDIN.getch #Juste pour faire une petite pause
    l = 0
    if i % 2 == 0 then x = 0 else x = 1 end #Ici grace aux modulo je determine les tours des joueurs
    while @da_game.check_victory == 0 && x < 9 #Et ici la boucle des tours s'organise en appelant la methode go_around joueur par joueur.
      system 'clear' #Sert a wipe le tableau pour créer l'illusion.
      @da_game.display(@player1.name, @player2.name, p1, p2)
      if x % 2 == 0
        puts "À #{@player1.name}"
        l = 1
      else
        puts "À #{@player2.name}"
        l = 2
      end
      @da_game.go_around(STDIN.getch, l, @player1.name, @player2.name, p1, p2)
      x += 1
    end
    system 'clear'
    @da_game.display(@player1.name, @player2.name, p1, p2)
    if @da_game.check_victory == 1
      print Rainbow("ET LE GAGNANT EST ").bright.silver
      if l == 1
        print @player1.name
        p1 += 1
      elsif l == 2
        print @player2.name
        p2 += 1
      end
      print Rainbow(" !!!!!\n").bright.silver
    else 
      puts "Match nul...\n\n"
    end
    puts "...Un autre match ? [o/n]"
    rep = STDIN.getch
    while rep != "o" && rep != "n"
      puts "Je n'ai pas compris\n- Pour continuer rentre O\n- Et pour quitter N"
      rep = STDIN.getch.lowcase
    end
    if rep == "o"
      i += 1
      newgame = Game.new(i, p1, p2, @player1.name, @player2.name) #relance le jeu avec les données de la partie precdente
    else
      exit
    end
  end
end

newgame = Game.new

=begin 

require 'colorize'
#Appelle la gem colorize pour colorer X et O, c'est plus sympa
@round = "O".colorize(:green)
@cross = "X".colorize(:red)
#je déclaire ces valeurs avec @ pour les réutiliser sur tout le programme 


@w1 = 0
@w2 = 0
#Je déclare ces numéros pour le compteur 

puts "Entre ton nom joueur A :"
A = gets.chomp.to_s.colorize(:red) 
puts "#{A} jouera en premier, avec les #{@cross}"
puts ""
puts "Entre ton nom joueur B :"
B = gets.chomp.to_s.colorize(:green) 
puts "#{B} jouera en second, avec les #{@round}"
puts ""
# Rentrer le nom des joueurs
# d'abord, un tableau vide avec des variables = espaces vides 
def fresh_table
  @a1 = " "
  @a2 = " "
  @a3 = " "
  @b1 = " "
  @b2 = " "
  @b3 = " "
  @c1 = " "
  @c2 = " "
  @c3 = " "
end

#on fait rentrer ces variables dans un array
def squares
  [@a1, @a2, @a3, @b1, @b2, @b3, @c1, @c2, @c3]
  
end
# ce qui permet de défnir les combos gagnants pour le jeu. 
def win_combos 
  [[@a1, @a2, @a3],
  [@a1, @b2, @c3],
  [@a1, @b1, @c1],
  [@b1, @b2, @b3],
  [@c1, @c2, @c3],
  [@c1, @b2, @a3],
  [@a2, @b2, @c2],
  [@a3, @b3, @c3]]
  
end

# imprimer la grille qui contient les valeurs vides des variables en @a @b @c  
def print_grid
  puts
  puts "   1   2   3"
  puts "A  #{@a1} | #{@a2} | #{@a3} " 
  puts "  ---|---|---"
  puts "B  #{@b1} | #{@b2} | #{@b3} "
  puts "  ---|---|---"
  puts "C  #{@c1} | #{@c2} | #{@c3} "
  puts
  check_for_winner
  
end

#def method to check if user's choice of move is valid/available. this should be called only after the player has had 3 turns but I don't know how to do that. 
def check_validity square_availability
  if square_availability == " "
    true
  else
    false
    puts "Cet espace est déjà pris, choisis un autre"
  end
end

def user1_turn
  user_choice_hash = {"a1" => @a1,
                      "a2" => @a2,
                      "a3" => @a3,
                      "b1" => @b1,
                      "b2" => @b2,
                      "b3" => @b3,
                      "c1" => @c1,
                      "c2" => @c2,
                      "c3" => @c3}
                    

  puts "#{A}, choisit une case :"
  user_choice = gets.chomp.downcase
  user_choice_hash.each do |choice, square|
    if user_choice == choice 
      if check_validity(square)
        square.sub!(" ", @cross) 
        print_grid
      else 
      user_choice = gets.chomp.downcase
        if check_validity(square)
          square.sub!(" ", @cross)  
          print_grid
        end  
    end
    elsif user_choice == "q" or user_choice == "quit"
      exit
    end
  end
  #check_for_winner
end

def user2_turn
  user_choice_hash = {"a1" => @a1,
    "a2" => @a2,
    "a3" => @a3,
    "b1" => @b1,
    "b2" => @b2,
    "b3" => @b3,
    "c1" => @c1,
    "c2" => @c2,
    "c3" => @c3}

 puts "#{B}, choisit une case :"   
  user_choice = gets.chomp.downcase
  user_choice_hash.each do |choice, square|
    if user_choice == choice 
      if check_validity(square)
        square.sub!(" ", @round) 
        print_grid
      else 
        user_choice = gets.chomp.downcase
          if check_validity(square)
            square.sub!(" ", @round)  
            print_grid
          end  
      end
    elsif user_choice == "q" or user_choice == "quit"
      exit
    end
  end
  #check_for_winner
end

def check_for_winner 
  win_combos.each do |combos| 
    if combos[0] == @round && combos[1] == @round && combos[2] == @round 
      @w2 += 1
      puts "#{B} remporte la partie !"
      otra
      #exit 
    elsif combos[0] == @cross && combos[1] == @cross && combos[2] == @cross
      @w1 += 1 
      puts "#{A} remporte la partie !"
      otra 

      #exit
    #else
      #puts "Tie! Enter q to quit game."
    end
  end
end


def start_game
  puts "Bienvenu dans le Morpion / tic-tac-toe / tres en raya"
  puts "Pour placer votre signe sur la grille, utilisez les coordonnées (ex--a1, b3)."
  puts "Vous pouvez quitter à tout moment en rentrant q"
  puts "#{@round} #{@round} #{@round} #{@cross} #{@cross} #{@cross} " * 6
end

def otra
puts "#{A} : #{@w1} victoires \n#{B} : #{@w2} victoires" 
puts " \n "
puts "une autre partie ? o/n"
rep = gets.chomp.to_s 
if rep == "o"
puts "en avant !"
puts " "
fresh_table
print_grid
else
  exit
end 
end 

def run_game
  start_game
  fresh_table
  while true
    print_grid
    user1_turn
    user2_turn
  end 
end

run_game

=end 


