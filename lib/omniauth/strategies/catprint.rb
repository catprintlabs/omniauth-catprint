# frozen_string_literal: true

require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class CatPrint < OmniAuth::Strategies::OAuth2
      option :name, "catprint"
      option :client_options, {
        site:           "https://www.catprint.com",
        authorize_path: "/oauth/authorize",
        token_path:     "/oauth/token"
      }

      uid { raw_info["id"].to_s }

      info do
        {
          nickname:   raw_info["login"],
          name:       raw_info["name"],
          first_name: raw_info["first_name"],
          last_name:  raw_info["last_name"],
          email:      raw_info["email"],
          image:      raw_info["image"]
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/users/self").parsed
      end
    end
  end
end

OmniAuth.config.add_camelization "catprint", "CatPrint"
