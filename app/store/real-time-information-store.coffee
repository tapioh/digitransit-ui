Store = require 'fluxible/addons/BaseStore'

class RealTimeInformationStore extends Store
  @storeName: 'RealTimeInformationStore'

  constructor: (dispatcher) ->
    super(dispatcher)
    @vehicles = {}

  storeClient: (client) =>
    @client = client

  clearClient: ->
    @client = undefined

  handleMessage: (message) ->
    [_, _, _, mode, id, line, dir, headsign, start_time, next_stop, geohash...] = message.topic.split '/'
    @vehicles[id] = JSON.parse(message.message).VP
    @emitChange(id)

  getVehicle: (id) =>
    @vehicles[id]

  @handlers:
    "RealTimeClientStarted": 'storeClient'
    "RealTimeClientStopped": 'clearClient'
    "RealTimeClientMessage": 'handleMessage'

module.exports = RealTimeInformationStore