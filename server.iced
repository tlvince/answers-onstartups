fs = require 'fs'
http = require 'http'
zlib = require 'zlib'
connect = require 'connect'

app = connect()
  .use(connect.logger('dev'))
  .use(connect.static('public'))
  .use (req, res) ->
    if req.url == '/' then url = '/index.html' else url = req.url
    file = "public/html#{url}.gz"
    fs.exists file, (exists) ->
      file = 'public/html/404.html.gz' if not exists
      res.setHeader('content-encoding', 'gzip')
      fs.createReadStream(file).pipe(res)

http.createServer(app).listen process.env.PORT or 3000
