## Test smartfox instance

Boots a minimal SmartFoxServer instance, just enough to run the scripts in
this directory: a single `examples` zone with no login/database backing, and
a JRuby extension that answers the `KeepAlive` request/response used by
`keep_alive.rb` and `any.rb`.

Run

```shell
cd smartfox/

bundle install

bundle exec smartfox install instance/

# Download used JRuby
mkdir -p template/extensions/__lib__
curl -Lo template/extensions/__lib__/jruby-complete-10.0.6.0.jar \
  https://repo1.maven.org/maven2/org/jruby/jruby-complete/10.0.6.0/jruby-complete-10.0.6.0.jar

# Configure SmartFox server based on templates directory overwriting any conflicts
yes | bundle exec smartfox configure instance/ template/

# Start the SmartFox server
bundle exec smartfox start instance/
```

Then, from `examples/`, run an example against the `examples` zone:

```shell
export SF_DIR=`pwd`/smartfox/instance

bundle exec ruby simple.rb some_user some_password examples
bundle exec ruby any.rb some_user some_password examples
bundle exec ruby keep_alive.rb some_user some_password examples
```

You need to `CTRL+C` each example.
