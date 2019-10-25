module Fastlane
  module Actions
    module SharedValues
      PATCH_CONFIG_CUSTOM_VALUE = :PATCH_CONFIG_CUSTOM_VALUE
    end

    class PatchConfigAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        patchConfigs(params)
      end

      def self.patchConfigs(params)
        options         = params[:options]
        env             = options[:env]
        platform        = options[:platform]

        # Display beautiful text in console
        puts "🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥"
        puts "➡️ PATCHING: #{env.upcase}"
        puts "➡️ PLATFORM: #{platform.upcase}"
        puts "🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥"

        # check if has access to directory, else ask for password
        if options[:currentDir] != nil
          Dir.chdir(options[:currentDir])
        end
        puts Dir.pwd()

        # read the config file
        configs_path    = "env/#{env}/Config.json"
        configs_file    = File.read(configs_path)
        configs         = JSON.parse(configs_file)

        # move the config file in root project for android and ios projects
        File.write("config.json",JSON.pretty_generate(configs))

      end

      def self.available_options
        # Define all options your action supports. 
        [
          FastlaneCore::ConfigItem.new(key: :options, 
                                       description: "Options for PatchConfigAction", # a short description of this parameter
                                       is_string: false,
                                       verify_block: proc do |value|
                                          UI.user_error!("options for VMA Patch given, pass using `env:qa/stag/prod`") unless (value and not value.empty?)
                                       end
                                       ),
        ]
      end

    end
  end
end
