require 'faraday'

module Adcloud

  class InvalidApiResponse < StandardError; end

  class ResponseErrorHandler < Faraday::Response::Middleware

    def create_and_register_module(parent = Object, name)
      mod = Module.new
      parent.const_set name, mod
    end

    def create_and_register_klass(parent, superclass, class_name, &block)
      klass = Class.new superclass, &block
      parent.const_set class_name, klass
    end

    def create_and_register_modules_from_array(response_array, registered_module = Object)
      response_array[0..-2].each do |module_item_name|
        registered_module = create_and_register_module(registered_module, module_item_name)
      end
      registered_module
    end

    def create_exception_from_string(response_string, superclass = StandardError, &block)
      response_array = response_string.split("::")
      mod = create_and_register_modules_from_array(response_array)
      create_and_register_klass(mod, superclass, response_array.last)   
    end

    def call(env)
      @app.call(env).on_complete do
        response = env[:response]
        # TODO Fix this - an metakey is not everytime there
        # raise InvalidApiResponse unless response.body.has_key?("_meta")
        # puts result["_meta"]["details"]
        if response.success?
          response.body
        else
          # TODO raise some known erros here
          # klass = create_exception_from_string(response.body["_meta"]["type"])
          # raise klass.new({response.body["_meta"]["status"] => response.body["_meta"]["message"]})
        end
      end
    end

  end

end