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

require 'spec_helper'
require 'poise_application/cheftie'
require 'poise_javascript/cheftie'

describe PoiseApplicationJavascript::AppMixin do
  describe '#parent_javascript' do
    resource(:poise_test) do
      include described_class
    end
    provider(:poise_test)

    context 'with an app_state javascript' do
      recipe do
        javascript_runtime 'outer'
        application '/test' do
          app_state[:javascript] = PoiseJavascript::Resources::JavascriptRuntime::Resource.new('inner', run_context)
          poise_test
        end
        javascript_runtime 'after'
        poise_test 'after'
        application '/other'
        poise_test 'other'
      end
      let(:javascript) { chef_run.application('/test').app_state[:javascript] }

      it { is_expected.to run_poise_test('/test').with(parent_javascript: javascript) }
      it { is_expected.to run_poise_test('after').with(parent_javascript: javascript) }
      it { is_expected.to run_poise_test('other').with(parent_javascript: chef_run.javascript_runtime('after')) }
      it { expect(javascript).to be_a Chef::Resource }
    end # /context with an app_state javascript

    context 'with a global javascript' do
      recipe do
        javascript_runtime 'outer'
        application '/test' do
          poise_test
        end
      end

      it { is_expected.to run_poise_test('/test').with(parent_javascript: chef_run.javascript_runtime('outer')) }
    end # /context with a global javascript

    context 'with no javascript' do
      recipe do
        application '/test' do
          poise_test
        end
      end

      it { is_expected.to run_poise_test('/test').with(parent_javascript: nil) }
    end # /context with no javascript
  end # /describe #parent_javascript
end
