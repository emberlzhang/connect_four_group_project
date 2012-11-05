require 'yaml'

module Credentializer
  extend self
  # This module is a tool for getting the credentials each controller requires

  def twitter_credentials
    # Code to retrieve Twitter credentials
    YAML.load(File.open('./lib/twitter_config.yml'))
  end
end #Credentializer
