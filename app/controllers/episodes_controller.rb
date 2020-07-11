$client = Graphlient::Client.new('https://integracion-rick-morty-api.herokuapp.com/graphql/')

class EpisodesController < ApplicationController
  def show
    @id = params[:id]

    res_episode = $client.query(id: @id) do
      query(id: :ID) do
        episode(id: :id) do
          id
          name
          air_date
          episode
          characters {
            id
            name
          }
        end
      end
    end


    @episode = res_episode.data.episode
    @aux = res_episode.data.episode.characters
  end
end

