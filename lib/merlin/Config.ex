defmodule Merlin.Config do
  @moduledoc """
  Module for creating and working with Merlin configurations.
  """

  defstruct [
    :editor_config,
    :envrc,
    :docker_compose,
    :circleci,
    :tool_versions,
    :formatter,
    :dependencies,
    :cmds,
    :persist_config
  ]

  @typedoc """
  The contents of a `.editorconfig` to be created in the project's root.
  """
  @type editor_config :: keyword(String.t())

  @typedoc """
  The contents of a `.envrc` to be created in the project's root.
  """
  @type envrc :: keyword(String.t())

  @typedoc """
  The contents of a `docker-compose.yml` to be created in the project's root.
  """
  @type docker_compose :: keyword()

  @typedoc """
  The contents of a `.circleci/config.yml` to be created in the project's root.
  """
  @type circleci :: keyword()

  @typedoc """
  The contents of a `.tool-versions` to be created in the project's root.
  """
  @type tool_versions :: keyword(String.t())

  @typedoc """
  The contents of a `.formatter.exs` file to be created in the project's root.
  """
  @type formatter :: keyword() | false

  @typedoc """
  A list of dependencies to be added to the root `mix.exs` dependencies.
  """
  @type dependencies :: [{atom(), String.t()} | {atom(), String.t(), keyword()}]

  @typedoc """
  Shell commands to be ran. Executed after all other steps, but before the config is persisted.
  """
  @type cmds :: [{String.t(), [String.t()]}]

  @typedoc """
  Whether to persist the choices made into a `.merlin.exs` file in the project root.
  """
  @type persist_config :: boolean()

  @type t :: %__MODULE__{
          editor_config: editor_config(),
          envrc: envrc(),
          docker_compose: docker_compose(),
          circleci: circleci(),
          tool_versions: tool_versions(),
          formatter: formatter(),
          dependencies: dependencies(),
          cmds: cmds(),
          persist_config: persist_config()
        }

  @doc """
  Read the config file at the project root into a `Merlin.Config` struct.
  """
  @spec get :: {:ok, t} | {:error, any()}
  def get, do: get("")

  @doc """
  Read the config file at `path` into a `Merlin.Config` struct.
  """
  @spec get(String.t() | nil) :: {:ok, t} | {:error, :not_found}
  def get(path) do
    case File.read(path) do
      {:ok, raw_config} -> parse_config(raw_config)
      {:error, :enoent} -> {:error, :not_found}
    end
  end

  defp parse_config(raw_config) do
    config = Code.eval_string(raw_config)
    IO.inspect(config)
  end

  @doc """
  Writes `config` to the project root as `.merlin.exs`.
  """
  @spec write(t) :: {:ok, Path.t()} | {:error, any()}
  def write(config) do
    path = ".merlin.exs"
    data = Code.format_string!("#{inspect(config)}")

    case File.write(path, data) do
      :ok -> {:ok, path}
      {:error, _} = error -> error
    end
  end

  @doc """
  Returns a default `Merlin.Config` struct.
  """
  @spec new :: t()
  def new do
    %__MODULE__{
      editor_config: editor_config(),
      envrc: envrc(),
      docker_compose: docker_compose(),
      circleci: circleci(),
      tool_versions: tool_versions(),
      formatter: formatter(),
      dependencies: dependencies(),
      cmds: cmds(),
      persist_config: persist_config()
    }
  end

  @doc """
  Defines the default `:editor_config`.
  """
  @spec editor_config :: editor_config()
  def editor_config do
    ## TODO implement
  end

  @doc """
  Defines the default `:envrc`.
  """
  @spec envrc :: envrc()
  def envrc do
    ## TODO implement
  end

  @doc """
  Defines the default `:docker_compose`.
  """
  @spec docker_compose :: docker_compose()
  def docker_compose do
    ## TODO implement
  end

  @doc """
  Defines the default `:circleci`.
  """
  @spec circleci :: circleci()
  def circleci do
    ## TODO implement
  end

  @doc """
  Defines the default `:tool_versions`.
  """
  @spec tool_versions :: tool_versions()
  def tool_versions do
    [{:elixir, tagged_tool_version(:elixir)}, {:erlang, tagged_tool_version(:erlang)}]
  end

  @doc """
  Defines the default `:formatter`.
  """
  @spec formatter :: formatter()
  def formatter do
    # TODO implement
  end

  @doc """
  Defines the default `:dependencies`.
  """
  @spec dependencies :: dependencies()
  def dependencies do
    [
      {:credo, "~> 0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.0", runtime: false},
      {:faker, "~> 0.0"},
      {:mix_test_watch, "~> 0.0", only: [:dev], runtime: false},
      {:mox, "~> 0.0"},
      {:sentry, "~> 6.0"}
    ]
  end

  @doc """
  Defines the default `:cmds`.
  """
  @spec cmds :: cmds()
  def cmds do
    # TODO implement
  end

  @doc """
  Defines the default `:persist_config`.
  """
  @spec persist_config :: persist_config()
  def persist_config do
    # TODO implement
  end

  @doc """
  Returns the version a given tool should be defaulted to.
  """
  @spec tool_version(atom()) :: String.t()
  def tool_version(:elixir) do
    "1.6.4"
  end

  def tool_version(:erlang) do
    "20.3"
  end

  defp tagged_tool_version(tool), do: {tool, tool_version(tool)}
end
