shader_type spatial;

// Параметры для управления миганием
uniform float speed: hint_range(0.1, 10.0) = 2.0; // Скорость мигания
uniform vec4 base_color: source_color = vec4(1.0); // Базовый цвет (белый)

void fragment() {
    // Вычисляем мигание с помощью синусоидальной функции
    float blink = sin(TIME * speed) * 0.5 + 0.5; // Преобразуем синус в диапазон [0, 1]
    
    // Применяем мигание к базовому цвету
    ALBEDO = base_color.rgb * blink;
}