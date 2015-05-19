working_directory "/app"

pid "/app/pids/unicorn.pid"

stderr_path "/app/log/unicorn_err.log"
stdout_path "/app/log/unicorn_out.log"

listen "/tmp/unicorn.app.sock"

worker_processes 2

timeout 30
