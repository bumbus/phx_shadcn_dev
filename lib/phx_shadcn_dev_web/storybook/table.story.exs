defmodule Storybook.Table do
  use PhoenixStorybook.Story, :component

  def function, do: &PhxShadcn.Components.Table.table/1

  def imports do
    [
      {PhxShadcn.Components.Table,
       table_header: 1,
       table_body: 1,
       table_footer: 1,
       table_row: 1,
       table_head: 1,
       table_cell: 1,
       table_caption: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        description: "Invoice table",
        slots: [
          """
          <.table_caption>A list of your recent invoices.</.table_caption>
          <.table_header>
            <.table_row>
              <.table_head>Invoice</.table_head>
              <.table_head>Status</.table_head>
              <.table_head>Method</.table_head>
              <.table_head class={["text-right"]}>Amount</.table_head>
            </.table_row>
          </.table_header>
          <.table_body>
            <.table_row>
              <.table_cell class={["font-medium"]}>INV001</.table_cell>
              <.table_cell>Paid</.table_cell>
              <.table_cell>Credit Card</.table_cell>
              <.table_cell class={["text-right"]}>$250.00</.table_cell>
            </.table_row>
            <.table_row>
              <.table_cell class={["font-medium"]}>INV002</.table_cell>
              <.table_cell>Pending</.table_cell>
              <.table_cell>PayPal</.table_cell>
              <.table_cell class={["text-right"]}>$150.00</.table_cell>
            </.table_row>
            <.table_row>
              <.table_cell class={["font-medium"]}>INV003</.table_cell>
              <.table_cell>Unpaid</.table_cell>
              <.table_cell>Bank Transfer</.table_cell>
              <.table_cell class={["text-right"]}>$350.00</.table_cell>
            </.table_row>
          </.table_body>
          <.table_footer>
            <.table_row>
              <.table_cell colspan="3">Total</.table_cell>
              <.table_cell class={["text-right"]}>$750.00</.table_cell>
            </.table_row>
          </.table_footer>
          """
        ]
      }
    ]
  end
end
