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

require 'net/http'

require 'serverspec'
set :backend, :exec

describe 'express' do
  describe port(8000) do
    it { is_expected.to be_listening }
  end

  let(:http) { Net::HTTP.new('localhost', 3000) }

  describe '/' do
    subject { http.get('/') }
    its(:code) { is_expected.to eq '200' }
    its(:body) { is_expected.to include 'Welcome to Express' }
  end

  describe '/users' do
    subject { http.get('/users') }
    its(:code) { is_expected.to eq '200' }
    its(:body) { is_expected.to include 'respond with a resource' }
  end

  describe '/404' do
    subject { http.get('/404') }
    its(:code) { is_expected.to eq '404' }
    its(:body) { is_expected.to include 'Error: Not Found' }
  end
end

