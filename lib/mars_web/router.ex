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

  # API
  scope "/api", MarsWeb do
    pipe_through :api

    get "/create_event", EventController, :test_create_event
    get "/test_socket", EventController, :test_event_timeline_socket
    get "/q/stats", QueueStatusController, :get_status

    post "/event", EventController, :create_event
  end

  # HTML
  scope "/", MarsWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/status", StatusController, :get_status
    get "/search/event/", EventController, :list_events
    get "/*path", PageController, :index
  end
end
