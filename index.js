// eslint-disable-next-line no-unused-vars
const debug = require('debug')('run__on::server::index.js')

// dependencies
const http = require('http')

// Dynamically determine PORT
const port = process.env.PORT

// internals
const app = require('./app')({ port })

const server = http.createServer(app)
server.listen(port)
debug('listening on port %d', port)
