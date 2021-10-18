//
//  GroupStorage.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 10.07.2021.
//

import Foundation

class GroupStorage{
    let group: [GroupModel]
    let allGroups: [GroupModel]
    
    init() {
        group = [
            GroupModel(
                nameGroup: "Anime",
                avatarGroup: "group_anime",
                logoImage: "Logo0",
                shortDescription: "Anime Channel",
                fullDescription: "Здесь вы найдете самые актуальные новости из мира японской анимации, анонсы грядущих новинок и хорошее настроение. Присоединяйтесь! Никакие конкурсы с оплатой доставки мы не проводим. О любых случаях мошенничества пишите в личные сообщения группы. Спасибо.",
                subscribersCount: 100),
            
            GroupModel(
                nameGroup: "Konoha",
                avatarGroup: "group_konoha",
                logoImage: "Logo1",
                shortDescription: "Больше, чем просто аниме",
                fullDescription: "Наруто, боруто и музыка.",
                subscribersCount: 100),
            
            GroupModel(
                nameGroup: "Baseball",
                avatarGroup: "group_baseBall",
                logoImage: "Logo2",
                shortDescription: "Since 2012 #жде́мкаждого",
                fullDescription: "Добро пожаловать в CALVARY! Не беда, если вы никогда не играли в бейсбол! Инструкции и инвентарь вы получите на месте! Всё покажем и расскажем! Ждём каждого! Наша цель - дружба и бейсбол!",
                subscribersCount: 100),
            
            GroupModel(
                nameGroup: "Tru detectiv",
                avatarGroup: "group_trueDetectiv",
                logoImage: "Logo3",
                shortDescription: "Фан-группа",
                fullDescription: "Настоящий детектив» (англ. True Detective) — американский телесериал в жанре криминальной драмы, транслируемый с 12 января 2014 года на кабельном канале HBO. Создатель и автор сценария — Ник Пиццолатто. Сериал выпускается в формате антологии — в каждом сезоне свой сюжет и действующие лица. Внимание❗☢ В постах сообщества встречается ненормативная лексика❗",
                subscribersCount: 100),
        ]
        allGroups = [
            GroupModel(
                nameGroup: "Anime",
                avatarGroup: "group_anime",
                logoImage: "Logo0",
                shortDescription: "Anime Channel",
                fullDescription: "Здесь вы найдете самые актуальные новости из мира японской анимации, анонсы грядущих новинок и хорошее настроение. Присоединяйтесь! Никакие конкурсы с оплатой доставки мы не проводим. О любых случаях мошенничества пишите в личные сообщения группы. Спасибо.",
                subscribersCount: 100),
            
            GroupModel(
                nameGroup: "Konoha",
                avatarGroup: "group_konoha",
                logoImage: "Logo1",
                shortDescription: "Больше, чем просто аниме",
                fullDescription: "Наруто, боруто и музыка.",
                subscribersCount: 100),
            
            GroupModel(
                nameGroup: "Akatsuki",
                avatarGroup: "group_akatsuku",
                logoImage: "Logo4",
                shortDescription: "Ищем пиарщика.",
                fullDescription: "Akatsuki Corporation - крупнейшая публичная страница во ВКонтакте по тематике Акацуки из манги Наруто! Подписывайся и присоединяйся к нашему уютному сообществу!",
                subscribersCount: 100),
            
            GroupModel(
                nameGroup: "Baseball",
                avatarGroup: "group_baseBall",
                logoImage: "Logo2",
                shortDescription: "Since 2012 #жде́мкаждого",
                fullDescription: "Добро пожаловать в CALVARY! Не беда, если вы никогда не играли в бейсбол! Инструкции и инвентарь вы получите на месте! Всё покажем и расскажем! Ждём каждого! Наша цель - дружба и бейсбол!",
                subscribersCount: 100),
            
            GroupModel(
                nameGroup: "Voleyball",
                avatarGroup: "group_volleyball",
                logoImage: "Logo5",
                shortDescription: "Фан-группа",
                fullDescription: "4 сезон аниме закончился. Про 5 сезон НЕТ никакой информации. Манга закончилась, последняя глава — 402.",
                subscribersCount: 100),
            
            GroupModel(
                nameGroup: "Shcool days",
                avatarGroup: "group_shcoolDays",
                logoImage: "Logo6",
                shortDescription: "Приглашаются учащиеся всех школ",
                fullDescription: "Каждо воскресенье в ночном клубе RIO - школьная дискотека. Начало в 15.00 Вход 10 грн. с флаером FREE flaer-агент тел:8(00000)45-111 с 10.00 до 17.00 пн-пт",
                subscribersCount: 100),
            
            GroupModel(
                nameGroup: "Tru detectiv",
                avatarGroup: "group_trueDetectiv",
                logoImage: "Logo3",
                shortDescription: "Фан-группа",
                fullDescription: "Настоящий детектив» (англ. True Detective) — американский телесериал в жанре криминальной драмы, транслируемый с 12 января 2014 года на кабельном канале HBO. Создатель и автор сценария — Ник Пиццолатто. Сериал выпускается в формате антологии — в каждом сезоне свой сюжет и действующие лица. Внимание❗☢ В постах сообщества встречается ненормативная лексика❗",
                subscribersCount: 100),
            
            GroupModel(
                nameGroup: "RKN",
                avatarGroup: "group_RKN",
                logoImage: "Logo7",
                shortDescription: "РКН во Вконтакте",
                fullDescription: "Официальный паблик Федеральной службы по надзору в сфере связи, информационных технологий и массовых коммуникаций.",
                subscribersCount: 2),
        ]
    }
}
