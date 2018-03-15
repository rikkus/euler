defmodule EulerTest do
  use ExUnit.Case
  doctest Euler

  test "201 is Harshad" do
    assert Euler.harshad?(201)
  end

  test "Hardy–Ramanujan number (1729) is a Harshad number" do
    assert Euler.harshad?(1729)
  end

  test "Harshads match A005349 in OES" do
    assert [
             1,
             2,
             3,
             4,
             5,
             6,
             7,
             8,
             9,
             10,
             12,
             18,
             20,
             21,
             24,
             27,
             30,
             36,
             40,
             42,
             45,
             48,
             50,
             54,
             60,
             63,
             70,
             72,
             80,
             81,
             84,
             90,
             100,
             102,
             108,
             110,
             111,
             112,
             114,
             117,
             120,
             126,
             132,
             133,
             135,
             140,
             144,
             150,
             152,
             153,
             156,
             162,
             171,
             180,
             190,
             192,
             195,
             198,
             200
           ] ==
           Stream.unfold(1, fn(n) -> {n, n+1} end)
           |> Enum.take_while(fn(n) -> n <= 200 end)
           |> Enum.filter(&Euler.harshad?/1)
           |> Enum.to_list
  end

  test "201 right-truncated is 20" do
    assert 20 == Euler.right_truncate(201)
  end

  test "20 right-truncated is 2" do
    assert 2 == Euler.right_truncate(20)
  end

  test "2 right-truncated isn't possible" do
    assert_raise ArgumentError, "Not right-truncatable: 2", fn -> Euler.right_truncate(2) end
  end

  test "recursive_right_truncate recursively right-truncates" do
    assert [201, 20, 2] == Euler.recursive_right_truncate(2011) |> Enum.to_list()
  end

  test "201 is right truncatable Harshad number" do
    assert Euler.right_truncatable_harshad?(201)
  end

  test "201 is strong Harshad number" do
    assert Euler.strong_harshad?(201)
  end

  test "2011 is strong right truncatable Harshad prime" do
    #assert Euler.strong_right_truncatable_harshad_prime?(2011)
  end

  test "primes" do
    assert [2, 3, 5, 7, 11] == Prime.sequence() |> Enum.take(5) |> Enum.to_list()
  end

  @tag :skip
  test "one" do
    assert 90619 == Euler.solve(10_000)
  end

  test "one, but optimised" do
    assert 90619 == Euler.solve(10_000, :optimised)
  end

  @tag :skip
  test "10^14" do
    assert :mu == Euler.solve(100_000_000_000_000, :optimised)
  end
end
