$client = Graphlient::Client.new('https://integracion-rick-morty-api.herokuapp.com/graphql/')


class CharactersController < ApplicationController
  def show
    @id = params[:id]

    res_character = $client.query(id: @id) do
      query(id: :ID) do
        character(id: :id) do
          id
          name
          status
          species
          type
          gender
          origin {
            id
            name
          }
          location {
            id
            name
          }
          image
          episode {
            id
            name
          }
        end
      end
    end

    @character = res_character.data.character
                                      
    @episodes = res_character.data.character.episode
  end
end
