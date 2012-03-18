rstat.us is a microblogging site built on top of the [ostatus
protocol](http://status.net/wiki/OStatus).

Helping out with rstat.us
-------------------------

If you'd like to contribute, here are some details:

- The stack: ruby/sinatra/mongodb
- [The code][code]
- [The documentation][docs] (need lots of improvement here!)
- [The Issues list][issues]
- Please fork the project and make a pull request
  - Pull requests will not be merged without tests/documentation
    - We use [minitest][minitest]/[capybara][capy] for tests
    - We use [docco][docco] (rocco) for documentation
    - If you think it doesn't need a test, make your case, I'm just saying.

[code]: http://github.com/hotsh/rstat.us
[docs]: http://hotsh.github.com/rstat.us/
[issues]: http://github.com/hotsh/rstat.us/issues
[minitest]: https://github.com/seattlerb/minitest
[capy]: https://github.com/jnicklas/capybara
[docco]: https://github.com/jashkenas/docco

Source code documentation
-------------------------

We have documentation that explains all of our source code, using rocco.
You can view it [here](http://hotsh.github.com/rstat.us/rstatus.html).


Setting up a dev environment
----------------------------

First off: you will need MongoDB (www.mongodb.org).  They have a [quickstart
guide][mongo-quickstart] for getting it installed and running.

Then do:

    $ git clone https://github.com/$MY_GITHUB_USERNAME/rstat.us.git
    $ cd rstat.us

Copy the config file; if you have actual Twitter API keys, you can add yours,
but this file just needs to exist for the server to work.

    $ cp config/config.yml.sample config/config.yml

Then update your gemset:

    $ gem install bundler && bundle install

And start the server:

    $ rackup

Bam! Visit http://localhost:9292/ in your browser, and you'll be good.

To run the tests you may want to make use of `bundle exec` so you don't get
mixed up with different versions of gems that might or might not work with
the current rstat.us branch.

Run the tests:

    $ bundle exec rake test

[mongo-quickstart]: http://www.mongodb.org/display/DOCS/Quickstart

Compiling CSS and Javascript
----------------------------

We use Coffeescript (.coffee) and Sassy CSS (.scss) for javascript and CSS
development respectively. When running the site locally, these files will
automatically be compiled by the application when requested.

When preparing for deployment, we compress our stylesheets and javascripts, as
well as embedding what images we can. To compile Coffeescript and SCSS,
use the following rake task:

    $ rake assets:compile

Note: This relies on some sort of coffee compiler being installed globally. If
you get "undefined method 'compile' for nil:NilClass", that might be your
problem. On Ubuntu, installing the nodejs package fixes this; for other
systems, check out [nodejs.org][node].

For coffee-script installation, [check the docs][coffee-install].

You may also need the java runtime for asset compression, which is handled by
jammit using yui compressor and closure compiler. Installing a JDK, such as
[OpenJDK][openjdk] should do the trick.

[node]: http://nodejs.org
[coffee-install]: http://jashkenas.github.com/coffee-script/#installation
[openjdk]: http://openjdk.java.net/

Running your own node
---------------------

If you need help with this, then you're not ready to run one.
Here's the deal: we're still finishing up our ostatus implementation,
and until it's 100% compatible, these instructions are kept secret.
Eventually, we plan on making this _super easy_, but until we feel that
it's ready, we're keeping the instructions 'secret.' Sorry!

If you do run your own node anyway, please keep current with upstream
until we hit 1.0, and it should all be smooth sailing!
