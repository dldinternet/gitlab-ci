class Gitlab::CI::Client
  # Defines methods related to repositories.
  # @see https://github.com/gitlabhq/gitlabhq/blob/master/doc/api/repositories.md
  module Runners
    # Used to get information about all runners registered on the GitLab CI instance.
    #
    # @example
    #   Gitlab::CI.runners
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [Integer] :page The page number.
    # @option options [Integer] :per_page The number of results per page.
    # @return [Array<Gitlab::ObjectifiedHash>]
    def runners(options={})
      get("/runners", query: options)
    end

    # Used to make GitLab CI aware of available runners.
    #
    # @example
    #   Gitlab::CI.register_runner
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [String] token (required) - The registration token. It is 2 types of token you can pass here.
    #   1. Shared runner registration token
    #   2. Project specific registration token
    # @return [Array<Gitlab::ObjectifiedHash>]
    def register_runner(token)
      post("/runners/register", body: { token: token })
    end

    # Used to remove runners.
    #
    # @example
    #   Gitlab::CI.delete_runner
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [String] token (required) - The runner token.
    # @return [Array<Gitlab::ObjectifiedHash>]
    def delete_runner(token)
      delete("/runners/delete", body: { token: token })
    end

  end
end
