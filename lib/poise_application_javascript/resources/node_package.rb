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

require 'poise_javascript/resources/node_package'

require 'poise_application_javascript/app_mixin'


module PoiseApplicationJavascript
  module Resources
    # (see NodePackage::Resource)
    # @since 1.0.0
    module NodePackage
      # An `application_node_package` resource to install NPM packages inside
      # an Application cookbook deployment.
      #
      # @provides application_node_package
      # @action install
      # @action upgrade
      # @action remove
      # @example
      #   application '/app' do
      #     node_package %w{grunt-cli gulp}
      #   end
      class Resource < PoiseJavascript::Resources::NodePackage::Resource
        include PoiseApplicationJavascript::AppMixin
        provides(:application_node_package)
        subclass_providers!

        def initialize(*args)
          super
          # For older Chef.
          @resource_name = :application_node_package
        end

        # #!attribute group
        #   Override the default group to be the app group if unspecified.
        #   @return [String, Integer]
        attribute(:group, kind_of: [String, Integer, NilClass], default: lazy { parent && parent.group })

        # #!attribute user
        #   Override the default user to be the app owner if unspecified.
        #   @return [String, Integer]
        attribute(:user, kind_of: [String, Integer, NilClass], default: lazy { parent && parent.owner })

        # @todo This should handle relative paths against parent.path.
      end
    end
  end
end
