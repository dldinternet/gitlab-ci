module Gitlab
  module CI
    # Wrapper for the Gitlab REST API.
    class Client < API
      Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }

			include Gitlab::CI::Client::Builds
			include Gitlab::CI::Client::Commits
      include Gitlab::CI::Client::Projects
			include Gitlab::CI::Client::Runners
		end
  end
end
