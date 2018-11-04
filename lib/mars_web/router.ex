defmodule MarsWeb.Router do
  use MarsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # HTML 
  scope "/", MarsWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/status", StatusController, :get_status
  end

  # API
  scope "/api", MarsWeb do
    pipe_through :api

    get "/create_event", EventController, :test_create_event
    get "/q/stats", QueueStatusController, :get_status

    post "/event", EventController, :create_event
  end
end
