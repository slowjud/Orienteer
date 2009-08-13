
namespace :orienteer do
  
  desc "perform a complete mapping of routes"
  task :map, :needs => [:environment, :navigate, :explore]
  
  desc "navigate the named routes"
  task :navigate, :needs => [:environment] do
    puts "Navigating named routes"
    puts "-"*40
    puts "The following named routes are not referenced"
    puts "-"*40
    Orienteer.unused_named_routes.keys.each{|k| puts k.to_s}
    puts "\n"*2
    
  end
  
  desc "explore the routes"
  task :explore, :needs => [:environment] do
    puts "Mapping routes"
    controllers = ActionController::Routing::Routes.routes.collect {|r| "#{r.defaults[:controller]}_controller".classify}
    
  end
  
  desc "show any controllers referenced in the routes but do not exist"
  task :non_existent, :needs => [:environment] do
    puts "-"*40
    puts "The following controllers are referenced but do not exist."
    puts "-"*40
    Orienteer.missing_controllers.each{|c| puts c}
    puts "\n"*2
  end

  desc "show all routes for which actions do not exist"
  task :inactionable, :needs => [:environment] do
    puts "-"*40
    puts "The following actions are referenced but do not exist."
    puts "-"*40
    Orienteer.missing_actions.each{|c| puts "#{c[:controller]} #{c[:action]}"}
    puts "\n"*2
  end
end