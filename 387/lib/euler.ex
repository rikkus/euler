defmodule Euler do
  ### Utilities

  @spec denary_digits(integer) :: [integer, ...]
  def denary_digits(n), do: Integer.digits(n, 10)

  @spec divisible_by?(integer, integer) :: boolean
  def divisible_by?(numerator, denominator), do: rem(numerator, denominator) == 0

  @spec sum_digits(integer) :: integer
  def sum_digits(n), do: Enum.sum(denary_digits(n))

  ### Definitions

  @spec harshad?(integer) :: boolean
  def harshad?(n), do: divisible_by?(n, sum_digits(n))

  @spec strong?(integer) :: boolean
  def strong?(n), do: prime?(div(n, sum_digits(n)))

  def prime?(n), do: :miller_rabin.is_prime(n)

  @spec solve(integer) :: integer
  def solve(upper_bound) do
    1..9
    |> Enum.map(fn n -> sum_srthps({n, harshad?(n), strong?(n)}, upper_bound) end)
    |> Enum.sum()
  end

  def sum_srthps({base, prev_is_harshad, prev_is_strong}, limit) do
    0..9
    |> Enum.map(fn digit -> base * 10 + digit end)
    |> Enum.filter(fn n -> n < limit end)
    |> Enum.map(fn n ->
      case {prev_is_harshad, prev_is_strong, harshad?(n), prime?(n)} do

        # We have found a strong, right-truncatable harshard and should continue
        {true, true, true, true} -> n + sum_srthps({n, true, strong?(n)}, limit)

        # We have found a strong, right-truncatable harshad but should stop
        {true, true, false, true} -> n

        # We have found a right-truncatable harshad and should continue
        {true, _, true, _} -> sum_srthps({n, true, strong?(n)}, limit)

        _ -> 0
      end
    end)
    |> Enum.sum
  end

end
