defmodule Identicon do
  alias IO.ANSI, as: Ansi

  @moduledoc """
  Identicon generator written in Elixir
  Resources:
  * https://en.wikipedia.org/wiki/Identicon
  * https://github.com/mauricius/identicon
  """

  @doc """
  Exports a string into an Identicon PNG image.

  ## Parameters

    - input: The input string.
  """
  def export(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  @doc """
  Outputs the Identicon directly to console.

  ## Parameters

    - input: The input string.
  """
  def console(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> output_image
  end

  @doc """
  Outputs the Identicon.Image to console.

  ## Parameters

    - image: The Identicon.Image struct.
  """
  def output_image(%Identicon.Image{color: color, grid: grid} = _image) do
    color = Color.rgb_to_ansi(color)

    Enum.each(grid, fn {code, index} ->
      if rem(index, 5) == 0 do
        IO.write("\n")
      end

      if rem(code, 2) == 0 do
        IO.write(Ansi.color_background(color) <> "  " <> Ansi.reset())
      else
        IO.write(Ansi.white_background() <> "  " <> Ansi.reset())
      end
    end)

    IO.write("\n")
  end

  @doc """
  Draws the Identicon.Image as binary image
  http://erlang.org/documentation/doc-6.1/lib/percept-0.8.9/doc/html/egd.html

  ## Parameters

    - image: The Identicon.Image struct.
  """
  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn {start, stop} ->
      :egd.filledRectangle(image, start, stop, fill)
    end)

    :egd.render(image)
  end

  @doc """
  Saves the image as PNG.

  ## Parameters

    - image: The binary Image.
    - input: the input string
  """
  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

  @doc """
  Generates the pixel map from the Image grid

  ## Parameters

    - image: The Identicon.Image struct
  """
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_, index} ->
        horizontal = rem(index, 5) * 50
        vertical = div(index, 5) * 50
        top_left = {horizontal, vertical}
        bottom_right = {horizontal + 50, vertical + 50}

        {top_left, bottom_right}
      end)

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid =
      Enum.filter(grid, fn {code, _index} ->
        rem(code, 2) == 0
      end)

    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Builds the Identicon grid

  ## Parameters

    - image: The Identicon.Image struct
  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      # Enum.chunk has been deprecated
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Mirrors an enumerable with 3 elements

  ## Parameters

    - row: An enumerable

  ## Examples

      iex> Identicon.mirror_row([1,2,3])
      [1,2,3,2,1]
  """
  def mirror_row(row) do
    [first, second | _tail] = row

    row ++ [second, first]
  end

  @doc """
  Picks the first three elements as the RGB color for the identicon

  ## Parameters

    - image: The Identicon.Image struct
  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
  Hashes the input and converts it into a list of bytes().

  ## Parameters

    - input: The input string
  """
  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end
end
