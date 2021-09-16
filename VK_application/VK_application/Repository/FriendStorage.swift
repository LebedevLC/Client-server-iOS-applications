//
//  FriendStorage.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 10.07.2021.
//

import Foundation

class FriendStorage {
    
    var friend: [FriendModel]
    var allFriends: [FriendModel]

    init() {
        friend = [
            FriendModel(name: "Uchiha Sasuke", avatarName: "Sasuke0", city: "Коноха",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "Konoha",
                                avatarGroup: "group_konoha",
                                logoImage: "Logo1",
                                shortDescription: "Больше, чем просто аниме",
                                fullDescription: "Наруто, боруто и музыка.",
                                subscribersCount: 100),
                        ],
                        photo: [
                            PhotoModel(name: "", fileName: "Sasuke1", likeCount: 1, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke2", likeCount: 2, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke3", likeCount: 3, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke4", likeCount: 4, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke5", likeCount: 5, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke6", likeCount: 6, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke7", likeCount: 7, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke8", likeCount: 8, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke9", likeCount: 9, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke10", likeCount: 10, isLike: false),
                        ]
            ),
            
            FriendModel(name: "See Hinata", avatarName: "Hinata0", city: "Токио",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "Voleyball",
                                avatarGroup: "group_volleyball",
                                logoImage: "Logo5",
                                shortDescription: "Фан-группа",
                                fullDescription: "4 сезон аниме закончился. Про 5 сезон НЕТ никакой информации. Манга закончилась, последняя глава — 402.",
                                subscribersCount: 100),
                        ],
                        photo: [
                            PhotoModel(name: "", fileName: "group_volleyball", likeCount: 0, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata1", likeCount: 1, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata2", likeCount: 2, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata3", likeCount: 3, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata4", likeCount: 4, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata5", likeCount: 5, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata6", likeCount: 6, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata7", likeCount: 7, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata8", likeCount: 8, isLike: false),
                        ]
            ),
            
            FriendModel(name: "Yagami Ligth", avatarName: "Light0", city: "Токио",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "Tru detectiv",
                                avatarGroup: "group_trueDetectiv",
                                logoImage: "Logo3",
                                shortDescription: "Фан-группа",
                                fullDescription: "Настоящий детектив» (англ. True Detective) — американский телесериал в жанре криминальной драмы, транслируемый с 12 января 2014 года на кабельном канале HBO. Создатель и автор сценария — Ник Пиццолатто. Сериал выпускается в формате антологии — в каждом сезоне свой сюжет и действующие лица. Внимание❗☢ В постах сообщества встречается ненормативная лексика❗",
                                subscribersCount: 100)],
                        photo: [
                            PhotoModel(name: "", fileName: "Light1", likeCount: 1, isLike: false),
                            PhotoModel(name: "", fileName: "Light2", likeCount: 2, isLike: false),
                            PhotoModel(name: "", fileName: "Light3", likeCount: 3, isLike: false),
                            PhotoModel(name: "", fileName: "Light4", likeCount: 4, isLike: false),
                            PhotoModel(name: "", fileName: "Light5", likeCount: 5, isLike: false),
                        ]
            ),
            
            FriendModel(name: "Haruno Sakura", avatarName: "Sakura0", city: "Коноха",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "Konoha",
                                avatarGroup: "group_konoha",
                                logoImage: "Logo1",
                                shortDescription: "Больше, чем просто аниме",
                                fullDescription: "Наруто, боруто и музыка.",
                                subscribersCount: 100),
                        ],
                        photo: [
                            PhotoModel(name: "Beauty", fileName: "Sakura2", likeCount: 10, isLike: false),
                            PhotoModel(name: "Neko", fileName: "Sakura3", likeCount: 3, isLike: false),
                            PhotoModel(name: "Art", fileName: "Sakura4", likeCount: 4, isLike: false),
                            PhotoModel(name: "", fileName: "Sakura1", likeCount: 1, isLike: false),
                            PhotoModel(name: "", fileName: "Sakura5", likeCount: 5, isLike: false),
                            PhotoModel(name: "", fileName: "Sakura6", likeCount: 6, isLike: false),
                            PhotoModel(name: "", fileName: "Sakura7", likeCount: 7, isLike: false),
                        ]
            ),
            
            FriendModel(name: "Okabe Rintaro", avatarName: "Okabe0", city: "Токио",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "Anime",
                                avatarGroup: "group_anime",
                                logoImage: "Logo0",
                                shortDescription: "Anime Channel",
                                fullDescription: "Здесь вы найдете самые актуальные новости из мира японской анимации, анонсы грядущих новинок и хорошее настроение. Присоединяйтесь! Никакие конкурсы с оплатой доставки мы не проводим. О любых случаях мошенничества пишите в личные сообщения группы. Спасибо.",
                                subscribersCount: 100),
                        ],
                        photo: [
                            PhotoModel(name: "Мы забираем машину времени", fileName: "Okabe3", likeCount: 14, isLike: false),
                            PhotoModel(name: "", fileName: "Okabe1", likeCount: 1, isLike: false),
                            PhotoModel(name: "", fileName: "Okabe2", likeCount: 2, isLike: false),
                            PhotoModel(name: "", fileName: "Okabe4", likeCount: 4, isLike: false),
                            PhotoModel(name: "", fileName: "Okabe5", likeCount: 5, isLike: false),
                            PhotoModel(name: "", fileName: "Okabe6", likeCount: 6, isLike: false),
                            PhotoModel(name: "", fileName: "Okabe7", likeCount: 7, isLike: false),
                        ]
            )
            
        ]
        
//MARK:- AllFriend
        
        allFriends = [
            FriendModel(name: "Uzumaki Naruto", avatarName: "Naruto0", city: "Коноха",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "Konoha",
                                avatarGroup: "group_konoha",
                                logoImage: "Logo1",
                                shortDescription: "Больше, чем просто аниме",
                                fullDescription: "Наруто, боруто и музыка.",
                                subscribersCount: 100),
                        ],
                        photo: [
                            PhotoModel(name: "", fileName: "Naruto1", likeCount: 1, isLike: false),
                            PhotoModel(name: "", fileName: "Naruto2", likeCount: 2, isLike: false),
                            PhotoModel(name: "", fileName: "Naruto3", likeCount: 3, isLike: false),
                            PhotoModel(name: "", fileName: "Naruto4", likeCount: 4, isLike: false),
                            PhotoModel(name: "", fileName: "Naruto5", likeCount: 5, isLike: false),
                            PhotoModel(name: "", fileName: "Naruto6", likeCount: 6, isLike: false),
                            PhotoModel(name: "", fileName: "Naruto7", likeCount: 7, isLike: false),
                            PhotoModel(name: "", fileName: "Naruto8", likeCount: 8, isLike: false),
                            PhotoModel(name: "", fileName: "Naruto9", likeCount: 9, isLike: false),
                        ]
            ),
            
            FriendModel(name: "Sudzumia Haruhi", avatarName: "Haruhi0", city: "Токио",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "Anime",
                                avatarGroup: "group_anime",
                                logoImage: "Logo0",
                                shortDescription: "Anime Channel",
                                fullDescription: "Здесь вы найдете самые актуальные новости из мира японской анимации, анонсы грядущих новинок и хорошее настроение. Присоединяйтесь! Никакие конкурсы с оплатой доставки мы не проводим. О любых случаях мошенничества пишите в личные сообщения группы. Спасибо.",
                                subscribersCount: 100),
                        ],
                        photo: [
                            PhotoModel(name: "", fileName: "Haruhi1", likeCount: 1, isLike: false),
                            PhotoModel(name: "", fileName: "group_shcoolDays", likeCount: 0, isLike: false),
                            PhotoModel(name: "", fileName: "Haruhi2", likeCount: 2, isLike: false),
                            PhotoModel(name: "", fileName: "Haruhi3", likeCount: 3, isLike: false),
                            PhotoModel(name: "", fileName: "Haruhi4", likeCount: 4, isLike: false),
                        ]
            ),
            
            FriendModel(name: "See Hinata", avatarName: "Hinata0", city: "Токио",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "Voleyball",
                                avatarGroup: "group_volleyball",
                                logoImage: "Logo5",
                                shortDescription: "Фан-группа",
                                fullDescription: "4 сезон аниме закончился. Про 5 сезон НЕТ никакой информации. Манга закончилась, последняя глава — 402.",
                                subscribersCount: 100),
                        ],
                        photo: [
                            PhotoModel(name: "", fileName: "group_volleyball", likeCount: 0, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata1", likeCount: 1, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata2", likeCount: 2, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata3", likeCount: 3, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata4", likeCount: 4, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata5", likeCount: 5, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata6", likeCount: 6, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata7", likeCount: 7, isLike: false),
                            PhotoModel(name: "", fileName: "Hinata8", likeCount: 8, isLike: false),
                        ]
            ),
            
            FriendModel(name: "RosKomNadzor", avatarName: "r_tyan0", city: "Москва",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "RKN",
                                avatarGroup: "group_RKN",
                                logoImage: "Logo7",
                                shortDescription: "РКН во Вконтакте",
                                fullDescription: "Официальный паблик Федеральной службы по надзору в сфере связи, информационных технологий и массовых коммуникаций.",
                                subscribersCount: 2),
                        ],
                        photo: [
                            PhotoModel(name: "I am", fileName: "r_tyan0", likeCount: 4, isLike: false),
                            PhotoModel(name: "Anime hater", fileName: "group_RKN", likeCount: 4, isLike: false)
                        ]
            ),
            
            FriendModel(name: "Haruno Sakura", avatarName: "Sakura0", city: "Коноха",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "Konoha",
                                avatarGroup: "group_konoha",
                                logoImage: "Logo1",
                                shortDescription: "Больше, чем просто аниме",
                                fullDescription: "Наруто, боруто и музыка.",
                                subscribersCount: 100),
                        ],
                        photo: [
                            PhotoModel(name: "Beauty", fileName: "Sakura2", likeCount: 10, isLike: false),
                            PhotoModel(name: "Neko", fileName: "Sakura3", likeCount: 3, isLike: false),
                            PhotoModel(name: "Art", fileName: "Sakura4", likeCount: 4, isLike: false),
                            PhotoModel(name: "", fileName: "Sakura1", likeCount: 1, isLike: false),
                            PhotoModel(name: "", fileName: "Sakura5", likeCount: 5, isLike: false),
                            PhotoModel(name: "", fileName: "Sakura6", likeCount: 6, isLike: false),
                            PhotoModel(name: "", fileName: "Sakura7", likeCount: 7, isLike: false),
                        ]
            ),
            
            FriendModel(name: "Uchiha Sasuke", avatarName: "Sasuke0", city: "Коноха",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "Konoha",
                                avatarGroup: "group_konoha",
                                logoImage: "Logo1",
                                shortDescription: "Больше, чем просто аниме",
                                fullDescription: "Наруто, боруто и музыка.",
                                subscribersCount: 100),
                        ],
                        photo: [
                            PhotoModel(name: "", fileName: "Sasuke1", likeCount: 1, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke2", likeCount: 2, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke3", likeCount: 3, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke4", likeCount: 4, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke5", likeCount: 5, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke6", likeCount: 6, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke7", likeCount: 7, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke8", likeCount: 8, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke9", likeCount: 9, isLike: false),
                            PhotoModel(name: "", fileName: "Sasuke10", likeCount: 10, isLike: false),
                        ]
            ),
            
            FriendModel(name: "Uchiha Itachi", avatarName: "Itachi0", city: "Коноха",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "Konoha",
                                avatarGroup: "group_konoha",
                                logoImage: "Logo1",
                                shortDescription: "Больше, чем просто аниме",
                                fullDescription: "Наруто, боруто и музыка.",
                                subscribersCount: 100),
                        ],
                        photo: [
                            PhotoModel(name: "", fileName: "Itachi1", likeCount: 1, isLike: false),
                            PhotoModel(name: "", fileName: "Itachi2", likeCount: 2, isLike: false),
                            PhotoModel(name: "", fileName: "Itachi3", likeCount: 3, isLike: false),
                            PhotoModel(name: "", fileName: "Itachi4", likeCount: 4, isLike: false),
                            PhotoModel(name: "", fileName: "Itachi5", likeCount: 5, isLike: false),
                        ]
            ),
            
            FriendModel(name: "Yagami Ligth", avatarName: "Light0", city: "Токио",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "Tru detectiv",
                                avatarGroup: "group_trueDetectiv",
                                logoImage: "Logo3",
                                shortDescription: "Фан-группа",
                                fullDescription: "Настоящий детектив» (англ. True Detective) — американский телесериал в жанре криминальной драмы, транслируемый с 12 января 2014 года на кабельном канале HBO. Создатель и автор сценария — Ник Пиццолатто. Сериал выпускается в формате антологии — в каждом сезоне свой сюжет и действующие лица. Внимание❗☢ В постах сообщества встречается ненормативная лексика❗",
                                subscribersCount: 100),
                        ],
                        photo: [
                            PhotoModel(name: "", fileName: "Light1", likeCount: 1, isLike: false),
                            PhotoModel(name: "", fileName: "Light2", likeCount: 2, isLike: false),
                            PhotoModel(name: "", fileName: "Light3", likeCount: 3, isLike: false),
                            PhotoModel(name: "", fileName: "Light4", likeCount: 4, isLike: false),
                            PhotoModel(name: "", fileName: "Light5", likeCount: 5, isLike: false),
                        ]
            ),
            
            FriendModel(name: "Okabe Rintaro (From Future)",
                        avatarName: "Okabe0", city: "Токио",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "Anime",
                                avatarGroup: "group_anime",
                                logoImage: "Logo0",
                                shortDescription: "Anime Channel",
                                fullDescription: "Здесь вы найдете самые актуальные новости из мира японской анимации, анонсы грядущих новинок и хорошее настроение. Присоединяйтесь! Никакие конкурсы с оплатой доставки мы не проводим. О любых случаях мошенничества пишите в личные сообщения группы. Спасибо.",
                                subscribersCount: 100),
                        ],
                        photo: [
                            PhotoModel(name: "Мы забираем машину времени", fileName: "Okabe3", likeCount: 14, isLike: false),
                            PhotoModel(name: "", fileName: "Okabe1", likeCount: 1, isLike: false),
                            PhotoModel(name: "", fileName: "Okabe2", likeCount: 2, isLike: false),
                            PhotoModel(name: "", fileName: "Okabe4", likeCount: 4, isLike: false),
                            PhotoModel(name: "", fileName: "Okabe5", likeCount: 5, isLike: false),
                            PhotoModel(name: "", fileName: "Okabe6", likeCount: 6, isLike: false),
                            PhotoModel(name: "", fileName: "Okabe7", likeCount: 7, isLike: false),
                        ]
            ),
            
            FriendModel(name: "Shikimori",
                        avatarName: "Shiki0", city: "Россия",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "Anime",
                                avatarGroup: "group_anime",
                                logoImage: "Logo0",
                                shortDescription: "Anime Channel",
                                fullDescription: "Здесь вы найдете самые актуальные новости из мира японской анимации, анонсы грядущих новинок и хорошее настроение. Присоединяйтесь! Никакие конкурсы с оплатой доставки мы не проводим. О любых случаях мошенничества пишите в личные сообщения группы. Спасибо.",
                                subscribersCount: 100),
                        ],
                        photo: [
                            PhotoModel(name: "Энциклопедия аниме и манги", fileName: "Shiki1", likeCount: 22, isLike: false),
                        ]
            ),
            
            FriendModel(name: "Tokuchi Toa", avatarName: "Tokuchi0", city: "Токио",
                        groupsUser: [
                            GroupModel(
                                nameGroup: "Baseball",
                                avatarGroup: "group_baseBall",
                                logoImage: "Logo2",
                                shortDescription: "Since 2012 #жде́мкаждого",
                                fullDescription: "Добро пожаловать в CALVARY! Не беда, если вы никогда не играли в бейсбол! Инструкции и инвентарь вы получите на месте! Всё покажем и расскажем! Ждём каждого! Наша цель - дружба и бейсбол!",
                                subscribersCount: 100),
                        ],
                        photo: [
                            PhotoModel(name: "Baseball master", fileName: "Tokuchi1", likeCount: 9, isLike: false),
                            PhotoModel(name: "", fileName: "Tokuchi2", likeCount: 2, isLike: false),
                            PhotoModel(name: "", fileName: "Tokuchi3", likeCount: 3, isLike: false),
                            PhotoModel(name: "", fileName: "Tokuchi4", likeCount: 4, isLike: false),
                            PhotoModel(name: "", fileName: "Tokuchi5", likeCount: 5, isLike: false),
                        ]
            )
            
            
        ]
    }
}
