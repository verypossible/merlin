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

  @path_write ".merlin.exs"

  @impl Mix.Task
  def run(args) do
    %{path: path} = parse_args(args)
    {config, _do_prompt} = get_config(path)
    step(:persist_config, config)
  end

  defp parse_args(args) do
    {parsed, _args, _invalid} =
      OptionParser.parse(args, strict: [config: :string, no_config: :boolean])

    %{path: Keyword.get(parsed, :config, "")}
  end

  defp get_config(path) do
    case Config.get(path) do
      {:ok, config} ->
        {config, false}

      {:error, :not_found} ->
        Clhi.info("Using default config.")
        {Config.new(), true}

      {:error, error} ->
        Clhi.error(["Reading config failed:", "\n\n", "#{inspect(error)}"])
    end
  end

  defp step(:persist_config, config) do
    with :ok <- should_persist_config(),
         :ok <- can_persist_config() do
      persist_config(config)
    else
      {:error, error} when error in [:no_persist, :no_overwrite] ->
        Clhi.info(["Config not persisted:", "\n\n", "#{inspect(config, pretty: true)}"])
    end
  end

  defp should_persist_config do
    case Clhi.ask(
           "Create a .merlin.exs config with your choices?",
           [],
           boolean_options: true,
           default: "y"
         ) do
      true -> :ok
      false -> {:error, :no_persist}
    end
  end

  defp can_persist_config do
    case File.exists?(@path_write) do
      true ->
        can_overwrite_config()

      false ->
        :ok
    end
  end

  defp can_overwrite_config do
    case Clhi.ask(
           "A .merlin.exs config already exists, overwrite it?",
           [],
           boolean_options: true,
           default: "n",
           level: :warn
         ) do
      true -> :ok
      false -> {:error, :no_overwrite}
    end
  end

  defp persist_config(config) do
    case Config.write(config) do
      {:ok, path} ->
        Clhi.info(~s(Config persisted to "#{path}".))

      {:error, error} ->
        Clhi.error([
          "Failed to persist config with error:",
          "\n\n",
          "#{inspect(error)}",
          "\n\n",
          "config:",
          "\n\n",
          "#{inspect(config)}"
        ])
    end
  end
end
