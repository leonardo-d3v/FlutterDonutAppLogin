module Fastlane
  module Actions
    module SharedValues
      PATCH_CONFIG_CUSTOM_VALUE = :PATCH_CONFIG_CUSTOM_VALUE
    end

    class PatchConfigAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        patchConfigs(params)
        # copy assets like images/google-services files to appropriate folders
        copyAssets(params)
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

        #android config for gradle build settings in app/build.gradle
        if platform == 'android'
           android_config = {
             "versionCode" => configs[platform]["versionCode"],
             "versionName" => configs[platform]["versionName"],
             "applicationId" => configs[platform]["applicationId"],
             "appName" => configs["common"]["appName"]
           }
           puts android_config
           File.write("android_config.json",JSON.pretty_generate(android_config))
        end

        #config.xconfig for xcode build settings
        if platform == 'ios'
          xconfig         = ""
          xconfig         += "VERSION = #{configs[platform]["version"]}\n"
          xconfig         += "BUILDNUMBER = #{configs[platform]["buildNumber"]}\n"
          xconfig         += "APPID = #{configs[platform]["appId"]}\n"
          xconfig         += "APPNAME = #{configs["common"]["appName"]}\n"
          puts xconfig
          File.write("config.xcconfig",xconfig)
        end

        puts "✅ PATCHING COMPLETED ✅"
       
      end

      #region copy assets
      def self.copyAssets(params)
        options         = params[:options]
        env             = options[:env]
        platform        = options[:platform]
       
        configs_path    = "env/#{env}"

          #============================================#
         #==FILES TO BE COPIED MUST BE PLACED BELOW ==#
        #============================================#
        #ios specific asset
        if platform == 'ios'
          puts "➡️ COPPYING: #{platform.upcase} ASSETS"
          # copying google services configs
          FileUtils.cp_r("#{configs_path}/GoogleService-Info.plist","ios/GoogleService-Info.plist")
    
          #android specific asset
        elsif platform == 'android'
          puts "➡️ COPPYING: #{platform.upcase} ASSETS"
          # google-services.json saved in endpoint since it contains all targets
          FileUtils.cp_r("#{configs_path}/google-services.json","android/app/google-services.json")    
        end

        puts "✅ COPYING ASSETS COMPLETED ✅"

      end
      #end region copy assets

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
