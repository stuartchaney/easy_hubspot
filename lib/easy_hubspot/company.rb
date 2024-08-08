# frozen_string_literal: true

module EasyHubspot
  # class EasyHubspot::Company
  class Company < EasyHubspot::Base
    class << self
      COMPANY_ENDPOINT = 'crm/v3/objects/companies'

      def get_company(company_id, property_list = [])
        Client.do_get(company_id_endpoint(company_id, property_list), headers)
      end

      def get_companies(property_list = [], after = nil)
        property_list = get_all_properties if property_list.empty?
        url = COMPANY_ENDPOINT + "?limit=100&properties=#{CGI.escape(property_list.join(','))}"
        url += "&after=#{after}" if after
        Client.do_get(url, headers)
      end

      def create_company(body)
        Client.do_post(COMPANY_ENDPOINT, body, headers)
      end

      def update_company(company_id, body)
        Client.do_patch(company_id_endpoint(company_id), body, headers)
      end

      def delete_company(company_id)
        Client.do_delete(company_id_endpoint(company_id), headers)
      end

      def update_or_create_company(email, body)
        res = get_company(email)
        if res && res[:id]
          update_company(email, body)
        else
          create_company(body)
        end
      end

      def get_all_properties
        @get_all_properties ||= EasyHubspot::Property.get_properties("companies")[:results].collect { |property| property[:name] }
      end

      private

    def company_id_endpoint(company_id, property_list = [])
        property_list = get_all_properties if property_list.empty?
        url = "#{COMPANY_ENDPOINT}/#{company_id}"
        url += "?properties=#{CGI.escape(property_list.join(','))}"
        return url
      end
    end
  end
end
