defmodule Euler do
  def sum_digits(n), do: Enum.sum(Integer.digits(n, 10))
  def harshad?(n), do: rem(n, sum_digits(n)) == 0
  def truncate(n) when n >= 10, do: trunc(n/10)
  def truncate(_), do: nil
  def recursive_truncate(n) do
    Stream.unfold(n, fn x ->
      q = truncate(x)
      case q do
        nil -> nil
        _ -> {q, q}
      end
    end
    )
  end

  def strong?(n), do: Prime.prime?(n/sum_digits(n))
  def right_truncatable_harshad?(n), do: Enum.all?(recursive_truncate(n), &harshad?/1)
  def strong_right_truncatable_harshad?(n), do: right_truncatable_harshad?(n) && strong?(n)

  def solve(upper_bound) do
    Prime.sequence
    |> Enum.take_while(fn(n) -> n < upper_bound end)
    |> Enum.filter(&strong_right_truncatable_harshad?/1)
    |> IO.inspect
    |> Enum.sum
  end
end

