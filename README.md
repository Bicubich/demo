```markdown
# Тестовое задание — Экран создания заказа (Flutter)

## Описание

Реализован экран создания заказа для мобильного приложения на Flutter с использованием REST API.

Приложение отправляет POST-запрос на:

```

/api/orders

```

Тело запроса:

- `userId` (int)
- `serviceId` (int)

При успешном ответе сервер возвращает:

- `order_id` (int)
- `status` (string)
- `payment_url` (string или null)

При ошибке сервер возвращает сообщение об ошибке.


## Реализованный функционал

### 1. Модель Order

- Неизменяемая модель
- Factory-конструктор `fromJson`
- Поддержка nullable `paymentUrl`


### 2. ApiException

- Кастомное исключение
- Содержит текст ошибки
- Поддерживает optional `statusCode`


### 3. Сетевой слой

`ApiClient`:

- Использует `async/await`
- Timeout 10 секунд
- Обрабатывает:
  - статус 200
  - статус 400+
  - отсутствие интернета (SocketException)
  - TimeoutException
- При ошибке выбрасывает `ApiException`


### 4. OrderRepository

- Инкапсулирует работу с API
- Возвращает `Order`
- Не содержит UI-логики


### 5. OrderController

Состояния:

- `initial`
- `loading`
- `success`
- `error`

Метод `submitOrder`:

- Устанавливает `loading` перед запросом
- При успехе устанавливает `success`
- При ошибке устанавливает `error`
- Сохраняет текст ошибки
- Использует `ChangeNotifier`


### 6. UI

Экран содержит:

- Кнопку «Создать заказ»
- Индикатор загрузки во время выполнения запроса
- Отображение ошибки
- Отображение успешного создания заказа
- Блокировку кнопки во время запроса
- Возможность повторной попытки после ошибки


## Структура проекта

```

lib/
├─ main.dart
├─ core/
│   ├─ error/
│   │    └─ api_exception.dart
│   └─ network/
│        └─ api_client.dart
├─ features/
│   └─ order/
│        ├─ data/
│        │    └─ order_repository.dart
│        ├─ models/
│        │    └─ order.dart
│        ├─ controller/
│        │    └─ order_controller.dart
│        └─ ui/
│             └─ order_screen.dart

````


## Зависимости

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0
  provider: ^6.1.2
````


## Запуск проекта

1. Выполнить:

```
flutter pub get
```

2. Указать актуальный `baseUrl` в `main.dart`

3. Запустить:

```
flutter run
```


## Дополнительно

* Архитектура разделена по слоям
* Логика отделена от UI
* Обработка сетевых ошибок реализована корректно
* Код готов к расширению и тестированию

```
```
