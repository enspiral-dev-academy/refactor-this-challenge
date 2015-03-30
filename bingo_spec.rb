require_relative './bingo.rb'

def assert_true(test)
  raise "should return true" unless test == true
  puts "passed"
end

def assert_equal(actual, expected)
  raise "expected #{expected} but got #{actual}" unless expected == actual
  puts "passed"
end

def assert_false(test)
  raise "should return false" if test != false
  puts "passed"
end

def assert_membership(item, collection)
  raise "#{item} not present in collection: #{collection}" unless collection.include?(item)
  puts "pa  ssed"
end

def assert_within_range(item, low, high)
  raise "got #{item}, but should be between #{low} and #{high}" unless item.between?(low,high)
  puts "passed"
end

sample_board = [[47, 44, 71, 8, 88],
                [22, 69, 75, 65, 73],
                [83, 85, 97, 89, 57],
                [25, 31, 96, 68, 51],
                [75, 70, 54, 80, 83]]

# Bingo#initialize(board)
  bingo = Bingo.new(sample_board)
  assert_equal(bingo.board, sample_board)
  assert_equal(bingo.letters,"BINGO".split(''))
  assert_false(bingo.finished)

# Bingo#new_ticket
  # returns a hash with a 'letter' B,I,N,G, or O, and a random number 'number' between 1 and 100
  ticket = bingo.new_ticket
  assert_membership(ticket[:letter],bingo.letters)
  assert_within_range(ticket[:number], 1, 100)

# Bingo#column(letter)
  # given a letter, returns corresponding column
  assert_equal(bingo.column("I"),[44,69,85,31,70])
  assert_equal(bingo.column("G"),[8,65,89,68,80])

# Bingo#mark!(ticket)
  # when given a ticket with a value not existing on the board, nothing happens
  ticket = {letter: "B", number: 100}
  bingo.mark!(ticket)
  assert_equal(bingo.board, sample_board)
  # when given a ticket with a value existing on the board, replaces value with "X"
  ticket = {letter: "I", number: 44}
  bingo.mark!(ticket)
  assert_equal(bingo.board[0][1],"X")

# Bingo#check_vertical!
  # if vertical win state, sets 'finished' to true
vertical_win_board = [[47, "X", 71, 8, 88],
                      [22, "X", 75, 65, 73],
                      [83, "X", 97, 89, 57],
                      [25, "X", 96, 68, 51],
                      [75, "X", 54, 80, 83]]
bingo = Bingo.new(vertical_win_board)
bingo.check_vertical!
assert_true(bingo.finished)

# Bingo#check_horizontal!
  # if horizontal win state, sets 'finished' to true

  horizontal_win_board = [[47, 44, 71, 8, 88],
                          [22, 69, 75, 65, 73],
                          [83, 85, 97, 89, 57],
                          ["X","X","X","X","X"],
                          [75, 70, 54, 80, 83]]
  bingo = Bingo.new(horizontal_win_board)
  bingo.check_horizontal!
  assert_true(bingo.finished)

# Bingo#check_diagonal!
  # if diagonal win state, sets 'finished' to true
  diagonal_win_board = [["X", 44, 71, 8, 88],
                        [22, "X", 75, 65, 73],
                        [83, 85, "X", 89, 57],
                        [25, 31, 96, "X", 51],
                        [75, 70, 54, 80, "X"]]
  bingo = Bingo.new(diagonal_win_board)
  bingo.check_diagonal!
  assert_true(bingo.finished)

  diagonal_win_board = [[47, 44, 71, 8, "X"],
                        [22, 69, 75, "X", 73],
                        [83, 85, "X", 89, 57],
                        [25, "X", 96, 68, 51],
                        ["X", 70, 54, 80, 83]]
  bingo = Bingo.new(diagonal_win_board)
  bingo.check_diagonal!
  assert_true(bingo.finished)

# Bingo#check_**!
  # if no win state, check_vertical/horizontal/diagonal do not update finished to true


  sample_board = [[47, 44, 71, 8, 88],
                  [22, 69, 75, 65, 73],
                  [83, 85, 97, 89, 57],
                  [25, 31, 96, 68, 51],
                  [75, 70, 54, 80, 83]]
  bingo = Bingo.new(sample_board)
  bingo.check_diagonal!
  bingo.check_horizontal!
  bingo.check_vertical!
  assert_false(bingo.finished)