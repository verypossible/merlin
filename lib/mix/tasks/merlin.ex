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
  alias Merlin.Config

  @impl Mix.Task
  def run(args) do
    %{path: path} = parse_args(args)
    {config, _do_prompt} = get_config(path)
    persist_config(config)
  end

  defp parse_args(args) do
    Clhi.info("args: #{inspect(args)}")

    {parsed, _args, _invalid} =
      OptionParser.parse(args, strict: [config: :string, no_config: :boolean])

    %{path: Keyword.get(parsed, :config, "")}
  end

  defp get_config(path) do
    case Config.get(path) do
      {:ok, config} ->
        {config, false}

      {:error, :not_found} ->
        Clhi.info("using default config")
        {Config.new(), true}

      {:error, error} ->
        Clhi.info("reading config failed: #{inspect(error)}")
    end
  end

  defp persist_config(config) do
    case Config.write(config) do
      {:ok, path} ->
        Clhi.info(~s(config persisted to "#{path}"))

      {:error, error} ->
        Clhi.error([
          "failed to persist config with error: #{inspect(error)}",
          "\n\n",
          "config:",
          "\n\n",
          "#{inspect(config)}"
        ])
    end
  end
end
