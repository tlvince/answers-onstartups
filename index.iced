_ = require 'underscore'
fs = require 'fs'
path = require 'path'
zlib = require 'zlib'
cheerio = require 'cheerio'

dir = 'public/html'
posts = []

await fs.readdir dir, defer err, files
for file in files
  await fs.readFile "#{dir}/#{file}", defer err, data
  await zlib.gunzip data, defer err, html
  $ = cheerio.load(html.toString())
  posts.push
    id: path.basename(file, '.html.gz')
    title: $('h1 span').text()

fs.writeFile 'posts.json', JSON.stringify posts
