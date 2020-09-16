require 'fastlane/action'
require_relative '../helper/android_update_package_identifier_helper'

module Fastlane
  module Actions
    class AndroidUpdatePackageIdentifierAction < Action
      def self.run(params)
        path = params[:gradleFilePath]
        identifier = params[:newIdentifier]

        File.open(path,"r+") do |file|
          text = File.read(file)
          UI.message("Changing build config at #{path} to have applicationId of #{identifier}")
          config_contents = text[/defaultConfig (\{(?:\{??[^\{]*?\}))/, 1]
          new_config_contents = config_contents.gsub(/(?<=applicationId \").*?(?=\")/, identifier)
          new_contents = text.gsub(config_contents, new_config_contents)
          file.puts new_contents
        end
      end

      def self.description
        "Changes the applicationId inside of your build.gradle file. Does not change the AndroidManifest"
      end

      def self.authors
        ["Jonathan Nogueira"]
      end

      def self.details
        # Optional:
        "This Fastlane plugin will change the applicationId to whatever you want inside your app's build.gradle file. This does not change the AndroidManifest, if you'd like to do that you need to make sure the code you have in your application matches up with what's built through the manifest."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :gradleFilePath,
                                  env_name: "ANDROID_UPDATE_PACKAGE_IDENTIFIER_GRADLE_FILE_PATH",
                               description: "Path to the gradle file you want to edit",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :newIdentifier,
                                  env_name: "ANDROID_UPDATE_PACKAGE_IDENTIFIER_NEW_IDENTIFIER",
                               description: "The new app identifier you want to set the package to",
                                  optional: false,
                                      type: String),
        ]
      end

      def self.is_supported?(platform)
        [:android].include?(platform)
      end
    end
  end
end
