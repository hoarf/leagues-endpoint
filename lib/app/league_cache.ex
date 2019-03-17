defmodule App.LeagueCache do
  use GenServer

  alias App.FileService

  # Client

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def get_by(league, season) do
    GenServer.call(__MODULE__, {:get_by, league, season})
  end

  def list() do
    GenServer.call(__MODULE__, :list)
  end

  # Server

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:get_by, league, season}, _from, state) do
    {:reply, FileService.get_by(state, league, season), state}
  end

  @impl true
  def handle_call(:list, _from, state) do
    {:reply, FileService.list(state), state}
  end
end