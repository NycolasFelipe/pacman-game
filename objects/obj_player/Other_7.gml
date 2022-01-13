/// @desc restaura o alfa da imagem

//Quando o player sair do outro lado do túnel, restaura
//o alfa da imagem aos poucos
if (has_control and image_alpha != 1) {
	image_alpha = lerp(image_alpha, 1, 0.5)
}