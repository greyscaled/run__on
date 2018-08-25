/**
 * Configures and exports an Express application
 *
 * @param {Object} options
 * @param {number|string} options.port
 * @returns {Object} app
 */
module.exports = function ({ port }) {
  const debug = require('debug')('run__on::server::app.js')
  const express = require('express')
  const path = require('path')
  const helmet = require('helmet')
  const RateLimit = require('express-rate-limit')

  const { internalError } = require('./middleware')

  // Configuration ----------------/
  debug('configuring express application')

  const app = express()

  // set the port
  if (port) {
    debug('setting port to %d', port)
    app.set('port', port)
  }

  // res.render calls use pug templates in views directory
  app.set('view engine', 'pug')
  app.set('views', path.join(__dirname, 'views'))

  // for use behind Heroku proxy
  app.enable('trust proxy')

  // PRE-ROUTE --------------------/

  // adds basic security headers
  app.use(helmet())

  // request rate limited
  app.use(new RateLimit({
    // 10 minutes
    windowMs: 10 * 60 * 1000,
    // 1000 requests per 10 mins
    max: 1000,
    delayMs: 0
  }))

  // ROUTING ----------------------/

  require('./routes')(app)

  // POST-ROUTE -------------------/
  app.use(internalError)

  return app
}
