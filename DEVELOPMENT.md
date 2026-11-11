# Development

## Dependency Architecture

This repository uses three files to manage and test dependencies:

- `irb-power_assert.gemspec`:
  Sets the minimum Ruby version (`required_ruby_version`) and dependency ranges for users of this gem.
- `Gemfile` / `Gemfile.lock`:
  Uses the newest dependencies. CI tests with this lockfile to check compatibility with the newest releases.
- `gemfiles/oldest/Gemfile`:
  Pins dependencies to the oldest supported versions allowed by the gemspec. CI tests with this file to check that older supported versions still work.

### RuboCop TargetRubyVersion

`.rubocop.yml` sets `AllCops.TargetRubyVersion`. This version must match `gem.required_ruby_version` in `irb-power_assert.gemspec` (checked by RuboCop's `Gemspec/RequiredRubyVersion` cop).

## How to release

1. Push a tag like `v0.4.2`
2. Wait for GitHub Actions to finish
3. Run the following commands:
   ```bash
   cd "$(mktemp --directory)"
   curl -L https://github.com/kachick/irb-power_assert/releases/latest/download/irb-power_assert.gem > irb-power_assert.gem
   sha256sum irb-power_assert.gem # Make sure it has same hash as GitHub Action printed

   gem push irb-power_assert.gem --otp [CHECK_MFTA_TOOL]
   ```
4. Check https://rubygems.org/gems/irb-power_assert
