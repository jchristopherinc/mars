# Mars

## Problem Statement

Tracking data across different data stores and deliverability across multiple clients is hard. I wanted to have a single dashboard where I can see all the messages (tracked by a unique `message_id`) and all events emitted by each of the message in it's lifecycle. 

The events are processed as mentioned in Event Engine flow 👇 below. You can track the life cycle of your data based on the missing events.

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

## Event Structure

Sample event payload

```
%{
  app_id: <string>,
  message_id: <string>,
  event: <string>,
  created_at: <utc_timestamp>
}
```

### Http Endpoints

Expose HTTP End points `/api/create_event` to trigger events from external systems.

*TODO*: Add support for Message brokers later

## For testing in dev environment

https://localhost:4001/api/create_event - End point to generate test random events

https://localhost:4001/status - Service health check

https://localhost:4001/api/q/stats - Queue statistics page

## Stress testing

You can set the number of events created during each time we hit https://localhost:4001/api/create_event in the `event_controller.ex`

I've used `wrk` to generate load.

Sample command

`wrk -t20 -c20 -d10s https://localhost:4001/api/create_event`

Sample result

```
wrk -t20 -c20 -d10s https://localhost:4001/api/create_event
Running 10s test @ https://localhost:4001/api/create_event
  20 threads and 20 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    28.25ms    9.13ms  56.79ms   71.36%
    Req/Sec    35.09      8.19    59.00     79.95%
  7092 requests in 10.10s, 1.57MB read
Requests/sec:    702.38
Transfer/sec:    159.24KB
```

## Installation steps

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
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
