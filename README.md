# Mars

## Event Engine flow

This has an Event engine with 3 pipelines

```
EventCollector
EventAggregator
EventStore
```

**EventCollector**

Event Collector will be a FIFO Queue to receive all events from HTTP End points/External message brokers to put into our FIFO Queue inside Elixir's GenStage.

**EventAggregator**

Event Aggregator GenStage will periodically poll *EventCollector* with a pre-defined batch size to get events from the FIFO Queue and aggregate it by a unique message ID. 

For eg., in a batch of 10, say message ID `a` has 3 events all of them will be batched together and made as a single event. 

**EventStore**

Event Store, stores events into a persistent storage. It will do an upsert based on the unique messageID. 

### Http Endpoints

Expose HTTP End points `/api/create_event` to trigger events from external systems.

*TODO*: Add support for Message brokers later

## For testing in dev environment

https://localhost:4001/api/create_event - End point to generate test random events
https://localhost:4001/status - Service health check
https://localhost:4001/api/q/stats - Queue statistics page

## Installation steps

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4001`](http://localhost:4001) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
