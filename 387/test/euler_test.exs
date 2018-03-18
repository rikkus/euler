defmodule EulerTest do
  use ExUnit.Case
  doctest Euler

  test "201 is Harshad" do
    assert Euler.harshad?(201)
  end

  test "Hardy-Ramanujan number (1729) is a Harshad number" do
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

  test "10^4" do
    assert 90619 == Euler.solve(10_000)
  end

  test "10^14" do
    assert 696067597313468 == Euler.solve(100_000_000_000_000)
  end
end
