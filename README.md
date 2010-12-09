# screenie

You like screen, I like screen. Make getting those big multi-command line-running projects
even easier to get started up with `screenie`.

## How?

Make a `.screenie` file in your app and write:

<pre>
session do
  screen "bundle exec autotest", :title => "autotest"
  screen "rails c", :title => "dev console"
  screen "rails s", :title => "dev server"
  screen "less +F -fr log/test.log", :title => "test log tail"
  screen! :title => "bash"
end
</pre>

Then run:

    screenie

_~~whoa~~_

### More?

<pre>
session :backend do
  screen "bundle exec autotest", :title => "autotest"
  screen "less +F -fr log/test.log", :title => "test log tail"
  screen! :title => "bash"
end

session :frontend do
  screen "bundle exec autotest", :title => "autotest"
  screen "rails c", :title => "console"
  screen "rails s", :title => "server"
  screen "rake jasmine", :title => "jasmine"
  screen! :title => "bash"
end
</pre>

Then run:

    screenie backend

or even:

    screenie frontend

## Defaults?

Like magic `screenie` bits anywhere? `~/.screenie` is what you want! Same syntax!

## Ruby? DRY?

Just like `Gemfile`, `*.gemspec`, and other modern Ruby things, `.screenie` is Ruby code. Like
DRYing things? You can do it!

<pre>
class Screenie::DSL::Session
  def whoa(&block)
    screen :title => "first"
    instance_eval(&block)
    screen :title => "last"
  end
end

session :first do
  whoa do
    screen "bundle exec autotest", :title => 'autotest'
  end
end

session :second do
  whoa do
    screen %{echo "cats"}
  end
end
</pre>

## What's left?

A _bunch_. I write what I need. Feel like adding fun things and/or tests? Fork, hack, pull request. You know the drill.
