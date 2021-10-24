//
//  NewsStorage.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 25.07.2021.
//

import Foundation

class NewsStorage {
    var news: [NewsModel]
    
    init() {
        news = [
            NewsModel(
                user: [FriendModel(name: "Shikimori",
                                   avatarName: "Shiki0",
                                   city: "Россия",
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
                      )],
                data: "8.08.21",
                newsImageName: "News0",
                text: "Трейлер и детали сиквела Isekai Shokudou. Чем зауряднее и обычнее выглядит местечко, тем больше у него шансов оказаться на самом деле пристанищем всего таинственного и мистического. Так получилось и с Кошачьей кафешкой. Это заведение вот уже пятьдесят лет радует своих посетителей вкусной и недорогой едой. Сюда заходит и стар, и млад, ведь помимо западной кухни здесь можно встретить японские блюда и лакомства других народов. Уютный ресторанчик с дубовой дверью и вывеской в виде кота давно поселился в сердцах местного населения. Но по субботам Кошачья кафешка закрыта. Все уже привыкли к этому, и никто не задавался вопросом, почему. Но закрыто заведение только для людей. Для определённого контингента каждую субботу двери всё ещё широко распахнуты. Особые гости со всех уголков мира собираются здесь, чтобы отведать мистически вкусные блюда! Здесь официантками трудятся девушка Алетта, жившая раньше в мире духов, а также Куро, являющаяся человеческим воплощением дракона! Гости в своём разнообразии не уступают персоналу. Субботние вечеринки странных существ объявляются открытыми!",
                newsDataModel: [
                    NewsDataModel(newsLikeCount: 47,
                                  newsRepostCount: 14,
                                  newsViewCount: 800,
                                  newsIsComment: false,
                                  newsIsLike: false,
                                  newsIsRepost: false
                    )
                ]),
            
            NewsModel(
                user: [FriendModel(name: "See Hinata",
                                   avatarName: "Hinata0",
                                   city: "Токио",
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
                                    PhotoModel(name: "", fileName: "group_volleyball", likeCount: 1, isLike: false)
                                   ]
                )],
                data: "27.07.21",
                newsImageName: "Hinata2",
                text: "Снова тренируемся с друзьями.",
                newsDataModel: [
                    NewsDataModel(newsLikeCount: 1,
                                  newsRepostCount: 2,
                                  newsViewCount: 3,
                                  newsIsComment: false,
                                  newsIsLike: false,
                                  newsIsRepost: false
                    )
                ]),
            
            NewsModel(
                user: [FriendModel(name: "Shikimori",
                                   avatarName: "Shiki0",
                                   city: "Россия",
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
                      )],
                data: "28.07.21",
                newsImageName: "News2",
                text: "На Mappa Stage 2021 объявили новые подробности о ранее анонсированном аниме Takt Op., включая постер и первый трейлер. Мультимедийный проект будет включать в себя аниме и одноименную игру от Bandai Namco.",
                newsDataModel: [
                    NewsDataModel(newsLikeCount: 88,
                                  newsRepostCount: 14,
                                  newsViewCount: 800,
                                  newsIsComment: false,
                                  newsIsLike: false,
                                  newsIsRepost: false
                    )
                ]),
            
            NewsModel(
                user: [FriendModel(name: "Shikimori",
                                   avatarName: "Shiki0",
                                   city: "Россия",
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
                      )],
                data: "27.07.21",
                newsImageName: "News3",
                text: "Фильм 'Sword Art Online: Progressive - Hoshi Naki Yoru no Aria' выйдет на экраны кинотеатров 30 октября. Представлен новый постер. Напомним, за аниме взялась студия A-1 Pictures. Режиссер Ayako Kouno - режиссер эпизодов 'Koi wa Ameagari no You ni', художник персонажей Kento Toya- 'Nanbaka', музыку создает Yuki Kajiura- 'Kara no Kyoukai 6: Boukyaku Rokuon'. В серии ранобэ 'Sword Art Online: Progressive' подробно описаны прохождения каждого уровня Анкрайда.",
                newsDataModel: [
                    NewsDataModel(newsLikeCount: 112,
                                  newsRepostCount: 37,
                                  newsViewCount: 643,
                                  newsIsComment: false,
                                  newsIsLike: false,
                                  newsIsRepost: false
                    )
                ]),
                
            NewsModel(
                user: [FriendModel(name: "Tokuchi Toa",
                                   avatarName: "Tokuchi0",
                                   city: "Токио",
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
                                    PhotoModel(name: "", fileName: "Tokuchi0", likeCount: 9, isLike: false)
                                   ]
                )],
                data: "27.07.21",
                newsImageName: "Tokuchi2",
                text: "Эта история начинается с того, что Хиромити Кодзима, ведущий бэттер несуществующей в реальности команды «Lycaons» Японской Тихоокеанской лиги, направляется на Окинаву, южный японский остров, чтобы как следует потренироваться и выйти из полосы неудач. Там он встречает Тоа Токути — питчера, способного бросить мяч со скоростью 134 км/ч, и неоспоримого короля бейсбольных игр на деньги, называющейся «Один на вылет». Поддавшись на уговоры Хиромити, Тоа подписывает с «Lycaons» необычный контракт: за каждый выбитый аут он получает пять миллионов иен, зато теряет пятьдесят миллионов иен за каждое проигранное очко.",
                newsDataModel: [
                    NewsDataModel(newsLikeCount: 2,
                                  newsRepostCount: 3,
                                  newsViewCount: 4,
                                  newsIsComment: false,
                                  newsIsLike: false,
                                  newsIsRepost: false)
                ]),
            
            NewsModel(
                user: [FriendModel(name: "Okabe Rintaro (aka Mad Scientist)",
                                   avatarName: "Okabe0",
                                   city: "Токио",
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
                                       PhotoModel(name: "", fileName: "Okabe3", likeCount: 14, isLike: false)
                                   ]
                       )],
                data: "27.07.21",
                newsImageName: "Okabe2",
                text: "Кажется в этом времени я еще не появляся. Здравствуйте, я Джон Тайтор - ученый и путешественник во времени. Из-за интереса к одному эксперименту проводимого мной и другом Дару, к нашей лаборатории присоединилась Курису. Вскоре после этого, мы открыли, что созданная нами Мобиловолновка – это машина времени. С помощью Курису, я начал проводить эксперименты с Ди-мейлами (D-mail – сокращение от DeLorean Mail). Но своими действиями мы запустили череду несчастий, связанных с изменением прошлого, а следовательно и будущего.",
                newsDataModel: [
                    NewsDataModel(newsLikeCount: 3,
                                  newsRepostCount: 4,
                                  newsViewCount: 5,
                                  newsIsComment: false,
                                  newsIsLike: false,
                                  newsIsRepost: false)
                ]),
        ]
    }
}
