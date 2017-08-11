
local font = {
	width = 11,
	height = 14,
	characters = {
["0"]="0000000000000000000111100000001111111111000110000000011001000000000010010000000000100100000000001001100000000110001111111111000000011110000000000000000000",
["1"]="0000000000000000000000000000001000000000100010000000001001100000000010011111111111100111111111111000000000000010000000000000100000000000001000000000000000",
["2"]="0000000000000000000000000000001000000000100110000000011001000000001110010000000110100100000011001001100001100010001111110000100001111000001000000000000000",
["3"]="0000000000000000000000000000000000000001000010000000010001100000000110010000100000100100001000001001100101000110001111010001000011100011110000000000000000",
["4"]="0000000000000000000000110000000000111100000000011001000000001100010000001100000100000110000001000001111111111110000000000100000000000001000000000000000000",
["5"]="0000000000000000000000000000011111100001000111010000010001000100000010010001000000100100010000001001000100000110010001100011000100001111110000000000000000",
["6"]="0000000000000000000011100000000111111110000011000100010001100010000010010000100000100100001000001001000011000110001000011111000000000011000000000000000000",
["7"]="0000000000000001000000000000010000000000000100000000000001000000011110010000111111100100111000000001011000000000011000000000000100000000000000000000000000",
["8"]="0000000000000000000000011000001111011111000110011100011001000010000010010000100000100100001000001001100111000110001111011111000000000001100000000000000000",
["9"]="0000000000000000000000000000000111000000000011111000011001100001000010010000010000100100000100001001100001000110001100100011000001111111100000000000000000",
[" "] = true,
["A"]="0000000000000000000000001110000000011111000000111110000001111000100000011000001000000011110010000000000111100000000000001111100000000000011000000000000000",
["B"]="0000000000000000000000000000011111111111100100001000001001000010000010010000100000100100001000001001100101000110001111011111000000000011100000000000000000",
["C"]="0000000000000000000111100000000111111110000011000000110001100000000110010000000000100100000000001001100000000010001000000001000010000000010000000000000000",
["D"]="0000000000000000000000000000011111111111100100000000001001000000000010010000000000100110000000011000110000001100001111111110000000111111000000000000000000",
["E"]="0000000000000000000000000000011111111111100111111111111001000010000010010000100000100100001000001001000010000010010000000000100000000000001000000000000000",
["F"]="0000000000000000000000000000011111111111100111111111111001000010000000010000100000000100001000000001000010000000010000100000000100000000000000000000000000",
["G"]="0000000000000000001111110000000111111111000011000000110001100000000110010000000000100100000100001001100001000110001000011111000000000111110000000000000000",
["H"]="0000000000000000000000000000011111111111100111111111111000000010000000000000100000000000001000000000000010000000000000100000000111111111111000000000000000",
["I"]="0000000000000000000000000000000000000000000100000000001001000000000010010000000000100111111111111001000000000010010000000000100100000000001000000000000000",
["J"]="0000000000000000000000000000010000000011000100000000011001000000000010010000000000100100000000011001111111111100011111111110000000000000000000000000000000",
["K"]="0000000000000000000000000000011111111111100000000110000000000011000000000011100000000001101110000000110000111000011000000011100100000000011000000000000000",
["L"]="0000000000000000000000000000011111111111100111111111111000000000000010000000000000100000000000001000000000000010000000000000100000000000001000000000000000",
["M"]="0000000000000001111111111110011111111111100011110000000000000111100000000000001100000000011100000001111000000000011111111111100111111111111000000000000000",
["N"]="0000000000000000000000000000011111111111100011100000000000001110000000000000111000000000000011100000000000001110011111111111100000000000000000000000000000",
["O"]="0000000000000000001111110000001111001111000110000000011001000000000010010000000000100110000000011000100000000100001111111111000000111111000000000000000000",
["P"]="0000000000000000000000000000011111111111100100000100000001000001000000010000010000000100000100000001100011000000001111100000000001110000000000000000000000",
["Q"]="0000000000000000001111110000001111001111000110000000011001000000000010010000001000100110000001011000100000001100001111111111000000111111001000000000000000",
["R"]="0000000000000000000000000000011111111111100100000100000001000001000000010000010000000100000111000001100011011100001111100001100001100000001000000000000000",
["S"]="0000000000000000000000000100001111000001000110011000011001000010000010010000110000100100001100001001100001100110001000011111000000000001100000000000000000",
["T"]="0000000000000001000000000000010000000000000100000000000001000000000000011111111111100100000000000001000000000000010000000000000100000000000000000000000000",
["U"]="0000000000000000000000000000011111111100000111111111110000000000000110000000000000100000000000001000000000000110000000000011100111111111110000000000000000",
["V"]="0000000000000001100000000000001111100000000000011111000000000000111110000000000001100000000011110000001111100000011111000000000110000000000000000000000000",
["W"]="0110000000000001111111110000000000111111100000000001111000000111110000000011000000000000011111100000000000011110000000111111100111111110000001000000000000",
["X"]="0000000000000001000000000010011000000011100011100001100000001111100000000000110000000000111111000000111000011100011000000001100000000000001000000000000000",
["Y"]="0000000000000001100000000000011110000000000001111000000000000011000000000000011111100000011100000000011100000000011100000000000100000000000000000000000000",
["Z"]="0000000000000000000000000010010000000011100100000001101001000001110010010000110000100100111000001001011000000010011100000000100100000000001000000000000000",
[">"]="0000000000000000110000001100000100000010000000100001000000001000010000000001001000000000010010000000000011000000000000110000000000000000000000000000000000",
["<"]="0000000000000000000011000000000000110000000000010010000000000100100000000010000100000000100001000000010000001000001100000011000000000000000000000000000000",
["["]="0000000000000000000000000000000000000000000111111111111001000000000010010000000000100100000000001000000000000000000000000000000000000000000000000000000000",
["]"]="0000000000000000000000000000000000000000000000000000000001000000000010010000000000100100000000001001111111111110000000000000000000000000000000000000000000",
["("]="0000000000000000000000000000000000000000000000111111000000111000011100011000000001100100000000001000000000000000000000000000000000000000000000000000000000",
[")"]="0000000000000000000000000000000000000000000000000000000001000000000010011000000001100011100001110000001111110000000000000000000000000000000000000000000000",
[""]="0000000000000000000001000000000000101000000011111011110001000000000010010000000000100100000000001000000000000000000000000000000000000000000000000000000000",
["}"]="0000000000000000000000000000000000000000000000000000000001000000000010010000000000100100000000001000111110111100000000101000000000000100000000000000000000",
["/"]="0000000000000000000000000110000000000011000000000001100000000001110000000000110000000000111000000000011000000000001100000000000110000000000000000000000000",
["\\"]="0000000000000001100000000000001100000000000001100000000000001110000000000000110000000000000111000000000000011000000000000011000000000000011000000000000000",
["|"]="0000000000000000000000000000000000000000000000000000000000000000000000011111111111100000000000000000000000000000000000000000000000000000000000000000000000",
["@"]="0000000000000000011111111000001000000001000100011100001001001000100010010010001000100100100010001000100111000100000111111000000000000000000000000000000000",
["#"]="0000000000000000001000010000000010000100000011111111110000001000010000000010000100000000100001000000111111111100000010000100000000100001000000000000000000",
["?"]="0000000000000000000000000000001000000000000100000000000001000000000000010000001100100100000110000000111111000000000010000000000000000000000000000000000000",
["!"]="0000000000000000000000000000000000000000000000000000000000000000000000011111111100100000000000000000000000000000000000000000000000000000000000000000000000",
["+"]="0000000000000000000000000000000000010000000000000100000000000001000000000111111111000000000100000000000001000000000000010000000000000000000000000000000000",
["-"]="0000000000000000000000000000000000010000000000000100000000000001000000000000010000000000000100000000000001000000000000010000000000000000000000000000000000",
["*"]="0000000000000000000000000000000000010000000001100100110000001101011000000001111100000000110101100000011001001100000000010000000000000000000000000000000000",
["\""]="0000000000000000000000000000000000000000000011100000000000111111000000000000000000000000000000000000100000000000001111110000000000000000000000000000000000",
["\'"]="0000000000000000000000000000000000000000000000000000000000111000000000001111110000000000000000000000000000000000000000000000000000000000000000000000000000",
[";"]="0000000000000000000000000000000000000000000000000000000000001000100110000111011011000000100011100000000000000000000000000000000000000000000000000000000000",
[":"]="0000000000000000000000000000000000000000000000000000000000001000001000000111000111000000100000100000000000000000000000000000000000000000000000000000000000",
["_"]="0000000000000000000000000010000000000000100000000000001000000000000010000000000000100000000000001000000000000010000000000000100000000000001000000000000000",
["."]="0000000000000000000000000000000000000011000000000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
[","]="0000000000000000000000000000000000000010000000000000111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
["$"]="0000000000000000000000000000000111000010000010001000010000100010000100011100100011100010000100010000100001000100000100001110000000000000000000000000000000",
["%"]="0000000000000000110000001100001100000110000000000011000000000001100000000000110000000000011000000000001100000000000110000011000011000000110000000000000000",
["&"]="0000000000000000000000011100000111001000100010001100001001000010000010010000100000100100001000001000111101111100000000000100100000000011001000000000000000",
["="]="0000000000000000000000000000000001001000000000010010000000000100100000000001001000000000010010000000000100100000000000000000000000000000000000000000000000",
["~"]="0000000000000000000011000000000000100000000000001000000000000001000000000000010000000000000010000000000000100000000000110000000000000000000000000000000000",
["^"]="0000000000000000000000000000000000000000000000110000000000011000000000001000000000000001100000000000001100000000000000000000000000000000000000000000000000",
	},
}

--function font:supportedCharacters(luaPlayer, playerInput)
--	return supportedPlayerInput
--end
return font
