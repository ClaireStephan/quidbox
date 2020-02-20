# config/initializers/swagger-docs.rb
Swagger::Docs::Config.register_apis({
  "1.0" => {
    :api_extension_type => :json,
    :api_file_path => "public/apidocs",
    :base_path => "http://localhost:3000",
    :clean_directory => true,
    :base_api_controller => ActionController::API,
    :attributes => {
      :info => {
        "title" => "Quidbox API",
        "description" => "Quidbox API documentation",
        "contact" => ""
      }
    }
  }
})

class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    # Make a distinction between the APIs and API documentation paths.
    "apidocs/#{path}"
  end
end
