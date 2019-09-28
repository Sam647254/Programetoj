defmodule Deseret do
	def iĝi_en_ŝavan(kodopunktoj) do
		literoj = %{
			?𐐹 => ?𐑐,
			?𐐺 => ?𐑚,
			?𐐻 => ?𐑑,
			?𐐼 => ?𐑛,
			?𐐿 => ?𐑒,
			?𐑀 => ?𐑜,
			?𐑁 => ?𐑓,
			?𐑂 => ?𐑝,
			?𐑃 => ?𐑔,
			?𐑄 => ?𐑞,
			?𐑅 => ?𐑕,
			?𐑆 => ?𐑟,
			?𐑇 => ?𐑖,
			?𐑈 => ?𐑠,
			?𐐽 => ?𐑗,
			?𐐾 => ?𐑡,
			?𐐷 => ?𐑘,
			?𐐶 => ?𐑢,
			?𐑍 => ?𐑙,
			?𐐸 => ?𐑣,
			?𐑊 => ?𐑤,
			?𐑉 => ?𐑮,
			?𐑋 => ?𐑥,
			?𐑌 => ?𐑯,
			?𐐮 => ?𐑦,
			?𐐨 => ?𐑰,
			?𐐯 => ?𐑧,
			?𐐩 => ?𐑱,
			?𐐰 => ?𐑨,
			?𐐴 => ?𐑲,
			?𐐲 => ?𐑳,
			?𐐱 => ?𐑪,
			?𐐬 => ?𐑴,
			?𐐳 => ?𐑫,
			?𐐭 => ?𐑵,
			?𐐵 => ?𐑬,
			?𐐫 => ?𐑷,
			?𐑏 => ?𐑿,
			?𐑎 => ?𐑶,
			?𐐪 => ?𐑭,
			?~ => ?·,
		}

		digrafoj = %{
			"𐐨𐑉" => ?𐑽,
			"𐐨𐐲" => ?𐑾,
			"𐐪𐑉" => ?𐑸,
			"𐐫𐑉" => ?𐑹,
			"𐐯𐑉" => ?𐑺,
			"𐐲𐑉" => ?𐑻,
		}

		malgranda_kodopuktoj = kodopunktoj |> Enum.map(
			fn k -> <<kp1::utf8>> = k; if kp1 in ?𐐀..?𐐧, do: kp1 + 40, else: kp1 end
		)
		kodopunktoj2 = Enum.drop(malgranda_kodopuktoj, 1)

		{rezulto, _ } = Enum.zip(malgranda_kodopuktoj, kodopunktoj2) |> Enum.map_reduce(
			%{saŭto: false},
			fn {k1, k2}, %{saŭto: saŭto} ->
				digrafo = List.to_string [k1, k2]
				cond do
					saŭto -> {0, %{saŭto: false}}
					Map.has_key?(digrafoj, digrafo) -> {digrafoj[digrafo], %{saŭto: true}}
					k1 == ?@ -> {?𐑩, %{saŭto: true}}
					Map.has_key?(literoj, k1) -> {literoj[k1], %{saŭto: false}}
					true -> {k1, %{saŭto: false}}
				end
			end
		)
		rezulto |> Enum.filter(fn k -> k != 0 end) |> List.to_string
	end

	def iĝi_en_deseretan(kodopunktoj) do
		traktakarakteroj = MapSet.new([?@, ?~])
		kodopunktoj
			|> Enum.filter(fn k -> <<kp1::utf8>> = k; !MapSet.member?(traktakarakteroj, kp1) end)
			|> List.to_string
	end
end

[eniro_dosiero, eliro_dosiero] = System.argv()

case File.read(eniro_dosiero) do
	{:ok, enhavo} ->
		File.write(
			"#{eliro_dosiero}.ŝava",
			Deseret.iĝi_en_ŝavan(enhavo |> String.codepoints)
		)

		# Desereta eliro
		File.write(
			"#{eliro_dosiero}.desereta",
			Deseret.iĝi_en_deseretan(enhavo |> String.codepoints)
		)
	{:error, eraro} -> IO.puts(eraro)
end