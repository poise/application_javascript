#
# Copyright 2015-2016, Noah Kantrowitz
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

require 'spec_helper'

describe PoiseApplicationJavascript::Resources::NpmStart do
  recipe do
    application '/test' do
      javascript 'ver' do
        def self.javascript_binary
          '/node'
        end
        def self.npm_binary
          '/npm'
        end
      end
      npm_start do
        run_context.resource_collection << provider_for_action(action).send(:service_resource)
      end
    end
  end

  it { is_expected.to enable_application_npm_start('/test').with(parent_javascript: chef_run.application_javascript('ver')) }
  it { is_expected.to enable_poise_service('/test').with(service_name: 'test', command: '/node /npm start', environment: {'PATH' => "/:#{ENV['PATH']}"}) }
end
