defmodule Pooly.WorkerSupervisor do
	use Supervisor

	#API
	def start_link({_,_,_} = mfa) do
		Supervisor.start_link(__MODULE__, mfa)
	end

	#Callback
	def init({m, f, a} = x) do
		worker_ops = [
			restart: :permanent,
			function: f
		]

		children = [worker(m, a, worker_ops)]

		ops =  [
			strategy: :simple_one_for_one,
			max_retarts: 5,
			max_seconds: 5
		]

		supervise(children, ops)
	end

end