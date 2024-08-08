# frozen_string_literal: true

module EasyHubspot
  # class EasyHubspot::Company
  class Property < EasyHubspot::Base
    class << self
      PROPERTY_ENDPOINT = 'crm/v3/properties/'

      def get_property(object_type, property_name)
        Client.do_get(property_name_endpoint(object_type, property_name), headers)
      end

      def get_properties(object_type)
        Client.do_get(properties_endpoint(object_type), headers)
      end

      def create_property(object_type, property_params)
        Client.do_post(properties_endpoint(object_type), property_params, headers)
      end

      private

      def properties_endpoint(object_type)
        "#{PROPERTY_ENDPOINT}/#{object_type}"
      end

      def property_id_endpoint(object_type, property_id)
        url = "#{PROPERTY_ENDPOINT}/#{company_id}"
        url += "?properties=#{CGI.escape(property_list.join(','))}" if property_list
        return url
      end
    end
  end
end
