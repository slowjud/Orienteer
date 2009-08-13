class Orienteer

  #reset the cached copy of the routes
  def reload
    @routes = ActionController::Routing::Routes.routes
    @named_routes = ActionController::Routing::Routes.named_routes.routes
  end

  #find any named routes which are not called by name
  def unused_named_routes
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
    foo.reject{|k, v| v == true}
  end

  #find controllers which are referenced in the routes but don't exist
  def missing_controllers
    controllers = ActionController::Routing::Routes.routes.collect {|r| "#{r.requirements[:controller]}_controller".classify}
    missing = []
    controllers.uniq.each do |c|
      begin
        c.constantize
      rescue
        missing << c
      end
    end
    missing
  end

  #find controller actions called routes but do not have code
  def missing_actions
    missing = []
    ActionController::Routing::Routes.routes.each do |route|
      begin
        unless "#{route.requirements[:controller]}_controller".classify.constantize.instance_methods.include? route.requirements[:action]
          missing << route.requirements
        end
      rescue
      end
    end
    missing
  end

  #find any routes which don't have view
  def missing_views
    missing = []
    ActionController::Routing::Routes.routes.each do |route|
      
    end
  end
end