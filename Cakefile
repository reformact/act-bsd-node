{exec} = require 'child_process'

task 'build', 'Build source', ->
  console.log 'Compile starting'
  command = "coffee -co lib src"
  exec command, (err, stdout, stderr) ->
    if err
      console.log 'Error', err
      process.exit 1
    else
      console.log 'Compilation succeeded'
      process.exit 0
