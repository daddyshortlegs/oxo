defmodule GameStateTest do
  use ExUnit.Case
  doctest GameState


  test "should get X as current player" do
    {:ok, pid} = GameState.init()
    player = GameState.current_player(pid)
    assert player == "X"
  end

  test "should get O as current player" do
    {:ok, pid} = GameState.init()
    GameState.current_player(pid)
    player = GameState.current_player(pid)
    assert player == "O"
  end

  test "should go back to X as current player" do
    {:ok, pid} = GameState.init()
    GameState.current_player(pid)
    GameState.current_player(pid)
    player = GameState.current_player(pid)
    assert player == "X"
  end

end
