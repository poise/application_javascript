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

require 'poise_javascript/resources/javascript_execute'

require 'poise_application_javascript/app_mixin'


module PoiseApplicationJavascript
  module Resources
    # (see JavascriptExecute::Resource)
    # @since 1.0.0
    module JavascriptExecute
      # An `application_javascript_execute` resource to install NPM packages inside
      # an Application cookbook deployment.
      #
      # @provides application_javascript_execute
      # @action install
      # @action upgrade
      # @action remove
      # @example
      #   application '/app' do
      #     javascript_execute './node_modules/bin/grunt build'
      #   end
      class Resource < PoiseJavascript::Resources::JavascriptExecute::Resource
        include PoiseApplicationJavascript::AppMixin
        provides(:application_javascript_javascript_execute)
        subclass_providers!

        # @todo This should handle relative paths against parent.path.
      end
    end
  end
end
