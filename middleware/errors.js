const debug = require('debug')('run__on::server::middelware/error.js')

/**
 * Generic error handler. Renders an internal error message.
 *
 * @param {Object.<Error>} err
 * @param {Object} req
 * @param {Object} res
 * @param {function} next
 */
const internalError = (err, req, res, next) => {
  debug('internal error %O', err)
  res.render('error', {
    title: 'Error status 500',
    message: 'Internal Server Error'
  })
}

module.exports = {
  internalError
}
