
namespace :orienteer do
  
  desc "perform a complete mapping of routes"
  task :map, :needs => [:environment, :navigate, :explore]
  
  desc "navigate the named routes"
  task :navigate, :needs => [:environment] do
    puts "Navigating named routes"
    foo = {}
    basenames = ActionController::Routing::Routes.named_routes.routes.keys
    basenames.each {|name| foo[name] = false}
    Dir.glob(File.join(RAILS_ROOT, '/app', '**', '*.rb')).each do |file|
      data = File.read(file)
      basenames.each do |base_name|
        reg =  Regexp.new(base_name.to_s+"_(?=url|path)")
        if reg.match data
          foo[base_name] = true
        end
      end
    end
    unused = foo.reject{|k, v| v == true}
    
    puts "-"*40
    puts "The following named routes are not referenced"
    puts "-"*40
    unused.keys.each{|k| puts k.to_s}
    puts "\n"*2
    puts "-"*40
    puts "#{unused.size} named routes are not referenced"
    puts "-"*40
    
  end
  
  desc "explore the routes"
  task :explore, :needs => [:environment] do
    puts "Mapping routes"
    controllers = ActionController::Routing::Routes.routes.collect {|r| "#{r.defaults[:controller]}_controller".classify}
    
  end
  
  desc "show any controllers referenced in the routes but do not exist"
  task :non_existent, :needs => [:environment] do
    controllers = ActionController::Routing::Routes.routes.collect {|r| "#{r.defaults[:controller]}_controller".classify}
    non_existent = []
    controllers.uniq.each do |c|
      begin
        c.constantize
      rescue
        non_existent << c
      end
    end
    puts "-"*40
    puts "The following controllers are referenced but do not exist."
    puts "-"*40
    non_existent.each{|c| puts c}
    puts "\n"*2
  end

  desc "show all routes for which actions do not exist"
  task :inactionable, :needs => [:environment] do
    missing_actions = []
    ActionController::Routing::Routes.routes.each do |route|
      begin
        unless "#{route.defaults[:controller]}_controller".classify.constantize.instance_methods.include? route.defaults[:action]
          missing_actions << route.defaults
        end
      rescue
      end
    end
    
    puts missing_actions.to_yaml
    puts missing_actions.size
  end
end