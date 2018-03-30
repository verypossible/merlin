# Merlin

[Docs](https://hexdocs.pm/merlin](https://hexdocs.pm/merlin)

A wise alchemist to guide your project's setup.

## Installation

```elixir
def deps do
  [
    {:merlin, "~> 0.1.0"}
  ]
end
```

## Best practices

Brief summaries outline best practices regarding general topics that typically come up in a project.

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
    - rollbax

## Generators

- CircleCI config
