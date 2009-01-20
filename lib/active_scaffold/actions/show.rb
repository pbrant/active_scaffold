module ActiveScaffold::Actions
  module Show
    include ActiveScaffold::CompositeKeys

    def self.included(base)
      base.before_filter :show_authorized?, :only => :show
    end

    def show
      do_show

      successful?
      respond_to do |type|
        type.html { render :action => 'show', :layout => true }
        type.js { render :partial => 'show', :layout => false }
        type.xml { render :xml => active_scaffold_config.show.columns.res_to_xml(response_object), :content_type => Mime::XML, :status => response_status }
        type.json { render :text => active_scaffold_config.show.columns.res_to_json(response_object), :content_type => Mime::JSON, :status => response_status }
        type.yaml { render :text => active_scaffold_config.show.columns.res_to_yaml(response_object), :content_type => Mime::YAML, :status => response_status }
      end
    end

    protected

    # A simple method to retrieve and prepare a record for showing.
    # May be overridden to customize show routine
    def do_show
      @record = find_if_allowed(unescape_id(params[:id]), :read)
    end

    # The default security delegates to ActiveRecordPermissions.
    # You may override the method to customize.
    def show_authorized?
      authorized_for?(:action => :read)
    end
  end
end
