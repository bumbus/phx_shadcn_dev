# PhxShadcn Dev

Showcase app and development workbench for [PhxShadcn](https://github.com/bumbus/phx_shadcn) — a Phoenix LiveView component library mirroring shadcn/ui.

Includes interactive demos for all 39 components, a PhoenixStorybook integration, and theme customization (color presets, radius, dark/light mode).

## Development Setup

This project requires both repos to be cloned side-by-side:

```
your-workspace/
  phx_shadcn/        # the library (hex package)
  phx_shadcn_dev/    # this repo (showcase app)
```

### Steps

```bash
# Clone both repos into the same directory
git clone https://github.com/bumbus/phx_shadcn.git
git clone https://github.com/bumbus/phx_shadcn_dev.git

# Setup the dev app
cd phx_shadcn_dev
mix setup

# Start the server
mix phx.server
```

Visit [localhost:4000](http://localhost:4000) for the home page, [localhost:4000/showcase](http://localhost:4000/showcase) for component demos, and [localhost:4000/storybook](http://localhost:4000/storybook) for the storybook.

### How the dependency works

In development, `phx_shadcn` is referenced as a path dependency (`path: "../phx_shadcn"`). Changes to the library are picked up immediately — no need to re-fetch deps.

For deployment (e.g. Fly.io), set `PHX_SHADCN_FROM_GIT=1` to switch to the git dependency automatically:

```bash
PHX_SHADCN_FROM_GIT=1 mix deps.get
```

## Deployment

To deploy to Fly.io:

1. Set the env var `PHX_SHADCN_FROM_GIT=1` in your Fly config so the build fetches from GitHub instead of the local path
2. Follow the standard [Phoenix deployment guide](https://hexdocs.pm/phoenix/fly.html)

## License

MIT
