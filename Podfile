# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'Git Repos Viewer' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for Git Repos Viewer
	pod 'LinqToObjectiveC'
	pod 'DateTools'

  target 'Git Repos ViewerTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
		end
	end
end
