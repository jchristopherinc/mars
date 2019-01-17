# Mars

## Problem Statement

Tracking data across different services and tracking acknowledgement across multiple clients is hard. I wanted to have a single dashboard where I can see all the messages (tracked by a unique `message_id`) and all events emitted by each message during different stages in it's lifecycle.

The events are processed as mentioned in Event Engine flow 👇 below. You can track the life cycle of your data based on the missing events.

## Event Engine flow

Event engine has 3 pipelines

* EventCollector
* EventAggregator
* EventStore

**EventCollector**

Event Collector is a FIFO Queue to receive all events from HTTP End points or External message brokers to put into our FIFO Queue inside Elixir's GenStage.

We create 10 EventCollectors during application start.

**EventAggregator**

Event Aggregator GenStage will periodically poll *EventCollector* with a pre-defined batch size to get events from the FIFO Queue and aggregate it by a unique message ID. 

For eg., in a batch of 10, say message ID `a` has 3 events all of them will be batched together and made as a single entry with array of events as it's value. 

We create 10 EventAggregators which will be subscribed to one EventCollector each.

**EventStore**

Event Store stores events into a persistent storage. It will do an upsert based on the unique messageID. 

We create 10 EventStores for each EventCollector instance, so as to parallelize storage layer.

## Websockets

We have a thin websocket layer to show updates to a messageId in real time. Messages to Websockets are emitted during *EventStore*. 

## Event Structure

Sample single event payload

```json
{
  "app_id": "<string>",
  "message_id": "<string>",
  "event": "<string>",
  "created_at": "<utc_timestamp>"
}
```

Sample bulk event payload

```json
{
  "events": [{
    "app_id": "<string>",
    "message_id": "<string>",
    "event": "<string>",
    "created_at": "<utc_timestamp>"
  }]
}
```

### Http Endpoints

Expose HTTP End points `/api/create_event` to trigger events from external systems.

*TODO*: Add support for Message brokers.

## For testing in dev environment

https://localhost:4001/api/create_event - End point to generate random events for test

https://localhost:4001/api/test_socket?message_id=5250000 - End point to generate random events for a messageId to test if it appears through websockets

https://localhost:4001/status - Service health check

https://localhost:4001/api/q/stats - Queue statistics page

## Stress testing

You can set the number of events created during each time we hit https://localhost:4001/api/create_event in the `event_controller.ex`

I've used `wrk` to generate load.

Run `mars` in prod mode `MIX_ENV=prod mix phx.server`

Sample `wrk` command

`wrk -t1 -c1 -d10s http://localhost:4000/api/create_event`

**Sample result**

```
wrk -t20 -c20 -d10s http://localhost:4000/api/create_event
Running 10s test @ http://localhost:4000/api/create_event
  20 threads and 20 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.29ms    2.70ms  60.49ms   94.22%
    Req/Sec   517.54     81.16     1.04k    73.65%
  103177 requests in 10.02s, 22.85MB read
Requests/sec:  10293.71
Transfer/sec:      2.28MB
```

It's over **9000** 	`\( ﾟヮﾟ)/`

*Note*: I got around >9k req/s for a couple of times. Most other times ~8k req/s +/- 500 req/s seemed fine for my use case :) Don't take benchmarks seriously. Also it wasn't benchmarked in Cloud. Done from my MBP.

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
