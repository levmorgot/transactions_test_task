# transactions_test_task

Тестовое задание (транзакции)

Необходимо создать приложение на Flutter в котором будет
реализован список транзакци .
Должна быть возможность просмотра "детале транзацкии".

Сцены:
При открытии приложения появляется страница авторизации(Логин
Пароль). 

При успешно авторизации открывается главная страница с
двумя вкладками:1
список с транзакциями, 2 диаграмма(Donut) которая разделяет
транзакции по их типу операции. 

У каждо транзакции в списке видны
данные:
1. Тип транзакции(перевод, пополнение, снятие)
2. Номер транзакции
3. Сумма транзакции


   При выборе транзакции появляется список с деталями данно
   транзакции:
1. Дата транзакции
2. Сумма
3. Комиссия
4. Итого
5. Номер транзакции
6. Тип операции(пополнение, перевод, снятие)
7. Кнопка отмены транзакции. При отмене транзакции она должна
   исчезать из списка транзакций.

Должна быть возможность вернуться назад к списку транзакци.
В списке транзакци должно отображаться общее количество
транзакци. 

Использование Redux для StateManagement будет плюсом (не пошло дело, не успел)

Хранения данных можно выбрать по своему усмотрению (XML,
SQLLite, firebase, прочее). Возможен вариант реализации без
хранения данных.
