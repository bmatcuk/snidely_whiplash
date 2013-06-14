# SnidelyWhiplash

Let's say you have a partial view for displaying one of your models (written in your favorite templating language... [haml](http://haml.info/) perhaps?). But, hey, this 2013! Wouldn't it be nice if you could do some fancy, AJAXy thing to load new instances of your model and automatically format them the same way?

So you could use some fancypants javascript to make that happen, but that's ugly. So you Google around and find [mustache](http://mustache.github.io/). Mustache takes a string with some HTML and `{{variables}}` and replaces all of those variables with data from a javascript object. Ok cool.

But what are you going to do? Rewrite your partial view in some large boring javascript string so you can pass it to mustache? Yuck. If only you can haz your mustache template inline with your HTML. That would look prettier. Oh, wait! [You can haz that!](http://icanhazjs.com/)

Ok, but that doesn't solve the fact that you have to have two versions of your partial view: one for ruby, and one for ICanHaz/Mustache. That's not very "dry". Lame.

It's a good thing you have a friend that understands mustaches: good ol' Snidely Whiplash! He'll teach you proper grooming technique... right after he's done tying Nell to the railroad tracks!

SnidelyWhiplash is a brain-dead simple mock class that causes all of your `model.property` lines in your partial view to output as `{{model.property}}`. The end result is that you get a block of HTML which you can shove in a `<script type="text/html">` for use with ICanHaz/Mustache. SnidelyWhiplash understands any simple outputs in your template (like `<%= model.property %>`), but doesn't understand anything more complicated than that. This is really just a simple solution to converting simple partial views to mustache templates so they can be used both server-side, and client-side.

## Installation

Add this line to your application's Gemfile:

    gem 'snidely_whiplash'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install snidely_whiplash

## Usage

Let's say you have a partial view that looks like this:

```erb
<div class="user">
  <h2><%= user.full_name %></h2>
  <dl>
    <dt>Address:</dt>
    <dd><%= user.address %></dd>
    <dt>Email:</dt>
    <dd><%= user.email %></dd>
  </dl>
</div>
```

... or maybe in haml:

```haml
.user
  %h2= user.full_name
  %dl
    %dt Address:
    %dd= user.address
    %dt Email:
    %dd= user.email
```

And perhaps you render it by running: `render partial: 'user', locals: {user: @user}`.

You could create an ICanHaz/Mustache template by adding the following, in ERB:

```erb
<script id="user_template" type="text/html">
  <%= render partial: 'user', locals: {user: SnidelyWhiplash.new} %>
</script>
```

... or in haml:

```haml
%script#user_template{type: 'text/html'}
  = render partial: 'user', locals: {user: SnidelyWhiplash.new}
```

Either way would cause the following output:

```html
<script id="user_template" type="text/html">
  <div class="user">
    <h2>{{full_name}}</h2>
    <dl>
      <dt>Address:</dt>
      <dd>{{address}}</dd>
      <dt>Email:</dt>
      <dd>{{email}}</dd>
    </dl>
  </div>
</script>
```

... which you could then use in javascript with something like:

```javascript
data = {
  full_name: 'Nell Fenwick',
  address: 'Canada',
  email: 'nell@example.org'
};

var user = ich.user_template(data);
```

The `SnidelyWhiplash` constructor can take one argument which can be used to specify the parent path for properties. For example, if you had used `SnidelyWhiplash.new('user')` in the examples above, the mustache outputs would have all been in the form `user.full_name`, `user.address`, and `user.email`. Your path can contain dots for those cases when your data is very deeply nested (for example: `SnidelyWhiplash.new('result.user')` would cause output like `{{result.user.full_name}}`, etc).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
