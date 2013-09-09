require "snidely_whiplash/version"

class SnidelyWhiplash
  
  def initialize(path=nil, html_escape=true)
    @path = path
    @html_escape = html_escape
  end
  
  def to_s
    @html_escape ? "{{#{@path || ''}}}" : "{{{#{@path || ''}}}}"
  end
  
  def method_missing(method_sym, *args, &block)
    if method_sym == :html_safe
      SnidelyWhiplash.new(@path, false)
    else
      SnidelyWhiplash.new(@path.nil? ? method_sym.to_s : "#{@path}.#{method_sym.to_s}", @html_escape)
    end
  end
  
  def respond_to?(method_sym, include_private=false)
    Object.new.respond_to? method_sym, include_private
  end
  
end
