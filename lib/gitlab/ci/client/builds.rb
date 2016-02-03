class Gitlab::CI::Client
  # Defines methods related to builds.
  # @see https://github.com/gitlabhq/gitlabhq/blob/master/doc/api/builds.md
  module Builds
    # Runs oldest pending build by runner
    #
    # @example
    #   Gitlab.register_build('7a14d63e4b1af83171f4eb3d4a5246')
    #
    # @param  [String] token (required) - The unique token of runner
    # @return [Array<Gitlab::ObjectifiedHash>]
    def register_build(token)
      post("/builds/register", body: { token: token })
    end

    # Update details of an existing build
    #
    # @example
    #   Gitlab.update_build(5)
    #
    # @param  [Integer,String] id (required) - The ID of a project
    # @param  [String] state (optional) - The state of a build
    # @param  [String] trace (optional) - The trace of a build
    # @return <Gitlab::ObjectifiedHash]
    def update_build(id, state=nil, trace=nil)
      if state or trace
        put("/builds/#{id}", body: { state: state, trace: trace })
			else
				"{}"
      end
    end

  end
end
