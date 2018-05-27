defmodule Mix.Tasks.Merlin do
  @moduledoc """
  Bootstraps an Elixir project.

  If a `.merlin.exs` file does not yet exist, the task will prompt the user for input as necessary
  while executing steps, allowing any given step to be skipped.

  If a `.merlin.exs` file already exists, the task will ask if it should use it, such that the
  user does not have to answer any further questions. This may be overridden in the `.merlin.exs`.

  ## Options

  * `--config` - the path to the config to use. Default: the project root.

  * `--no-config` - forces the task to ask the user for input
  """

  use Mix.Task
  import Clhi

  @impl Mix.Task
  def run(args) do
    info("args: #{inspect(args)}")
  end
end
