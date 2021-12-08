defmodule Memoizer.Test do
  use Memoizer

    def     sparse_fib(0), do: 0

    def     sparse_fib(1), do: 1

    defmemo sparse_fib(n) when rem(n, 5) == 0,
                    do: sparse_fib(n - 1) + sparse_fib(n - 2)

    def     sparse_fib(n),
                    do: sparse_fib(n - 1) + sparse_fib(n - 2)


  defmemo  a(x), do: (IO.puts "a" ; b x)
  defmemop b(x), do: (IO.puts "b" ; x * 100)

  defmemo f(n) when n > 0 do
    IO.puts "n = #{n}"
  end

  defmemo first_seen(something) do
    :erlang.timestamp
  end

  defmemo first_time do
    :os.timestamp
  end

  defmemo add(a, b) do
    require Logger
    Logger.info "Applying #{__MODULE__}.add to #{a} and #{b} ..."
    a + b
  end

      def     fib(0),                     do: 0
      def     fib(1),                     do: 1
      defmemo fib(n) when rem(n, 7) == 0, do: 13 * fib(n - 6) +  8 * fib(n - 7)
      defmemo fib(n) when rem(n, 7) == 1, do: 21 * fib(n - 7) + 13 * fib(n - 8)
      def     fib(n) when rem(n, 7) == 2, do:      fib(n - 1) +      fib(n - 2)
      def     fib(n) when rem(n, 7) == 3, do:  2 * fib(n - 2) +      fib(n - 3)
      def     fib(n) when rem(n, 7) == 4, do:  3 * fib(n - 3) +  2 * fib(n - 4)
      def     fib(n) when rem(n, 7) == 5, do:  5 * fib(n - 4) +  3 * fib(n - 5)
      def     fib(n) when rem(n, 7) == 6, do:  8 * fib(n - 5) +  5 * fib(n - 6)


  def fib_plain(0), do: 0
  def fib_plain(1), do: 1
  def fib_plain(n), do: fib_plain(n-1) + fib_plain(n-2)

  defmodule Sup do
    use Supervisor

    def start_link do
      Supervisor.start_link __MODULE__, nil
    end

    def init(_) do
      children = [
        worker(Memoizer.Test, [])
      ]
      supervise children, strategy: :one_for_one
    end
  end
end

