﻿
///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"КликНаКартинку(Парам01)","КликНаКартинку","Затем клик на картинку ""ИмяКартинки""","Делает клик на картинке. Картинка ищется в каталоге проекта.","Прочее.SikuliX");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//Затем клик на картинку "Тестовый Элемент 2"
//@КликНаКартинку(Парам01)
Процедура КликНаКартинку(ИмяФайла) Экспорт
	Путь = Ванесса.Объект.КаталогПроекта;
	Если НЕ ЗначениеЗаполнено(Путь) Тогда
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Не указано значение настройки Vanessa-automation: <КаталогПроекта>.");
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
	
	СписокКаталогов = Новый СписокЗначений;
	СписокФайлов    = Новый СписокЗначений;
	Ванесса.НайтиФайлыКомандаСистемы(Путь, СписокКаталогов, СписокФайлов, Истина,ИмяФайла + ".png");
	Если СписокФайлов.Количество() = 0 Тогда
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("В каталоге <%1> не найден файл <%2>.");
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Путь);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",ИмяФайла);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
	
	Если СписокФайлов.Количество() > 1 Тогда
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("В каталоге <%1> найдено больше одного файла <%2>: %3.");
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Путь);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%2",ИмяФайла);
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%3",СписокФайлов.Количество());
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
	
	Файл = СписокФайлов[0].Значение;
	ПутьКФайлу = СтрЗаменить(Файл.ПолноеИмя,"\","/");
	
	Рез = Ванесса.ВыполнитьSikuliСкрипт(Ванесса.Объект.КаталогИнструментов + "\tools\Sikuli\ClickOnPicture.sikuli --args """ + ПутьКФайлу + """" , -1, Истина);
	Если Рез <> 0 Тогда
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Не получилось сделать клик мышкой по картинке <%1>.");
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",ИмяФайла);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
	
КонецПроцедуры
