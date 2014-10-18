require "snidely_whiplash/version"

class SnidelyWhiplash
  
  # Initialize SnidelyWhiplash
  #
  # options:
  #   path
  #     Specifies a parent path for the mustache output. For example, if you
  #     set path to "user", and then used things like "model.first_name" in
  #     your view, the resulting mustache output would be "{{user.first_name}}".
  #     You may have dots in this path (ex: "post.user"). The default is nil,
  #     which means that there is no parent path.
  #   html_escape
  #     If true (the default), the mustache output will use two curly braces,
  #     which signifies that the output should be html escaped. If you set this
  #     to false, the mustache output will use three curly braces, signifying
  #     that the output should not be altered. Since this affects all mustache
  #     outputs, you probably don't want to use this! Rather, you should use
  #     something like "model.item.html_safe" in cases where you want to
  #     disable html escaping.
  #   values
  #     Sometimes you want certain values to be interpreted server-side
  #     instead of converted to client-side mustache code. You can use this
  #     parameter to specify values that should be used for certain methods
  #     server-side. The keys in this hash MUST be strings and they correspond
  #     to the paths that SnidelyWhiplash would have output otherwise. So, for
  #     example, if you wanted to specify a value for "model.user.name", you
  #     could pass the following hash in as "values":
  #       {'user.name' => 'Dudley Do-Right'}
  def initialize(path=nil, html_escape=true, values={})
    @path = path
    @html_escape = html_escape
    @values = values
  end
  
  def to_s
    @html_escape ? "{{#{@path || ''}}}" : "{{{#{@path || ''}}}}"
  end
  
  def method_missing(method_sym, *args, &block)
    if method_sym == :html_safe
      SnidelyWhiplash.new(@path, false, @values)
    else
      newpath = @path.nil? ? method_sym.to_s : "#{@path}.#{method_sym.to_s}"
      return @values[newpath] if @values.has_key? newpath
      SnidelyWhiplash.new(newpath, @html_escape, @values)
    end
  end
  
  def respond_to?(method_sym, include_private=false)
    Object.new.respond_to? method_sym, include_private
  end
  
end
