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

require 'chef/provider'
require 'chef/resource'
require 'poise'

require 'poise_application_javascript/service_mixin'


module PoiseApplicationJavascript
  module Resources
    # (see JavascriptService::Resource)
    # @since 1.0.0
    module JavascriptService
      class Resource < Chef::Resource
        include PoiseApplicationJavascript::ServiceMixin
        provides(:application_javascript_service)

        # @!attribute command
        #   Command to run.
        #   @return [String]
        attribute(:command, kind_of: String, name_attribute: true)
        # @!attribute path
        #   Override {PoiseApplicationJavascript::ServiceMixin#path} to make it
        #   not the name_attribute.
        #   @return [String]
        attribute(:path, kind_of: String, default: lazy { parent && parent.path })
      end

      class Provider < Chef::Provider
        include PoiseApplicationJavascript::ServiceMixin
        provides(:application_javascript_service)

        private

        # (see PoiseApplication::ServiceMixin#service_options)
        def service_options(resource)
          super
          resource.javascript_command(new_resource.command)
        end

      end
    end
  end
end
