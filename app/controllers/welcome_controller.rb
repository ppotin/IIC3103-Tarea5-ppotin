require "http"
require "json"

$client = Graphlient::Client.new('https://integracion-rick-morty-api.herokuapp.com/graphql/')

class WelcomeController < ApplicationController
  def index

    response = $client.query <<~GRAPHQL
      query {
        episodes(page: 1) {
          results {
            id
            name
            air_date
            episode
            characters
          }
        }
      }
      GRAPHQL

    response2 = $client.query <<~GRAPHQL
      query {
        episodes(page: 2) {
          results {
            id
            name
            air_date
            episode
            characters
          }
        }
      }
      GRAPHQL

    # puts 'response:'
    # puts response.data.episodes.results
    # puts 'end'

    @algo = []
    @episodes = response.data.episodes.results
    @episodes2 = response2.data.episodes.results
  end

  def search  
    @input = params[:search].downcase
    @episodes_results = []
    @characters_results = []
    @locations_results = []

    begin
      res_episodes = $client.query(input: @input) do
        query(input: :string) do
          episodes(page: 1, filter: {name: :input}) do
            results do
              id
              name
              air_date
              episode
              characters
            end
          end
        end
      end
      @episodes = res_episodes.data.episodes.results
    rescue Graphlient::Errors::ExecutionError => e
      @episodes = []
    end

    begin
      res_episodes2 = $client.query(input: @input) do
        query(input: :string) do
          episodes(page: 2, filter: {name: :input}) do
            results do
              id
              name
              air_date
              episode
              characters
            end
          end
        end
      end
      @episodes2 = res_episodes2.data.episodes.results
    rescue Graphlient::Errors::ExecutionError => e
      @episodes2 = []
    end

    @episodes.each do |episode|
      @episodes_results.push(episode)
    end

    @episodes2.each do |episode2|
      @episodes_results.push(episode2)
    end

    for i in 1..30 do

      begin
        res_characters = $client.query(input: @input, i: i) do
          query(input: :string, i: :int) do
            characters(page: :i, filter: {name: :input}) do
              results do
                id
                name
              end
            end
          end
        end
        @characters = res_characters.data.characters.results
      rescue Graphlient::Errors::ExecutionError => e
        @characters = []
      end

      @characters.each do |character|
        @characters_results.push(character)
      end

    end

    for j in 1..5 do

      begin

        res_locations = $client.query(input: @input, j: j) do
          query(input: :string, j: :int) do
            locations(page: :j, filter: {name: :input}) do
              results do
                id
                name
              end
            end
          end
        end

        @locations = res_locations.data.locations.results
      rescue Graphlient::Errors::ExecutionError => e
        @locations = []
      end
      
      @locations.each do |location|
        @locations_results.push(location)
      end
    end

  end
end
