require 'yaml'

module Credentializer
  # This module is a tool for getting the credentials each controller requires
  # It abstracts where the credentials come from (e.g. yaml, database, etc.)

  def twitter_credentials
    # Code to retrieve Twitter credentials
    YAML.load(File.open('./twitter_config.yml'))
  end
end #Credentializer
