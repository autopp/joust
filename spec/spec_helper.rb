# Require this file for unit tests
ENV['HANAMI_ENV'] ||= 'test'

require_relative '../config/environment'
Hanami.boot
Hanami::Utils.require!("#{__dir__}/support")

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# The `.rspec` file also contains a few flags that are not defaults but that
# users commonly want.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = 'spec/examples.txt'

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax
  #   - http://teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://myronmars.to/n/dev-blog/2014/05/notable-changes-in-rspec-3#new__config_option_to_disable_rspeccore_monkey_patching
  # config.disable_monkey_patching!

  # This setting enables warnings. It's recommended, but in many cases may
  # be too noisy due to issues in dependencies.
  config.warnings = false
end

shared_context 'with 7 players', players: 7 do
  let(:player1) do
    Player.new(
      name: 'palyer1',
      scores: [
        Score.new(
          round_id: 1, table_number: 1, player_count: 4,
          vp_gained: 30, rank: 1, same_ranks: 1
        ),
        Score.new( # TODO: FIX
          round_id: 2, table_number: 1, player_count: 4,
          vp_gained: 30, rank: 1, same_ranks: 1
        )
      ]
    )
  end

  let(:player2) do
    Player.new(
      name: 'palyer2',
      scores: [
        Score.new(
          round_id: 1, table_number: 1, player_count: 4,
          vp_gained: 24, rank: 2, same_ranks: 1
        ),
        Score.new( # TODO: FIX
          round_id: 2, table_number: 1, player_count: 4,
          vp_gained: 30, rank: 1, same_ranks: 1
        )
      ]
    )
  end

  let(:player3) do
    Player.new(
      name: 'palyer3',
      scores: [
        Score.new(
          round_id: 1, table_number: 1, player_count: 4,
          vp_gained: 18, rank: 3, same_ranks: 1
        ),
        Score.new( # TODO: FIX
          round_id: 2, table_number: 1, player_count: 4,
          vp_gained: 30, rank: 1, same_ranks: 1
        )
      ]
    )
  end

  let(:player4) do
    Player.new(
      name: 'palyer4',
      scores: [
        Score.new(
          round_id: 1, table_number: 1, player_count: 4,
          vp_gained: 12, rank: 4, same_ranks: 1
        ),
        Score.new( # TODO: FIX
          round_id: 2, table_number: 1, player_count: 4,
          vp_gained: 30, rank: 1, same_ranks: 1
        )
      ]
    )
  end

  let(:player5) do
    Player.new(
      name: 'palyer5',
      scores: [
        Score.new(
          round_id: 1, table_number: 2, player_count: 3,
          vp_gained: 32, rank: 1, same_ranks: 1
        ),
        Score.new( # TODO: FIX
          round_id: 2, table_number: 1, player_count: 4,
          vp_gained: 30, rank: 1, same_ranks: 1
        )
      ]
    )
  end

  let(:player6) do
    Player.new(
      name: 'palyer6',
      scores: [
        Score.new(
          round_id: 1, table_number: 2, player_count: 3,
          vp_gained: 24, rank: 2, same_ranks: 1
        ),
        Score.new( # TODO: FIX
          round_id: 2, table_number: 1, player_count: 4,
          vp_gained: 30, rank: 1, same_ranks: 1
        )
      ]
    )
  end

  let(:player7) do
    Player.new(
      name: 'palyer7',
      scores: [
        Score.new(
          round_id: 1, table_number: 2, player_count: 3,
          vp_gained: 16, rank: 3, same_ranks: 1
        ),
        Score.new( # TODO: FIX
          round_id: 2, table_number: 1, player_count: 4,
          vp_gained: 30, rank: 1, same_ranks: 1
        )
      ]
    )
  end

  let(:players) { [player1, player2, player3, player4, player5, player6, player7] }
end
