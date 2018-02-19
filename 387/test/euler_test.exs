defmodule EulerTest do
  use ExUnit.Case
  doctest Euler

  test "201 is harshad" do
    assert Euler.harshad?(201)
  end

  test "201 truncated is 20" do
    assert 20 == Euler.truncate(201)
  end

  test "20 truncated is 2" do
    assert 2 == Euler.truncate(20)
  end

  test "201 is right truncatable harshad number" do
    assert Euler.right_truncatable_harshad?(201)
  end

  test "2011 is strong harshad number" do
    assert Euler.strong?(2011)
  end

  test "2011 is right truncatable harshad number" do
    assert Euler.right_truncatable_harshad?(2011)
  end

  test "2011 is strong right truncatable harshad prime" do
    assert Euler.strong_right_truncatable_harshad?(2011)
  end

  test "truncate" do
    assert [20, 2] == Euler.recursive_truncate(201) |> Enum.to_list
  end

  test "primes" do
    assert [2, 3, 5, 7, 11] == Prime.sequence() |> Enum.take(5) |> Enum.to_list
  end

  test "one" do
    assert 90619 == Euler.solve(10_000)
  end

end
