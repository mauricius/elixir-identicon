defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "it should convert a string into a list of bytes" do
    %Identicon.Image{hex: hex} = Identicon.hash_input("test")

    assert hex == [9, 143, 107, 205, 70, 33, 211, 115, 202, 222, 78, 131, 38, 39, 180, 246]
  end

  test "it should pick the first three items as the color" do
    image = %Identicon.Image{
      hex: [9, 143, 107, 205, 70, 33, 211, 115, 202, 222, 78, 131, 38, 39, 180, 246]
    }

    %Identicon.Image{color: color} = Identicon.pick_color(image)

    assert color == {9, 143, 107}
  end

  test "it should build the grid as a list of tuples" do
    image = %Identicon.Image{
      hex: [9, 143, 107, 205, 70, 33, 211, 115, 202, 222, 78, 131, 38, 39, 180, 246]
    }

    %Identicon.Image{grid: grid} = Identicon.build_grid(image)

    assert grid == [
             {9, 0},
             {143, 1},
             {107, 2},
             {143, 3},
             {9, 4},
             {205, 5},
             {70, 6},
             {33, 7},
             {70, 8},
             {205, 9},
             {211, 10},
             {115, 11},
             {202, 12},
             {115, 13},
             {211, 14},
             {222, 15},
             {78, 16},
             {131, 17},
             {78, 18},
             {222, 19},
             {38, 20},
             {39, 21},
             {180, 22},
             {39, 23},
             {38, 24}
           ]
  end

  test "it should generate the pixel map coordinates using the grid" do
    image = %Identicon.Image{
      grid: [
        {9, 0},
        {143, 1},
        {107, 2},
        {143, 3},
        {9, 4},
        {205, 5},
        {70, 6},
        {33, 7},
        {70, 8},
        {205, 9},
        {211, 10},
        {115, 11},
        {202, 12},
        {115, 13},
        {211, 14},
        {222, 15},
        {78, 16},
        {131, 17},
        {78, 18},
        {222, 19},
        {38, 20},
        {39, 21},
        {180, 22},
        {39, 23},
        {38, 24}
      ]
    }

    %Identicon.Image{pixel_map: pixel_map} = Identicon.build_pixel_map(image)

    assert pixel_map == [
             {{0, 0}, {50, 50}},
             {{50, 0}, {100, 50}},
             {{100, 0}, {150, 50}},
             {{150, 0}, {200, 50}},
             {{200, 0}, {250, 50}},
             {{0, 50}, {50, 100}},
             {{50, 50}, {100, 100}},
             {{100, 50}, {150, 100}},
             {{150, 50}, {200, 100}},
             {{200, 50}, {250, 100}},
             {{0, 100}, {50, 150}},
             {{50, 100}, {100, 150}},
             {{100, 100}, {150, 150}},
             {{150, 100}, {200, 150}},
             {{200, 100}, {250, 150}},
             {{0, 150}, {50, 200}},
             {{50, 150}, {100, 200}},
             {{100, 150}, {150, 200}},
             {{150, 150}, {200, 200}},
             {{200, 150}, {250, 200}},
             {{0, 200}, {50, 250}},
             {{50, 200}, {100, 250}},
             {{100, 200}, {150, 250}},
             {{150, 200}, {200, 250}},
             {{200, 200}, {250, 250}}
           ]
  end
end
