
namespace :orienteer do
  
  include 'Orienteer'
  
  desc "perform a complete mapping of routes"
  task :map, :needs => [:environment, :navigate, :explore]
  
  desc "navigate the named routes"
  task :navigate, :needs => [:environment] do
    puts "Navigating named routes"
    puts "-"*40
    puts "The following named routes are not referenced"
    puts "-"*40
    unused_named_routes.keys.each{|k| puts k.to_s}
    puts "\n"*2
    
  end
  
  desc "show any routes which can't be rendered"
  task :explore, :needs => [:environment] do
    puts "-"*40
    puts "The following actions are referenced but do not exist."
    puts "-"*40
    missing_views.each{|c| puts "#{c[:controller]} #{c[:action]}"}
    puts "\n"*2
  end
  
  desc "show any controllers referenced in the routes but do not exist"
  task :non_existent, :needs => [:environment] do
    puts "-"*40
    puts "The following controllers are referenced but do not exist."
    puts "-"*40
    missing_controllers.each{|c| puts c}
    puts "\n"*2
  end

  desc "show all routes for which actions do not exist"
  task :inactionable, :needs => [:environment] do
    puts "-"*40
    puts "The following actions are referenced but do not exist."
    puts "-"*40
    missing_actions.each{|c| puts "#{c[:controller]} #{c[:action]}"}
    puts "\n"*2
  end
end