#!/usr/bin/env coffee

show = console.log
write = (x) -> process.stdout.write x
{exec} = require 'child_process'
path = require 'path'

info = (str) -> write "info: #{str}"
goto = (str) -> write "goto: #{str}"

[link, pathname] = process.argv[2..3]

filepath = path.join __dirname, 'links'

fs = require 'fs'

unless fs.existsSync filepath
  fs.writeFileSync filepath, '{}'

data = fs.readFileSync filepath, 'utf8'
data = JSON.parse data

unless link?
  info 'need arguments!\n'

else if link is '-l'
  display = []
  for key, value of data
    display.push "#{key}:\\t#{value}"
  info display.join('\\n')

else if link is '-d'
  if pathname?
    if data[pathname]?
      delete data[pathname]
    info "removed link '#{pathname}'"
  else info 'add an link to delete...'

else if pathname?
  pathname =
    if pathname[0] is '/' then pathname else
      path.join process.env.PWD, pathname
  data[link] = pathname
  # fs.writeFileSync filepath, (JSON.stringify data)
  info "'#{link}' -> '#{pathname}' saved!"

else if data[link]
  target = data[link]
  exsit = fs.existsSync target
  if exsit then goto "#{data[link]}"
  else
    info "path #{data[link]} not exists!"
    delete data[link]

else
  info "link '#{link}' not found!"

fs.writeFileSync filepath, (JSON.stringify data)