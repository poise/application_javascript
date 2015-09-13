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

describe PoiseApplicationJavascript::Resources::Javascript do
  shared_examples 'application_javascript' do
    it { is_expected.to install_application_javascript('ver') }
    it { expect(chef_run.application('/test').app_state[:javascript]).to eq chef_run.application_javascript('ver') }
  end # /shared_examples application_javascript

  context 'with #javascript_runtime' do
    recipe do
      application '/test' do
        javascript_runtime 'ver'
      end
    end

    it_behaves_like 'application_javascript'
  end # /context with #javascript_runtime

  context 'with #javascript' do
    recipe do
      application '/test' do
        javascript 'ver'
      end
    end

    it_behaves_like 'application_javascript'
  end # /context with #javascript
end
