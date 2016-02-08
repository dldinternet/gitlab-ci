class Gitlab::CI::Client
  # Defines methods related to projects.
  # @see https://github.com/gitlabhq/gitlabhq/blob/master/doc/api/projects.md
  module Projects
    # Lists all projects that the authenticated user has access to.
    #
    # @example
    #   Gitlab::CI.projects
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [Integer] :page The page number.
    # @option options [Integer] :per_page The number of results per page.
    # @option options [String] :scope Scope of projects. 'owned' for list of projects owned by the authenticated user, 'all' to get all projects (admin only)
    # @return [Array<Gitlab::ObjectifiedHash>]
    def projects(options={})
      if options[:scope]
        get("/projects/#{options[:scope]}", query: options)
      else
        get("/projects", query: options)
      end
    end

    # Returns information about a single project for which the user is authorized.
    #
    # @example
    #   Gitlab::CI.project(3)
    #   Gitlab::CI.project('gitlab')
    #
    # @param  [Integer, String] id The ID of the GitLab CI project
    # @return [Gitlab::ObjectifiedHash]
    def project(id)
      get("/projects/#{id}")
    end

    # Creates a GitLab CI project using GitLab project details.
    #
    # @example
    #   Gitlab::CI.create_project('gitlab')
    #   Gitlab::CI.create_project('viking', :description => 'Awesome project')
    #   Gitlab::CI.create_project('Red', :wall_enabled => false)
    #
    # @param  [String] name (required) - The name of the project
    # @param  [String] gitlab_id (required) - The ID of the project on the GitLab instance
    # @param  [String] path (required) - The gitlab project path
    # @param  [String] ssh_url_to_repo (required) - The gitlab SSH url to the repo
    # @param  [String] default_ref (optional) - The branch to run on (default to master)
    # @return [Gitlab::ObjectifiedHash] Information about created project.
    def create_project(name, gitlab_id, path, ssh_url_to_repo, default_ref='master')
      post('/projects', body: { name: name, gitlab_id: gitlab_id, path: path, ssh_url_to_repo: ssh_url_to_repo, default_ref: default_ref })
    end

    # Updates a GitLab CI project using GitLab project details that the authenticated user has access to.
    #
    # @example
    #   Gitlab::CI.edit_project(4, "name", "branch")
    #
    # @param  [String] name - The name of the project
    # @param  [String] default_ref - The branch to run on (default to master)
    # @return [Gitlab::ObjectifiedHash] Information about deleted project.
    def edit_project(id, name, ref='master')
      put("/projects/#{id}", body: { name: name, gitlab_id: id, default_ref: ref })
    end

    # Removes a GitLab CI project that the authenticated user has access to.
    #
    # @example
    #   Gitlab::CI.delete_project(4)
    #
    # @param  [Integer, String] id (required) - The ID of the GitLab CI project
    # @return [Gitlab::ObjectifiedHash] Information about deleted project.
    def delete_project(id)
      delete("/projects/#{id}")
    end

    # Links a runner to a project so that it can make builds (only via authorized user).
    #
    # @example
    #   Gitlab::CI.link_project_to_runner(4,5)
    #
    # @param  [Integer, String] id (required) - The ID of the GitLab CI project
    # @param  [Integer, String] runner_id (required) - The ID of the GitLab CI runner
    # @return [Gitlab::ObjectifiedHash] Information about deleted project.
    def link_project_to_runner(id,runner)
      post("/projects/#{id}/runners/#{runner}", body: { id: id, runner_id: runner })
    end

    # Removes a runner from a project so that it can not make builds (only via authorized user).
    #
    # @example
    #   Gitlab::CI.remove_project_from_runner(4,5)
    #
    # @param  [Integer, String] id (required) - The ID of the GitLab CI project
    # @param  [Integer, String] runner_id (required) - The ID of the GitLab CI runner
    # @return [Gitlab::ObjectifiedHash] Information about deleted project.
    def remove_project_from_runner(id,runner)
      delete("/projects/#{id}/runners/#{runner}")
    end
  end
end
