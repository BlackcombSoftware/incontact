# InContact API

A gem for the InContact API.

To use it, you must have registered an application in InContact. This can be done from the management dashboard under the **Manage >> API Applications** menu.


## Installation

### Bundler
Add the gem to your Gemfile:
```ruby
gem 'incontact_api'
```

Or

### Manually

```ruby
gem install incontact_api
```
## Environment Variables

The following as environment variables are used to define the behavior of the gem:

`IC_APPLICATION_NAME` : **required** The name of a registered InContact application e.g. `SuperWidget`

`IC_VENDOR_NAME` : **required** The name of the vendor recorded on the registered InContact application e.g. `WidgetsInc.com`

`IC_BUSINESS_UNIT` : **required** The ID of the business unit that you wish to access data from.

`IC_USERNAME` : **required** The username that will be used to authenticate against the API and perform actions.

`IC_PASSWORD` : **required** The password for the above user.

`IC_SCOPE` : _optional_ The space separated list of scopes that the API token should be issued for. Defaults to all authorized scopes of the application. Example: `RealTimeDataApi AgentApi CustomApi` . See list of available scopes below.

`IC_GRANT_TYPE` : _optional_ The grant type for the API token. Defaults to username/password.

`IC_API_TOKEN_URL` : _optional_ The host to use when requesting an API token. Defaults to `https://api.incontact.com`

If you are using rails you could use the [Figaro](https://github.com/laserlemon/figaro) gem to handle setting up environment variables. If you do, it's a good idea to check for the required keys on load. Adding the following to `config/initializers/figaro.rb` will do the trick:

```ruby
require 'figaro'

Figaro.require_keys('IC_USERNAME', 'IC_PASSWORD', 'IC_APPLICATION_NAME', 'IC_VENDOR_NAME', 'IC_BUSINESS_UNIT')
```

### Available Scopes

* `RealTimeDataApi`
* `AdminApi`
* `AgentApi`
* `CustomApi`
* `AuthenticationApi`
* `PatronApi`

## Usage

Returns list of agents

```ruby
require 'incontact_api'

InContactApi::Connection.base.get "/inContactAPI/services/v6.0/agents"
```
