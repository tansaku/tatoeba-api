class ApplicationController < ActionController::Base
  #protect_from_forgery :except => [:index]

  protected
  def render_jsonp(json, options={})
    callback, variable = params[:callback], params[:variable]
    response = begin
      if callback && variable
        "var #{variable} = #{json};\n#{callback}(#{variable});"
      elsif variable
        "var #{variable} = #{json};"
      elsif callback
        "#{callback}(#{json});"
      else
        json
      end
    end
    render({:content_type => 'text/plain', :text => response}.merge(options))
  end
end
