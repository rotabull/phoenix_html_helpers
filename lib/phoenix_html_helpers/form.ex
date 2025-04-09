defmodule PhoenixHTMLHelpers.Form do
  @moduledoc ~S"""
  Functions for generating forms and inputs HTML.
  """

  alias Phoenix.HTML.Form
  import Phoenix.HTML
  import Phoenix.HTML.Form
  import PhoenixHTMLHelpers.Tag

  @doc """
  Generates hidden inputs for the given form inputs.

  See `inputs_for/2` and `inputs_for/3`.
  """
  @spec hidden_inputs_for(Form.t()) :: list(Phoenix.HTML.safe())
  def hidden_inputs_for(form) do
    Enum.flat_map(form.hidden, fn {k, v} ->
      hidden_inputs_for(form, k, v)
    end)
  end

  defp hidden_inputs_for(form, k, values) when is_list(values) do
    id = input_id(form, k)
    name = input_name(form, k)

    for {v, index} <- Enum.with_index(values) do
      hidden_input(form, k,
        id: id <> "_" <> Integer.to_string(index),
        name: name <> "[]",
        value: v
      )
    end
  end

  defp hidden_inputs_for(form, k, v) do
    [hidden_input(form, k, value: v)]
  end
end
