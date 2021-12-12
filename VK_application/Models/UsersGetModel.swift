//
//  UsersGetModel.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 28.10.2021.
//

import Foundation

struct UsersGetModel: Codable {
    let response: [UsersGetItems]
}

struct UsersGetItems: Codable {
    
    // MARK: - Info
    
    /// Имя
    let first_name: String?
    
    /// Идентификатор пользователя
    let id: Int?
    
    /// Фамилия
    let last_name: String?
    
    /// Пол. 1 — женский; 2 — мужской; 0 — не указан
    let sex: Int?
    
    /// Короткое имя страницы
    let screen_name: String?
    
    /// 0/1
    let online: Int?
    
    /// Короткий адрес страницы
    let domain: String?
    
    /// Семейное положение. Возможные значения:
    /// 1 — не женат/не замужем;
    /// 2 — есть друг/есть подруга;
    /// 3 — помолвлен/помолвлена;
    /// 4 — женат/замужем;
    /// 5 — всё сложно;
    /// 6 — в активном поиске;
    /// 7 — влюблён/влюблена;
    /// 8 — в гражданском браке;
    /// 0 — не указано.
    let relation: Int?
    
    /// Количество подписчиков
    let followers_count: Int?
    
    /// Количество общих друзей с текущим пользователем
    let common_count: Int?
    
    /// Время последнего посещения
    let last_seen: UsersGetLastSeen?
    
    let photo_50: String?
    let photo_100: String?
    let photo_200: String?
    let photo_max_orig: String?
    
    // MARK: - About self
    
    /// Дата рождения. Возвращается в формате D.M.YYYY
    let bdate: String?
    let instagram: String?
    let interests: String?
    
    /// Любимые книги
    let books: String?
    
    /// Любимые ТВ
    let tv: String?
    
    /// Цитаты
    let quotes: String?
    
    /// Содержимое поля «О себе» из профиля.
    let about: String?
    
    /// Любимые игры
    let games: String?
    
    /// Любимые фильмы
    let movies: String?
    
    /// Содержимое поля «Деятельность» из профиля
    let activities: String?
    
    /// Любимая музыка
    let music: String?
    
    /// Адрес сайта, указанный в профиле
    let site: String?
    
    /// Статус пользователя. Возвращается строка, содержащая текст статуса, расположенного в профиле под именем.
    let status: String?
    
    ///  Жизненная позиция
//    let personal: UsersGetPersonal?
    
    /// Список родственников
    let relatives: [UsersGetRelatives]?
    
    let university_name: String?
    let faculty_name: String?
    let city: UsersGetCity?
    let country: UsersGetCountry?
    
    // MARK: - Is?
    
    /// Поле возвращается, если страница пользователя удалена или заблокирована, содержит значение deleted или banned.
    /// В этом случае опциональные поля не возвращаются.
    let deactivated: String?
    
    /// Является ли другом
    let is_friend: Int?
    
    /// Информация о том, находится ли текущий пользователь в черном списке.
    let blacklisted: Int?
    
    /// Информация о том, находится ли пользователь в черном списке у текущего пользователя
    let blacklisted_by_me: Int?
    
    /// Может ли текущий пользователь писать сообщения
    let can_write_private_message: Int?
}

// MARK: - Struct

struct UsersGetCity: Codable {
    /// Город
    let title: String?
}

struct UsersGetCountry: Codable {
    /// Страна
    let title: String?
}

struct UsersGetLastSeen: Codable {
    /// Тип платформы. Возможные значения:
    /// 1 — мобильная версия;
    /// 2 — приложение для iPhone;
    /// 3 — приложение для iPad;
    /// 4 — приложение для Android;
    /// 5 — приложение для Windows Phone;
    /// 6 — приложение для Windows 10;
    /// 7 — полная версия сайта.
    let platform: Int?
    let time: Int?
}

struct UsersGetPersonal: Codable {
    /// отношение к алкоголю. Возможные значения:
    /// 1 — резко негативное;
    /// 2 — негативное;
    /// 3 — компромиссное;
    /// 4 — нейтральное;
    /// 5 — положительное.
    let alcohol: Int?
    
    /// главное в жизни. Возможные значения:
    /// 1 — семья и дети;
    /// 2 — карьера и деньги;
    /// 3 — развлечения и отдых;
    /// 4 — наука и исследования;
    /// 5 — совершенствование мира;
    /// 6 — саморазвитие;
    /// 7 — красота и искусство;
    /// 8 — слава и влияние;
    let life_main: Int?
    
    /// главное в людях. Возможные значения:
    /// 1 — ум и креативность;
    /// 2 — доброта и честность;
    /// 3 — красота и здоровье;
    /// 4 — власть и богатство;
    /// 5 — смелость и упорство;
    /// 6 — юмор и жизнелюбие.
    let people_main: Int?
    
    /// отношение к курению. Возможные значения:
    /// 1 — резко негативное;
    /// 2 — негативное;
    /// 3 — компромиссное;
    /// 4 — нейтральное;
    /// 5 — положительное.
    let smoking: Int?
    
    /// источники вдохновения
    let inspired_by: String?
    
    /// языки
    let langs: String?
}

struct UsersGetRelatives: Codable {
    /// тип родственной связи. Возможные значения:
    /// child — сын/дочь;
    /// sibling — брат/сестра;
    /// parent — отец/мать;
    /// grandparent — дедушка/бабушка;
    /// grandchild — внук/внучка.
    let type: String?
    
    /// идентификатор пользователя
    let id: Int?
    
    /// имя родственника (если родственник не является пользователем ВКонтакте, то предыдущее значение id возвращено не будет
    let name: String?
}
