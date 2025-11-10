# How to develop

## Setup whole environment

If only changing Ruby code, this step is unnecessary

1. Install [Nix](https://nixos.org/) package manager and enable [Flakes](https://wiki.nixos.org/wiki/Flakes)\
   Or use Nix installed containers. For example, look at [this repo](https://github.com/kachick/containers)
2. Run dev shell as one of the following
   - with [direnv](https://github.com/direnv/direnv): `direnv allow`
   - nix only: `nix develop`
3. You can use development tools

```console
> nix develop
(prepared bash)
> dprint --version
...
```

## How to release

1. Push tags as `v0.4.2`
2. Wait for complete the GitHub Actions
3. Run following commands
   ```bash
   cd "$(mktemp --directory)"
   curl -L https://github.com/kachick/irb-power_assert/releases/latest/download/irb-power_assert.gem > irb-power_assert.gem
   sha256sum irb-power_assert.gem # Make sure it has same hash as GitHub Action printed

   gem push irb-power_assert.gem --otp [CHECK_MFTA_TOOL]
   ```
4. Check https://rubygems.org/gems/irb-power_assert
