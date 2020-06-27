$client = Graphlient::Client.new('https://rickandmortyapi.com/graphql/')

class LocationsController < ApplicationController
  def show
      @id = params[:id]

      res_location = $client.query(id: @id) do
        query(id: :ID) do
          location(id: :id) do
            id
            name
            type
            dimension
            residents {
              id
              name
            }
          end
        end
      end

      @location = res_location.data.location
      
      @characters = res_location.data.location.residents
  end
end
