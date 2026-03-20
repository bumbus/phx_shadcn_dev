defmodule PhxShadcnDevWeb.Components.Showcase.ShowcaseCode do
  @moduledoc """
  Compile-time extraction and syntax highlighting of HEEx source from
  `example_*` functions.

  ## Usage

      use PhxShadcnDevWeb.Components.Showcase.ShowcaseCode

      defp example_basic(assigns) do
        ~H\"\"\"
        <.popover id="basic-pop">
          ...
        </.popover>
        \"\"\"
      end

  Then in `render/1`:

      <.demo_section title="Basic" code={showcase_source(:example_basic)}>
        {example_basic(assigns)}
      </.demo_section>

  The macro reads the source file at compile time, extracts the HEEx body
  of each `defp example_*(assigns)` function, highlights it with Makeup,
  and generates a `showcase_source/1` function that returns
  `%{raw: raw_string, html: highlighted_html}`.
  """

  defmacro __using__(_opts) do
    quote do
      @before_compile PhxShadcnDevWeb.Components.Showcase.ShowcaseCode
    end
  end

  defmacro __before_compile__(env) do
    source = File.read!(env.file)
    examples = extract_examples(source)

    clauses =
      for {name, raw, html} <- examples do
        quote do
          def showcase_source(unquote(name)),
            do: %{raw: unquote(raw), html: unquote(html)}
        end
      end

    fallback =
      quote do
        def showcase_source(_name), do: nil
      end

    clauses ++ [fallback]
  end

  @doc false
  def extract_examples(source) do
    regex =
      ~r/defp\s+(example_\w+)\(assigns\)\s+do\s*\n\s*~H"""\n(.*?)"""/s

    Regex.scan(regex, source)
    |> Enum.map(fn [_full, name, body] ->
      raw = dedent(body)
      html = highlight(raw)
      {String.to_atom(name), raw, html}
    end)
  end

  defp highlight(code) do
    # Ensure makeup_html is started so HEExLexer can find the HTML lexer at compile time
    Application.ensure_all_started(:makeup_html)

    code
    |> Makeup.highlight_inner_html(lexer: Makeup.Lexers.HEExLexer)
  end

  defp dedent(text) do
    lines = String.split(text, "\n")

    min_indent =
      lines
      |> Enum.reject(&(String.trim(&1) == ""))
      |> Enum.map(fn line ->
        String.length(line) - String.length(String.trim_leading(line))
      end)
      |> Enum.min(fn -> 0 end)

    lines
    |> Enum.map(fn line ->
      if String.trim(line) == "" do
        ""
      else
        String.slice(line, min_indent..-1//1)
      end
    end)
    |> Enum.join("\n")
    |> String.trim()
  end
end
