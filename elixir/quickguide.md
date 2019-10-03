# Guia Rápido Elixir

## Introdução
* Primeiro, tudo é feito em módulos:
	`defmodule modulename do ... end`
* Dentro dos módulos existem as funções:
	`def functionname do ... end`

## Tipos de dados
* integer: `123`
	divisão inteira:
		`div(a, b)`
		`rem(a, b)`

* float: `1.23`

* atom: `:abc`
	sua definição é o texto de seu nome

* string: `"list of chars"`
	pode ser concatenada com `"oi " <> "amigo"`

* funções: 
	`func = fn (a,b) -> a + b end`

## Funções
* definição:
	`func = fn (a,b) -> a + b end`
	`funce = &(&1 + &2)`
	`func.(1,1) == funce.(1,1) == 1+1`
* truque da tupla:
```
	supersoma = fn
		{x, y} -> x + y
		{x, y, z} -> x + y + z
	end

	supersoma.({1,2}) == supersoma.({1,1,1})
```
* recursão:
```
	def func([head|tail]) do
		IO.puts head
		func(tail)
	end
	def func([]), do: nil
```
* entrada padrão:
```
	def func(x \\ 1, y \\ 1) do
		x + y
	end
```
* for recursivo:
```
	def loop(0, _), do: nil
	def loop(fim, inicio) do
		if fim < inicio do
			loop(0, inicio)
		else
			IO.puts fim
			loop(fim-1, inicio)
		end
	end
```
* threads:
```
	spawn(fn()-> loop(10,0) end)
	spawn(fn()-> loop(20,0) end)
```
* mensagens:
envio:
	`send(self(), {:ok, "sucesso"})`
recepção:
```
	receive do
		{:ok, "sucesso"} -> IO.puts "Operação feita com sucesso"
		{:notok, "falha"} -> IO.puts "Operação não bem sucedida"
	after
		500 -> IO.puts "TIMEOUT"
	end
```

## Condicionais
* if:
	`if condition do ... else ... end`
* unless:
	`unless condition do ... else ... end`
* cond:
	```
		cond do
			a < 10 -> IO.puts "menor que 10"
			a < 12 -> IO.puts "entre 12 e 10"
			a < 14 -> IO.puts "entre 14 e 12"
			true   -> IO.puts "default case"
	```
* case:
	```
		case a do
			1 -> IO.puts "a igual a 1"
			2 -> IO.puts "a igual a 2"
			3 -> IO.puts "a igual a 3"
			_   -> IO.puts "default case"
	```
* ternario:
	`if a > 10, do: "maior que 10", else: "menor/igual a 10"`
* comprehension:
```
	list = for n <- [1,2,3], do: n*2
```
* exceptions:
```
	err = try do
		5/0
	rescue
		ArythmeticError -> "DIVISAO POR ZERO"
	end

	IO.puts err
```

## Estruturas
### Tuplas
* definição:
	`tupla = {1, 2.3, :abc}`
* adição:
	`tupla2 = Tuple.append(tupla, 22)`
* deleção:
	`tupla3 = Tuple.delete_at(tupla, 0)`
* inserção indexada:
	`tupla4 = Tuple.insert_at(tupla, 0, 22)`
* pegar indexado:
	`elem(tupla, 1)`
* largura:
	`tuple_size(tuple)`
* criação repetida:
	`Tuple.duplicate("a", 5)`
* MATCH!
	```
		{a, b, c} = {1, "texto", 1.23}
		IO.puts "a: #{a}, b: #{b}, c: #{c}"
	```

### Listas
* definição:
	`list1 = [1, 2, 3]`
	`list2 = [4, 5, 6]`
* concatenação:
	`list3 = list1 ++ list2`
* remoção (conjunto):
	`list4 = list3 -- list1`
* existe?:
	`2 in list1`
* separação:
	`[head|tail] = list3`
* string é lista:
	`IO.inspect [97,98]`

### Maps
* definição:
	`meumapString = %{"a" => "b", "c" => "d"}`
	`meumapAtom = %{a: "b", c: "d"}`
* adição:
	`meumap2 = Dict.put_new(meumapAtom, e:, "f")`

## Módulos importantes:
### IO
* input do usuário:
	`inputString = IO.gets("Mensagem anterior: ")`
* output ao usuário:
	`IO.puts "Hello #{inputString}"`

### Enum
* passa por todos:
```
	list = [1,2,3]
	Enum.each list, fn item ->
		IO.puts item
	end
```
* verifica se vale regra para todos ou algum:
	`Enum.all?([2,4,6,7], fn n -> rem(n,2) == 0 end)`
	`Enum.any?([2,4,6,7], fn n -> rem(n,2) == 0 end)`
* passa por todos criando uma nova lista:
	`Enum.map([1,2,3], fn n -> rem(n,2) end)`
* passa por todos acumulando no acc:
	`Enum.reduce([1,2,3], fn (n, acc) -> n+acc end)`
* passa por todos, cria uma lista com o que passar na função:
	`Enum.filter([1,2,3], fn n -> rem(n,2) == 1 end)`
* tira as duplicatas:
	`Enum.uniq([1,2,3,2,1,2,3,5])`

### String
* largura da string:
		`String.length("abc")`
* se existe substr:
		`String.contains?("abcd", "c")`
* primeiro char:
		`String.first("abcd")`
* acesso indexado:
		`String.at("abcd", 2)`
* pegar substr:
		`String.slice("abcd", 1, 2)`
* cortar string em pedaços:
		`String.split("ab cd", " ")`
* inverter:
		`String.reverse("abcd")`
* tudo maiúsculo:
		`String.upcase("abcd")`
* tudo minúsculo:
		`String.downcase("aBCd")`
* primeira letra maiúscula:
		`String.capitalize("oia migos, tudo bem? hoje ...")`
	
