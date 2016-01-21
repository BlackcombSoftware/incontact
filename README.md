# inContact API

An **unofficial** gem for the inContact API. Documentation of the endpoints is available on their [developer portal](https://developer.incontact.com/).

To use it, you must have registered an application in InContact. This can be done from the management dashboard under the **Manage >> API Applications** menu.


## Installation

Add the gem to your Gemfile:
```ruby
gem 'incontact', :git => 'https://github.com/BlackcombSoftware/incontact.git'
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

### Without Parameters
Returns list of agents

```ruby
require 'incontact'
require 'json'

response = InContact::Connection.base.get "/inContactAPI/services/v6.0/agents"

agents = JSON.parse response.body
```

### With Parameters
Returns a list of completed contacts between `start_date` and `end_date`

```ruby
require 'incontact'
require 'time'
require 'json'

start_date = Time.now - (60*60) # An hour ago
end_date = Time.now

response = InContact::Connection.base.get "/inContactAPI/services/v6.0/contacts/completed", {:startDate => start_date.iso8601, :endDate => end_date.iso8601}

completed_contacts = JSON.parse response.body
```

## Tips

### Times / Dates
InContact requires that times be in ISO 8601 format. The standard Ruby library provides a [handy helper](http://ruby-doc.org/stdlib-2.1.1/libdoc/time/rdoc/Time.html#method-c-iso8601).

```ruby
require 'time'

puts Time.now.iso8601
# e.g => "2016-01-21T10:49:09-05:00"
```

## Disclaimer

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
