class Gitlab::CI::Client
  # Defines methods related to repository commits.
  # @see https://github.com/gitlabhq/gitlabhq/blob/master/doc/api/commits.md
  module Commits
    # Get list of commits per project
    #
    # @example
    #   Gitlab.commits('viking')
    #   Gitlab.repo_commits('gitlab', :ref_name => 'api')
    #
    # @param  [Integer, String] project_id (required) - The ID of a project
    # @param  [String] project_token (required) - Project token
    # @param  [Hash] options A customizable set of options.
    # @option options [Integer] :page The page number.
    # @option options [Integer] :per_page The number of results per page.
    # @return [Array<Gitlab::ObjectifiedHash>]
    def commits(project, token)
      get("/commits", body: { project_id: project, project_token: token })
    end

    # Inform GitLab CI about new commit you want it to build.
    #
    # @example
    #   Gitlab.commit(14, '6104942438c14ec7bd21c6cd5bd995272b3faff6', hash)
    #   Gitlab.repo_commit(3, 'ed899a2f4b50b4370feeea94676502b42383c746', hash)
    #
    # @param  [Integer] project_id (required) - The ID of a project
    # @param  [Integer] project_token (requires) - Project token
    # @param  [Hash] data The commit data.
    # Parameters:
    #   id (required) - The ID of a project
    #   sha (required) - The commit hash
    #   note (required) - Text of comment
    #   path (optional) - The file path
    #   line (optional) - The line number
    #   line_type (optional) - The type of line (new or old)
    # @return [Gitlab::ObjectifiedHash]
    def commit(project, token, data)
      post("/commits", body: data.merge({ project_id: project, project_token: token }))
    end
    alias_method :create_commit, :commit

  end
end
