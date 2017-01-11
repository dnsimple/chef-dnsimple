require 'webmock/rspec'
require 'json'

module RSpec
  module Support
    module Webmock
      def self.included(spec)
        spec.class_eval do
          before do
            stub_request(:any, %r{\Ahttps://api.sandbox.dnsimple.com})
              .to_return(status: 200, body: %({"data":[], "pagination":{"current_page":1,"per_page":30,"total_entries":0,"total_pages":0}}), headers: {})
          end
        end
      end

      private

      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/MethodLength
      def stub_list_domains(user, domain_names)
        body = { data: [], pagination: { current_page: 1, per_page: 30, total_entries: domain_names.count, total_pages: 1 } }
        domain_names.each_with_index do |domain_name, i|
          body[:data] << Hash[
            id:            i + 1,
            account_id:    user.uid,
            registrant_id: nil,
            name:          domain_name,
            unicode_name:  domain_name,
            token:         "domain-token",
            state:         "hosted",
            auto_renew:    false,
            expires_on:    nil,
            created_at:    Time.now.utc.iso8601,
            updated_at:    Time.now.utc.iso8601
          ]
        end

        stub_request(:get, "https://api.sandbox.dnsimple.com/v2/#{user.uid}/domains")
          .with(headers: { 'Accept' => 'application/json', 'Authorization' => "Bearer #{user.token}", 'User-Agent' => "dnsimple-ruby/#{Dnsimple::VERSION} hello-domains-hanami" })
          .to_return(status: 200, body: JSON.generate(body), headers: {})
      end
      # rubocop:enable Metrics/AbcSize
      # rubocop:enable Metrics/MethodLength
    end
  end
end

RSpec.configure do |config|
  config.include(RSpec::Support::Webmock)
end
