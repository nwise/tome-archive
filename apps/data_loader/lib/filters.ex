defmodule DataLoader.Filters do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def all(pid) do
    GenServer.call(pid, :all)
  end

  def filter_keys(pid) do
    GenServer.call(pid, :keys)
  end

  def addons(pid) do
    GenServer.call(pid, {:values, "addons"})
  end

  def campaign(pid) do
    GenServer.call(pid, {:values, "campaign"})
  end

  def class(pid) do
    GenServer.call(pid, {:values, "class"})
  end

  def dead(pid) do
    GenServer.call(pid, {:values, "dead"})
  end

  def difficulty(pid) do
    GenServer.call(pid, {:values, "difficulty"})
  end

  def game(pid) do
    GenServer.call(pid, {:values, "game"})
  end

  def level_max(pid) do
    GenServer.call(pid, {:values, "level_max"})
  end

  def level_min(pid) do
    GenServer.call(pid, {:values, "level_min"})
  end

  def name(pid) do
    GenServer.call(pid, {:values, "name"})
  end

  def permadeath(pid) do
    GenServer.call(pid, {:values, "permadeath"})
  end

  def race(pid) do
    GenServer.call(pid, {:values, "race"})
  end

  def winner(pid) do
    GenServer.call(pid, {:values, "winner"})
  end

  def init(:ok) do
   {:ok, load_filters()}
  end

  def handle_call(:all, _from, body) do
    {:reply, body, body}
  end

  def handle_call(:keys, _from, body) do
    {:reply, Map.keys(body), body}
  end

  def handle_call({:values, key}, _from, body) do
    {:reply, body[key], body}
  end

  defp load_filters do
    IO.puts "Initializing Filters"
    %{body: body} = HTTPoison.get! url()
    body
    |> Poison.decode!
  end

  defp url do
    "#{Application.get_env(:data_loader, :base_url)}/#{Application.get_env(:data_loader, :api_id)}/#{Application.get_env(:data_loader, :api_key)}/characters/get_filters"
  end
end
