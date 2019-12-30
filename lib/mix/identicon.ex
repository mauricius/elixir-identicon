defmodule Mix.Tasks.Identicon do
  @moduledoc false

  use Mix.Task

  def run(argv) do
    Identicon.CLI.main(argv)
  end
end
