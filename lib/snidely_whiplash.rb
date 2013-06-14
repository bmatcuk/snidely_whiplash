require "snidely_whiplash/version"

class SnidelyWhiplash
  
  def initialize(path=nil)
    @path = path
  end
  
  def to_s
    "{{#{@path || ''}}}"
  end
  
  def method_missing(method_sym, *args, &block)
    SnidelyWhiplash.new(@path.nil? ? method_sym.to_s : "#{@path}.#{method_sym.to_s}")
  end
  
  def respond_to?(method_sym, include_private=false)
    Object.new.respond_to? method_sym, include_private
  end
  
end
