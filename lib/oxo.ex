defmodule Oxo do

  @empty_grid { ".", ".", ".", ".", ".", ".", ".", ".", "."}

  def main(_ \\ []) do
    {:ok, pid} = Grid.init()

    play(pid, @empty_grid)
  end


  def play(pid, grid) do
    IO.puts(Grid.draw_grid(grid))
    cell = IO.gets("Pick a cell from 1-9: ")

    { position, _ } = Integer.parse(cell)
    grid = Grid.take_turn(pid, position, grid)

    is_winner = Grid.check_winner(grid)

    case is_winner do
       :x_wins ->
        IO.puts("X wins")
        IO.puts(Grid.draw_grid(grid))
      :o_wins ->
        IO.puts("O wins")
        IO.puts(Grid.draw_grid(grid))
      :none -> play(pid, grid)
    end
  end

end
