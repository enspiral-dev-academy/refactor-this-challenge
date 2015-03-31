class Bingo

  attr_accessor :board, :letters, :finished

  def initialize(board)
    @board = board
    @letters = "BINGO".split("")
    @finished = false
  end

  def new_ticket
    {letter: @letters.sample, number: rand(1..100)}
  end

  def column(letter)
    @board.transpose[@letters.index(letter)]
  end

  def mark!(ticket)
    letter = ticket[:letter]
    number = ticket[:number]
    current_column = column(letter)
    if current_column.include?(number)
      @board[current_column.index(number)][@letters.index(letter)] = "X"
    end
  end

  def checking_if_won(line_of_exes)
    if line_of_exes.all? { |i| i == "X" }
      @finished = true
    end
  end

  def check_vertical!
    @board.transpose.each do |col|
      checking_if_won(col)
    end
  end

  def check_horizontal!
    @board.each do |row|
      checking_if_won(row)
    end
  end

  def check_diagonal!
    diagonal = []
    5.times do |i|
      diagonal << @board[i][i]
    end
    checking_if_won(diagonal)
    other_diagonal = []
    5.times do |i|
      other_diagonal << @board[i][4-i]
    end
    checking_if_won(other_diagonal)
  end

  def print_board
    system('clear')
    @board.each do |row|
      row.each { |number| print number.to_s.ljust(4) }
      puts
    end
  end

end