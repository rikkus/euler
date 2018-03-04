defmodule Euler do
  ### Utilities

  @spec denary_digits(integer) :: [integer, ...]
  def denary_digits(n), do: Integer.digits(n, 10)

  @spec divisible_by?(integer, integer) :: boolean
  def divisible_by?(numerator, denominator), do: rem(numerator, denominator) == 0

  @spec sum_digits(integer) :: integer
  def sum_digits(n), do: Enum.sum(denary_digits(n))

  @spec right_truncatable?(integer) :: boolean
  def right_truncatable?(n), do: n >= 10

  @spec right_truncate(integer) :: integer
  def right_truncate(n) do
    unless right_truncatable?(n), do: raise ArgumentError, message: "Not right-truncatable: #{n}"
    trunc(n / 10)
  end

  # @spec recursive_right_truncate(integer) :: [integer, ...]
  # Dialyzer: "The success typing is (_) -> fun(({'cont',_} | {'halt',_} | {'suspend',_},_)
  # -> {'done',_} | {'halted',_} | {'suspended',_,fun((_) -> any())})
  # I don't know if it's possible to determine the actual output type statically.
  # I think I'll not bother trying to write a spec then!
  # |> Enum.to_list would give [integer, ...]
  def recursive_right_truncate(n) do
    Stream.unfold(n, fn x ->
      case right_truncatable?(x) do
        false -> nil
        true ->
          q = right_truncate(x) 
          {q, q}
      end
    end)
  end

  ### Definitions

  # "A Harshad or Niven number is a number that is divisible by the sum of its
  # digits."
  @spec harshad?(integer) :: boolean
  def harshad?(n), do: divisible_by?(n, sum_digits(n))

  # "Let's call a Harshad number that, while recursively truncating the last
  # digit, always results in a Harshad number a right truncatable Harshad
  # number."
  @spec right_truncatable_harshad?(integer) :: boolean
  def right_truncatable_harshad?(n) do
    unless harshad?(n), do: raise("Not harshad: #{n}")

    Enum.all?(recursive_right_truncate(n), &harshad?/1)
  end

  # "Let's call a Harshad number that, when divided by the sum of its digits,
  # results in a prime a strong Harshad number."
  @spec strong_harshad?(integer) :: boolean
  def strong_harshad?(n) do
    unless harshad?(n), do: raise("Not harshad: #{n}")

    Prime.prime?(div(n, sum_digits(n)))
  end

  @spec strong_right_truncatable_harshad_number?(integer) :: boolean
  def strong_right_truncatable_harshad_number?(n) do
    harshad?(n) && strong_harshad?(n) && right_truncatable_harshad?(n)
  end

  # "Now take the number 2011 which is prime. When we truncate the last digit
  # from it we get 201, a strong Harshad number that is also right truncatable.
  # Let's call such primes strong, right truncatable Harshad primes."
  # => A strong, right-truncatable Harshad prime is:
  #  o A prime
  #  ... which, when right-truncated, results in ...
  #  o A strong, right-truncatable Harshad number
  @spec strong_right_truncatable_harshad_prime?(integer) :: boolean
  def strong_right_truncatable_harshad_prime?(n) do
    unless Prime.prime?(n), do: raise("Not prime: #{n}")
    unless right_truncatable?(n), do: raise("Not right-truncatable: #{n}")

    strong_right_truncatable_harshad_number?(right_truncate(n))
  end

  @spec solve(integer) :: integer
  def solve(upper_bound) do
    Prime.sequence()
    |> Enum.take_while(fn n -> n < upper_bound end)
    |> Enum.filter(&right_truncatable?/1)
    |> Enum.filter(&strong_right_truncatable_harshad_prime?/1)
    |> IO.inspect
    |> Enum.sum()
  end
end
