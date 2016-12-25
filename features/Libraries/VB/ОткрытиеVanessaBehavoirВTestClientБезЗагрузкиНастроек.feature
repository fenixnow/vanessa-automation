﻿# language: ru

@IgnoreOnCIMainBuild
@ExportScenarios

Функционал: Открытие Vanessa-Behavoir без загрузки сохраненных настроек
	Как Разработчик
	Я Хочу чтобы чтобы у меня была возможность открыть Vanessa-Behavior в TestClient без загрузки сохраненных настроек
	Чтобы я мог использовать этот сеанс для записи инструкций
 

Сценарий: Я открываю Vanessa-Behavior в TestClient без загрузки сохраненных настроек
	Дано Я открыл новый сеанс TestClient или подключил уже существующий без загрузки настроек
	И    Я закрыл все окна клиентского приложения
	И    Я открываю VanessaBehavior в режиме TestClient
	И     В открытой форме я перехожу к закладке "Сервис"
	И     В открытой форме я изменяю флаг "Проверка работы Vanessa-Behavior в режиме test client"
	И     В открытой форме я перехожу к закладке "Запуск сценариев"

