defmodule Prime do
  def sequence do
    Stream.iterate(2, &(&1+1)) |> Stream.filter(&prime?/1)
  end
 
  def prime?(2), do: true
  def prime?(n) when n<2 or rem(n,2)==0, do: false
  def prime?(n), do: prime?(n,3)
 
  defp prime?(n,k) when n<k*k, do: true
  defp prime?(n,k) when rem(n,k)==0, do: false
  defp prime?(n,k), do: prime?(n,k+2)
end