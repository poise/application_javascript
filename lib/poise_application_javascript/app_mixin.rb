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

require 'poise/backports'
require 'poise/utils'
require 'poise_application/app_mixin'
require 'poise_javascript/javascript_command_mixin'


module PoiseApplicationJavascript
  # A helper mixin for Javascript application resources and providers.
  #
  # @since 4.0.0
  module AppMixin
    include Poise::Utils::ResourceProviderMixin

    # A helper mixin for Javascript application resources.
    module Resource
      include PoiseApplication::AppMixin::Resource
      include PoiseJavascript::JavascriptCommandMixin::Resource

      # @!attribute parent_javascript
      #   Override the #parent_javascript from JavascriptCommandMixin to grok the
      #   application level parent as a default value.
      #   @return [PoiseJavascript::Resources::JavascriptRuntime::Resource, nil]
      parent_attribute(:javascript, type: :javascript_runtime, optional: true, default: lazy { app_state_javascript.equal?(self) ? nil : app_state_javascript })

      # @attribute app_state_javascript
      #   The application-level Javascript parent.
      #   @return [PoiseJavascript::Resources::JavascriptRuntime::Resource, nil]
      def app_state_javascript(javascript=Poise::NOT_PASSED)
        unless javascript == Poise::NOT_PASSED
          app_state[:javascript] = javascript
        end
        app_state[:javascript]
      end

      # A merged hash of environment variables for both the application state
      # and parent javascript.
      #
      # @return [Hash<String, String>]
      def app_state_environment_javascript
        env = app_state_environment
        env = env.merge(parent_javascript.javascript_environment) if parent_javascript
        env
      end
    end

    # A helper mixin for Javascript application providers.
    module Provider
      include PoiseApplication::AppMixin::Provider
    end
  end
end
