defmodule Grid do

  @empty_grid { ".", ".", ".", ".", ".", ".", ".", ".", "."}

  def init() do
    GameState.init()
  end

  def take_turn(pid, position, grid \\ @empty_grid) do
    player = GameState.current_player(pid)
    place(player, position, grid)
  end

  def place(player, position, grid \\ @empty_grid) do
    cond do
      elem(grid, position - 1) == "." -> put_elem(grid, position - 1, player)
      true -> :cell_taken
    end
  end

  def check_winner(grid) do
    cond do
      check_line(grid, "X") -> :x_wins
      check_line(grid, "O") -> :o_wins
      Enum.find(Tuple.to_list(grid), fn cell -> cell == "." end) == nil -> :draw
      true -> :none
    end
  end

  defp check_line(grid, player) do
    lines = [
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 4, 8], [2, 4, 6]
    ]
    Enum.find(lines, fn line -> is_winning_line(grid, line, player) end)
  end

  defp is_winning_line(grid, line, player) do
    Enum.filter(line, fn cell -> elem(grid, cell) == player end)
      |> Enum.count() == 3
  end

  # def draw_grid(), do: draw_grid(@empty_grid)

  def draw_grid(grid \\ @empty_grid) do
    Enum.reduce([0, 3, 6], "", fn x, acc -> acc <> draw_row(grid, x) end) <> "\n"
  end

  defp draw_row(grid, x) do
    " " <> cell(grid, x) <> " | " <> cell(grid, x + 1) <> " | " <> cell(grid, x + 2) <> "\n"
  end

  defp cell(grid, x), do: if grid == nil, do: ".", else: elem(grid, x)

end
