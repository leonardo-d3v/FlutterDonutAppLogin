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
        puts "🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥"
        puts "➡️ PATCHING: #{env.upcase}"
        puts "➡️ PLATFORM: #{platform.upcase}"
        puts "🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥"

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
