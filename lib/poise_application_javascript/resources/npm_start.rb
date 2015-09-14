#
# Copyright 2015, Noah Kantrowitz
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'shellwords'

require 'chef/provider'
require 'chef/resource'
require 'poise'

require 'poise_application_javascript/service_mixin'


module PoiseApplicationJavascript
  module Resources
    # (see NpmStart::Resource)
    # @since 1.0.0
    module NpmStart
      # An `application_npm_start` resource to create a service for a Javascript
      # application using `npm start`.
      #
      # @provides application_npm_start
      # @action enable
      # @action disable
      # @action start
      # @action stop
      # @action restart
      # @action reload
      # @example
      #   application '/app' do
      #     npm_start
      #   end
      class Resource < Chef::Resource
        include PoiseApplicationJavascript::ServiceMixin
        provides(:application_npm_start)

        # @!attribute command
        #   NPM sub-command to run. Defaults to `start`.
        #   @return [String, Array<String>]
        attribute(:command, kind_of: [String, Array], default: 'start')
      end

      # The default provider for `application_npm_start`.
      #
      # @see Resource
      # @provides application_npm_start
      class Provider < Chef::Provider
        include PoiseApplicationJavascript::ServiceMixin
        provides(:application_npm_start)

        private

        # (see PoiseApplication::ServiceMixin#service_options)
        def service_options(resource)
          super
          npm_cmd = [new_resource.npm_binary] + Array(new_resource.command)
          resource.javascript_command(Shellwords.join(npm_cmd))
          # Make sure node is on $PATH because grrr.
          new_path = [::File.dirname(new_resource.javascript), (new_resource.app_state_environment_javascript['PATH'] || ENV['PATH']).to_s].join(::File::PATH_SEPARATOR)
          resource.environment['PATH'] = new_path
        end

      end
    end
  end
end
