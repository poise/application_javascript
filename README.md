# Application_Javascript Cookbook

[![Build Status](https://img.shields.io/travis/poise/application_javascript.svg)](https://travis-ci.org/poise/application_javascript)
[![Gem Version](https://img.shields.io/gem/v/poise-application-javascript.svg)](https://rubygems.org/gems/poise-application-javascript)
[![Cookbook Version](https://img.shields.io/cookbook/v/application_javascript.svg)](https://supermarket.chef.io/cookbooks/application_javascript)
[![Coverage](https://img.shields.io/codecov/c/github/poise/application_javascript.svg)](https://codecov.io/github/poise/application_javascript)
[![Gemnasium](https://img.shields.io/gemnasium/poise/application_javascript.svg)](https://gemnasium.com/poise/application_javascript)
[![License](https://img.shields.io/badge/license-Apache_2-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

A [Chef](https://www.chef.io/) cookbook to deploy server-side JavaScript
applications using Node.js or io.js.

## Quick Start

To deploy an Express application from git:

```ruby
application '/srv/myapp' do
  git 'https://github.com/example/myapp.git'
  npm_install
  npm_start
end
```

## Requirements

Chef 12 or newer is required.

## Resources

### `application_javascript`

The `application_javascript` resource installs a JavaScript runtime for the
deployment.

```ruby
application '/srv/myapp' do
  javascript '3'
end
```

All actions and properties are the same as the [`javascript_runtime` resource](https://github.com/poise/poise-javascript#javascript_runtime).

### `application_javascript_service`

The `application_javascript_javascript_service` resource creates a service for a
JavaScript command.

```ruby
application '/srv/myapp' do
  javascript_service 'main.js'
end
```

#### Actions

* `:enable` – Create, enable and start the service. *(default)*
* `:disable` – Stop, disable, and destroy the service.
* `:start` – Start the service.
* `:stop` – Stop the service.
* `:restart` – Stop and then start the service.
* `:reload` – Send the configured reload signal to the service.

#### Properties

* `command` – Command to run. *(name attribute)*
* `path` – Base path for the application. *(default: application path)*
* `service_name` – Name of the service to create. *(default: auto-detect)*
# `user` – User to run the service as. *(default: application owner)*

### `application_node_package`

The `application_node_package` resource installs NPM packages for the deployment.

```ruby
application '/srv/myapp' do
  node_package 'grunt-cli'
end
```

All actions and properties are the same as the [`node_package` resource](https://github.com/poise/poise-javascript#node_package),
except that the `group` and `user` properties default to the application-level
data if not specified.

### `application_npm_start`

The `application_npm_start` resource creates a service for a JavaScript
application using `npm start`.

```ruby
application '/srv/myapp' do
  npm_start
end
```

#### Actions

* `:enable` – Create, enable and start the service. *(default)*
* `:disable` – Stop, disable, and destroy the service.
* `:start` – Start the service.
* `:stop` – Stop the service.
* `:restart` – Stop and then start the service.
* `:reload` – Send the configured reload signal to the service.

#### Properties

* `path` – Base path for the application. *(default: name attribute)*
* `command` – NPM subcommand to run. *(default: start)*
* `service_name` – Name of the service to create. *(default: auto-detect)*
# `user` – User to run the service as. *(default: application owner)*

## Sponsors

Development sponsored by [Chef Software](https://www.chef.io/), [Symonds & Son](http://symondsandson.com/), and [Orion](https://www.orionlabs.co/).

The Poise test server infrastructure is sponsored by [Rackspace](https://rackspace.com/).

## License

Copyright 2015, Noah Kantrowitz

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
