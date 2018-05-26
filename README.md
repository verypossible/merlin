# Merlin

[Docs](https://hexdocs.pm/merlin)

A wise alchemist to guide your project's setup.

## Installation

Add Merlin to your project:

```elixir
{:merlin, "~> 0.0"}
```

Umbrella projects need only add Merlin to the top level `mix.exs`.

Don't forget to fetch the dependency:

```
mix deps.get
```

## Usage

Ensure your branch is clean so Merlin changes can be committed on their own and
then ask for guidance:

```
mix merlin
```

Merlin will run through a variety of steps bootstrapping your project. If there
is no `.merlin.exs` file in the project root then Merlin will prompt the user
for confirmation before taking any action.

### Steps

* Create `.editorconfig`
* Create `.envrc`
* Create `docker-compose.yml`
* Create `.circleci/config.yml`
* Create `.tool-versions`
* Create `.formatter.exs`
* Add dependencies: `:credo`, `:dialyxir`, `:faker`, `:mox`, `:mix_test_watch`,
  `:sentry`
* Add mix aliases
  * `"ecto.setup": mix ecto.create && mix ecto.migrate`
* Execute shell commands
  * `docker-compose start -d`
  * `mix ecto.setup`
* Create `.merlin.exs`

## Best practices

Brief summaries outline best practices regarding general topics that typically
come up in a project.

- CI/CD
  - prod clean and compile
  - warnings as errors
  - test
  - format
  - dialyxir
- Testing
  - TDD
- Error reporting / Logging
  - Just do it
  - Don't supress non-trivial errors: let them fail or log them
- Authentication
- Mocking

## Dependecies

Working list of things we want to handle:

- Inform / require dependencies (some are required others are suggestions)
  - Static analysis
    - credo
    - dialyxir
  - Testing
    - mix_test_watch
    - mox
    - faker
    - ex_machina
  - Authentication
    - oauth2
    - ueberauth
  - Error reporting / Logging
    - sentry
