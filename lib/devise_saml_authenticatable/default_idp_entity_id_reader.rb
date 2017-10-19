module DeviseSamlAuthenticatable
	class DefaultIdpEntityIdReader
		def self.entity_id(params)
			begin
				if params[:SAMLRequest]
					request = OneLogin::RubySaml::SloLogoutrequest.new(
						params[:SAMLRequest],
						{:allowed_clock_drift => Devise.allowed_clock_drift_in_seconds}
					).issuer
					ap '====== SAML REQUEST SENT ====='
					ap request
					request
				elsif params[:SAMLResponse]
					ap '====== RESPONSE SENT TO RUBY SAML ====='
					ap params[:SAMLResponse]
					response = OneLogin::RubySaml::Response.new(
						params[:SAMLResponse],
						{:allowed_clock_drift => Devise.allowed_clock_drift_in_seconds}
					).issuers.first
					ap '====== RESPONSE ======='
					ap response
					response
				end
			rescue => e
				Airbrake.notify(e)
			end
		end
	end
end
