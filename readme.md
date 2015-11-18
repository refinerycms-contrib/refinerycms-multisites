# Refinery CMS Multisites

[WORK IN PROGRESS] Multisites extension for [Refinery CMS](http://refinerycms.com).

## TODO

* Refactor the account form to use the refinery register form,
* Add ability to destroy an account in user admin form,
* Add ability to list assets/views by accounts,
* Add ability to switch on domain,
* Add locales,
* Testing.


## Requirements

Refinery CMS version 3.0.0 or above.

## Install

Open up your ``Gemfile`` and add at the bottom this line:

```ruby
gem 'refinerycms-multisites', github: 'refinery/refinerycms-multisites', branch: 'master'
```

Now run `bundle install` and once bundler has installed the gem run:

Next, to install the multisites plugin run:

    $ rails generate refinery:multisites

Run database migrations:

    $ bundle exec rake db:migrate

Finally seed your database and you're done.

    $ bundle exec rake db:seed


## Usage

Temporaly set the app in single tenant mode:

	# config/initializer/refinery/multisites.rb
	Refinery::Multisites.configure do |config|
	[...]
		config.single_tenant_mode = true
	[...]
	end

Start the server with ``lvh.me``:

	rails s -p 3000 -b lvh.me

Register your first user in the public app:

	http://lvh.me:3000/refinery/users/register

Create a new subdomain:

	http://lvh.me:3000/refinery/multisites/accounts/new

Kill the server

Set the app in multi tenant mode:

	# config/initializer/refinery/multisites.rb
	Refinery::Multisites.configure do |config|
	[...]
		config.single_tenant_mode = false
	[...]
	end

Restart the server ``lvh.me``:

	rails s -p 3000 -b lvh.me

Go to your new subdomain:

	http://newsubdomain.lvh.me:3000/


## Developing & Contributing

The version of Refinery to develop this engine against is defined in the gemspec. To override the version of refinery to develop against, edit the project Gemfile to point to a local path containing a clone of refinerycms.

### Testing

Generate the dummy application to test against

    $ bundle exec rake refinery:testing:dummy_app

Run the test suite with [Guard](https://github.com/guard/guard)

    $ bundle exec guard start

Or just with rake spec

    $ bundle exec rake spec