class Orienteer

  #find any named routes which are not called by name
  def self.unused_named_routes
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
  def self.missing_controllers
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
  def self.missing_actions
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
  def self.missing_views
    missing = []
    missing_actions.each do |action|
      if Dir.glob(File.join(ActionController::Base.view_paths, action[:controller], action[:action]+".*")).empty?
        missing << action
      end
    end
    missing
  end

  def self.unused_actions
    unused = []
    ActionController::Routing::Routes.routes.collect{|r| r.requirements[:controller]}.uniq.sort.each do |controller|
      begin
        (controller+'_controller').classify.constantize.action_methods.each do |action|
          unless ActionController::Routing::Routes.routes.find{|r| r.requirements[:controller] == controller && r.requirements[:action] == action}
            unused << [controller, action]
          end
        end
      rescue
      end
    end
    unused
  end
end
