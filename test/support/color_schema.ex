defmodule ColorSchema do
  use Absinthe.Schema
  alias Absinthe.Type

  @names %{
    r: "RED",
    g: "GREEN",
    b: "BLUE",
    p: "PUCE"
  }

  @values %{
    r: 100,
    g: 200,
    b: 300,
    p: -100
  }

  def query do
    %Type.Object{
      fields: fields(
        info: [
          type: :channel_info,
          args: args(
            channel: [type: non_null(:channel)],
          ),
          resolve: fn
            %{channel: channel}, _ ->
              {:ok, %{name: @names[channel], value: @values[channel]}}
          end
        ]
      )
    }
  end

  @absinthe :type
  def channel do
    %Type.Enum{
      description: "A color channel",
      values: values([
        red: [description: "The color red", value: :r],
        green: [description: "The color green", value: :g],
        blue: [description: "The color blue", value: :b],
        puce: deprecate([description: "The color puce", value: :p], reason: "it's ugly")
      ])
    }
  end

  @absinthe :type
  def channel_info do
    %Type.Object{
      fields: fields(
        name: [type: :string],
        value: [type: :integer]
      )
    }
  end

end