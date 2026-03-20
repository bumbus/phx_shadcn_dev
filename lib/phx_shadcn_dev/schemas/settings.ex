defmodule PhxShadcnDev.Schemas.Settings do
  @moduledoc """
  Embedded schema for the form showcase page.

  Demonstrates validation with text inputs, switches, toggles, and toggle groups
  in a single form — including a nested embed via `inputs_for`.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:username, :string, default: "")
    field(:email, :string, default: "")
    field(:bio, :string, default: "")
    field(:notifications, :boolean, default: false)
    field(:bold, :boolean, default: false)
    field(:alignment, :string, default: "left")
    field(:font_size, :string)
    field(:theme, :string)
    field(:terms, :boolean)
    field(:language, :string)
    field(:framework, :string)
    field(:volume, :integer, default: 50)
    field(:price_range, {:array, :integer}, default: [20, 80])
    field(:otp, :string)

    embeds_one :profile, Profile, primary_key: false do
      field(:display_name, :string, default: "")
      field(:public, :boolean, default: false)
      field(:contact_method, :string)
    end
  end

  def changeset(settings, params) do
    settings
    |> cast(params, [:username, :email, :bio, :notifications, :bold, :alignment, :font_size, :theme, :terms, :language, :framework, :volume, :price_range, :otp])
    |> cast_embed(:profile, with: &profile_changeset/2)
    |> validate_required([:username, :email, :font_size, :theme, :terms, :language, :otp])
    |> validate_acceptance(:terms)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:username, min: 2, max: 20)
    |> validate_length(:bio, max: 160)
    |> validate_length(:otp, is: 6, message: "must be exactly 6 digits")
  end

  defp profile_changeset(profile, params) do
    profile
    |> cast(params, [:display_name, :public, :contact_method])
    |> validate_required([:display_name, :contact_method])
  end
end
