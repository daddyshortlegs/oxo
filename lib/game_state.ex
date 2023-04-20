defmodule GameState do
  def init() do
    Agent.start_link(fn -> %{} end)
  end

  def current_player(pid) do
    cond do
      get_state(pid) == "X" ->
        save_state(pid, "O")
        "O"
      true ->
        save_state(pid, "X")
        "X"
    end
  end

  defp get_state(pid) do
    Agent.get(pid, fn map -> Map.get(map, :player) end)
  end

  defp save_state(pid, player) do
    Agent.update(pid, fn map -> Map.put(map, :player, player) end)
  end
end
