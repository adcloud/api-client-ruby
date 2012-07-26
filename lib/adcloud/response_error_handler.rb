require 'faraday'

module Adcloud

  class InvalidAPIResponse < StandardError; end

  class ResponseErrorHandler < Faraday::Response::Middleware

    def create_module_and_class(module_name, class_name, superclass, &block)
      mod = Module.new
      registered_module = Object.const_set module_name, mod
      klass = Class.new superclass, &block
      registered_module.const_set class_name, klass
    end

    def call(env)
      @app.call(env).on_complete do
        response = env[:response]
        raise InvalidAPIResponse unless response.body.has_key?("_meta")
        if response.success?
          response.body
        else
          module_name = response.body["_meta"]["type"].split("::")[0]
          klass_name = response.body["_meta"]["type"].split("::")[1]
          klass = create_module_and_class(module_name, klass_name, StandardError)
          raise klass.new({response.body["_meta"]["status"] => response.body["_meta"]["message"]})
        end
      end
    end

  end

end