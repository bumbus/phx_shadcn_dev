defmodule Storybook.InputOtp do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.InputOTP.input_otp/1

  def imports do
    [
      {PhxShadcn.Components.InputOTP,
       input_otp_group: 1,
       input_otp_slot: 1,
       input_otp_separator: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "6-digit OTP with separator",
        attributes: %{id: "sb-otp-default", max_length: 6},
        slots: [
          """
          <.input_otp_group>
            <.input_otp_slot :for={i <- 0..2} index={i} />
          </.input_otp_group>
          <.input_otp_separator />
          <.input_otp_group>
            <.input_otp_slot :for={i <- 3..5} index={i} />
          </.input_otp_group>
          """
        ]
      },
      %Variation{
        id: :four_digits,
        description: "4-digit PIN",
        attributes: %{id: "sb-otp-pin", max_length: 4},
        slots: [
          """
          <.input_otp_group>
            <.input_otp_slot :for={i <- 0..3} index={i} />
          </.input_otp_group>
          """
        ]
      },
      %Variation{
        id: :alphanumeric,
        description: "Alphanumeric pattern",
        attributes: %{id: "sb-otp-alpha", max_length: 6, pattern: "alphanumeric"},
        slots: [
          """
          <.input_otp_group>
            <.input_otp_slot :for={i <- 0..5} index={i} />
          </.input_otp_group>
          """
        ]
      },
      %Variation{
        id: :disabled,
        description: "Disabled with pre-filled value",
        attributes: %{id: "sb-otp-disabled", max_length: 4, default_value: "1234", disabled: true},
        slots: [
          """
          <.input_otp_group>
            <.input_otp_slot :for={i <- 0..3} index={i} />
          </.input_otp_group>
          """
        ]
      }
    ]
  end
end
