require 'gitlab/ci/version'
require 'gitlab'
require 'terminal-table/import'
require 'gitlab/configuration'
require 'gitlab/ci/client'

module Gitlab
	module CI
		extend Configuration

		# Alias for Gitlab::Client.new
		#
		# @return [Gitlab::Client]
		def self.client(options={})
			Gitlab::CI::Client.new(options)
		end

		# Delegate to Gitlab::Client
		def self.method_missing(method, *args, &block)
			return super unless client.respond_to?(method)
			client.send(method, *args, &block)
		end

		# Delegate to Gitlab::Client
		def self.respond_to?(method)
			client.respond_to?(method) || super
		end

		# Delegate to HTTParty.http_proxy
		def self.http_proxy(address=nil, port=nil, username=nil, password=nil)
			Gitlab::Request.http_proxy(address, port, username, password)
		end

		# Returns an unsorted array of available client methods.
		#
		# @return [Array<Symbol>]
		def self.actions
			hidden = /endpoint|private_token|auth_token|user_agent|sudo|get|post|put|\Adelete\z|validate|set_request_defaults|httparty/
			(Gitlab::CI::Client.instance_methods - Object.methods).reject { |e| e[hidden] }
		end
	end
end
