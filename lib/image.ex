defmodule Identicon.Image do
  @typedoc """
    Type that represents Image struct.
  """
  defstruct hex: nil, color: nil, grid: nil, pixel_map: nil

  @type t(hex, color, grid, pixel_map) :: %Identicon.Image{
          hex: hex,
          color: color,
          grid: grid,
          pixel_map: pixel_map
        }

  @type t :: %Identicon.Image{
          hex: list(integer()),
          color: tuple(),
          grid: list(),
          pixel_map: list()
        }
end
