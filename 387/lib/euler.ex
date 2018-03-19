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
    |> Enum.map(fn n -> sum_srthps({n, true, false}, upper_bound) end)
    |> Enum.sum()
  end

  @spec sum_srthps({integer, boolean, boolean}, integer) :: integer
  def sum_srthps({base, prev_is_harshad, prev_is_strong}, limit) do
    0..9
    |> Enum.map(fn digit -> base * 10 + digit end)
    |> Enum.filter(fn n -> n < limit end)
    |> Parallel.map(fn n -> step(n, {prev_is_harshad, prev_is_strong, harshad?(n), prime?(n)}, limit) end)
    |> Enum.sum()
  end

  # We have found a strong, right-truncatable harshard and should continue
  def step(n, {true, true, true, true}, limit), do: n + sum_srthps({n, true, strong?(n)}, limit)

  # We have found a strong, right-truncatable harshad but should stop
  def step(n, {true, true, false, true}, _), do: n

  # We have found a right-truncatable harshad and should continue
  def step(n, {true, _, true, _}, limit), do: sum_srthps({n, true, strong?(n)}, limit)

  def step(_, _, _), do: 0
end
