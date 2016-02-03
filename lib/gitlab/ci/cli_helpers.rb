require 'yaml'
require 'json'
require 'gitlab/cli_helpers'

module Gitlab
  module CI
    class CLI
      # Defines methods related to CLI output and formatting.
      module Helpers
        include Gitlab::CLI::Helpers
        extend Gitlab::CI::CLI::Helpers

        # Returns actions available to CLI & Shell
        #
        # @return [Array]
        def actions
          @actions ||= Gitlab::CI.actions
        end

        # Returns Gitlab::Client instance
        #
        # @return [Gitlab::Client]
        def client
          @client ||= Gitlab::CI::Client.new(endpoint: (Gitlab.endpoint || ''))
        end

        # Confirms command is valid.
        #
        # @return [Boolean]
        def valid_command?(cmd)
          command = cmd.is_a?(Symbol) ? cmd : cmd.to_sym
          Gitlab::CI.actions.include?(command)
        end

        # Gets defined help for a specific command/action.
        #
        # @return [String]
        def help(cmd=nil, &block)
          if cmd.nil? || Gitlab::CI::Help.help_map.key?(cmd)
            Gitlab::CI::Help.actions_table(cmd)
          else
            Gitlab::CI::Help.get_help(cmd, &block)
          end
        end

      end
    end
  end

end
