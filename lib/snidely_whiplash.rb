require "snidely_whiplash/version"

class SnidelyWhiplash
  
  def initialize(path=nil)
    @path = path
  end
  
  def to_s
    "{{#{@path || ''}}}"
  end
  
  def method_missing(method, *args, &block)
    SnidelyWhiplash.new(@path.nil? ? method.to_s : "#{@path}.#{method.to_s}")
  end
  
end
