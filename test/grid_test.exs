defmodule GridTest do
  use ExUnit.Case
  doctest Grid

  test "draws a grid" do
    assert Grid.draw_grid(nil) == """
     . | . | .
     . | . | .
     . | . | .

    """
  end

  test "place X in top left" do
    grid = Grid.place("X", 1)

    assert Grid.draw_grid(grid) == """
     X | . | .
     . | . | .
     . | . | .

    """
  end

  test "place X in top middle" do
    grid = Grid.place("X", 2)
    assert Grid.draw_grid(grid) == """
     . | X | .
     . | . | .
     . | . | .

    """
  end

  test "place X in top right" do
    grid = Grid.place("X", 3)
    assert Grid.draw_grid(grid) == """
     . | . | X
     . | . | .
     . | . | .

    """
  end

  test "place X in middle left" do
    grid = Grid.place("X", 4)
    assert Grid.draw_grid(grid) == """
     . | . | .
     X | . | .
     . | . | .

    """
  end

  test "place X in middle" do
    grid = Grid.place("X", 5)
    assert Grid.draw_grid(grid) == """
     . | . | .
     . | X | .
     . | . | .

    """
  end

  test "place X in middle right" do
    grid = Grid.place("X", 6)
    assert Grid.draw_grid(grid) == """
     . | . | .
     . | . | X
     . | . | .

    """
  end

  test "place X in bottom left" do
    grid = Grid.place("X", 7)
    assert Grid.draw_grid(grid) == """
     . | . | .
     . | . | .
     X | . | .

    """
  end

  test "place X in bottom middle" do
    grid = Grid.place("X", 8)
    assert Grid.draw_grid(grid) == """
     . | . | .
     . | . | .
     . | X | .

    """
  end

  test "place X in bottom right" do
    grid = Grid.place("X", 9)
    assert Grid.draw_grid(grid) == """
     . | . | .
     . | . | .
     . | . | X

    """
  end

  test "should return cell_taken when picking non-empty cell" do
    grid = Grid.place("X", 1)
    result = Grid.place("X", 1, grid)
    assert result == :cell_taken
  end

  test "should fill 2 cells" do
    grid = Grid.place("X", 1)
    grid = Grid.place("X", 2, grid)
    assert elem(grid, 1) == "X"
  end

  test "should place an X" do
    {:ok, pid} = Grid.init()
    grid = Grid.take_turn(pid, 1)
    assert elem(grid, 0) == "X"
  end

  test "should place an O" do
    {:ok, pid} = Grid.init()
    grid = Grid.take_turn(pid, 1)
    grid = Grid.take_turn(pid, 2, grid)
    assert elem(grid, 0) == "X"
    assert elem(grid, 1) == "O"
  end

  test "should place another X" do
    {:ok, pid} = Grid.init()
    grid = Grid.take_turn(pid, 1)
    grid = Grid.take_turn(pid, 2, grid)
    grid = Grid.take_turn(pid, 3, grid)
    assert elem(grid, 0) == "X"
    assert elem(grid, 1) == "O"
    assert elem(grid, 2) == "X"
  end

  test "should place another O" do
    {:ok, pid} = Grid.init()
    grid = Grid.take_turn(pid, 1)
    grid = Grid.take_turn(pid, 2, grid)
    grid = Grid.take_turn(pid, 3, grid)
    grid = Grid.take_turn(pid, 9, grid)
    assert elem(grid, 0) == "X"
    assert elem(grid, 1) == "O"
    assert elem(grid, 2) == "X"
    assert elem(grid, 8) == "O"
  end

  test "should return X wins for left column" do
    {:ok, pid} = Grid.init()
    grid = {
      "X", "O", ".",
      "X", "O", ".",
      "X", ".", "."}

    assert Grid.check_winner(grid) == :x_wins
  end

  test "should return O wins for left column" do
    {:ok, pid} = Grid.init()
    grid = {
      "O", "X", ".",
      "O", "X", ".",
      "O", ".", "."}

    assert Grid.check_winner(grid) == :o_wins
  end

  test "should return X wins for middle column" do
    {:ok, pid} = Grid.init()
    grid = {
      "O", "X", ".",
      "O", "X", ".",
      ".", "X", "."}

    assert Grid.check_winner(grid) == :x_wins
  end

  test "should return X wins for right column" do
    {:ok, pid} = Grid.init()
    grid = {
      ".", "O", "X",
      ".", "O", "X",
      ".", ".", "X"}

    assert Grid.check_winner(grid) == :x_wins
  end

  test "should return X wins for top row" do
    {:ok, pid} = Grid.init()
    grid = {
      "X", "X", "X",
      ".", "O", "X",
      ".", ".", "O"}

    assert Grid.check_winner(grid) == :x_wins
  end

  test "should return X wins for middle row" do
    {:ok, pid} = Grid.init()
    grid = {
      ".", "O", "X",
      "X", "X", "X",
      ".", ".", "O"}

    assert Grid.check_winner(grid) == :x_wins
  end

  test "should return X wins for bottom row" do
    {:ok, pid} = Grid.init()
    grid = {
      ".", "O", "X",
      ".", ".", "O",
      "X", "X", "X"
    }

    assert Grid.check_winner(grid) == :x_wins
  end

  test "should return X wins for diagonal 1" do
    {:ok, pid} = Grid.init()
    grid = {
      "X", "O", ".",
      ".", "X", "O",
      ".", ".", "X"
    }

    assert Grid.check_winner(grid) == :x_wins
  end

  test "should return X wins for diagonal 2" do
    {:ok, pid} = Grid.init()
    grid = {
      ".", "O", "X",
      ".", "X", "O",
      "X", ".", "."
    }

    assert Grid.check_winner(grid) == :x_wins
  end

  test "should return O wins for diagonal 2" do
    {:ok, pid} = Grid.init()
    grid = {
      ".", "X", "O",
      ".", "O", "X",
      "O", ".", "."
    }

    assert Grid.check_winner(grid) == :o_wins
  end

  test "should return draw" do
    {:ok, pid} = Grid.init()
    grid = {
      "X", "O", "X",
      "X", "X", "O",
      "O", "X", "O"}
    assert Grid.check_winner(grid) == :draw
  end



end
