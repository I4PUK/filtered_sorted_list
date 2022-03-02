# Тестовое задание 
Сделать приложение на Flutter. Использовать https://pub.dev/packages/flutter_bloc паттерн.

Один экран при его открытии забирает данные из фейк апи, можно написать класс с методом который будет возвращать данные с небольшим делаем данные: массив из 2-3 элементов заголовком и текстом на экране отрисовываются блоки с полученными заголовками. Над блоками поле ввода, фильтрующее список по заголовку. При нажатии на заголовок, раскрывается блок и пользователь видит текст и кнопку “подробнее”. При нажатии на другой заголовок, остальные открытые блоки сворачиваются. При повторном нажатии на открытый блок, он сворачивается. При нажатии на “подробнее” открывается экран с выбранным заголовком и текстом.
Интерфейс самый простой

## Технологии 
В проекте использовались технологии:
  - Dart/Flutter
  - API: https://about.google/static/
  - Для запросов к API: http
  - State manager: Bloc
