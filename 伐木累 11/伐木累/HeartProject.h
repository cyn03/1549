//
//  HeartProject.h
//  HeartPro
//
//  Created by qianfeng on 15/11/7.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#ifndef HeartPro_HeartProject_h
#define HeartPro_HeartProject_h


#define URL_Advertisement @"http://api.bohejiaju.com/v1/banners?channel=iOS"

#define URL_Head @"http://api.bohejiaju.com/v1/channels/4/items?gender=1&generation=1&limit=20&offset=%d"

#define URL_SVClose @"http://api.bohejiaju.com/v2/collections?limit=10&offset=0"

#define URL_Place @"http://api.bohejiaju.com/v2/channel_groups/all"

#define URL_Special @"http://api.bohejiaju.com/v2/collections/%d/posts?limit=20&offset=%d"

#define URL_Placeurl @"http://api.bohejiaju.com/v1/channels/%d/items?limit=20&offset=%d"

#define URL_Detai @"http://api.bohejiaju.com/v1/posts/%@"

#define URL_InspectTotal @"http://api.bohejiaju.com/v1/collections?offset=0&limit=20"

/*正在上映的电影*/
#define SHOWING_URL @"http://api.douban.com/v2/movie/nowplaying?alt=json&apikey=0df993c66c0c636e29ecbb5344252a4a&app_name=doubanmovie&city=%E5%8C%97%E4%BA%AC&client=e%3AiPhone7%2C2%7Cy%3AiPhone%20OS_8.3%7Cs%3Amobile%7Cf%3Adoubanmovie_2%7Cv%3A3.6.5%7Cm%3A%E8%B1%86%E7%93%A3%E7%94%B5%E5%BD%B1%7Cudid%3A11db9fbc4157cb38f12bbbf6fbcd379dd9e2eb9c&start=0&udid=11db9fbc4157cb38f12bbbf6fbcd379dd9e2eb9c&version=2"

/*资讯*/
#define MESSAGE_URL @"http://api.m.mtime.cn/TopList/TopListOfAll.api?pageIndex=1"

/*随机推荐*/
#define RECOMMEND_RANDOM_URL @"http://api.douban.com/v2/movie/top250?alt=json&apikey=0df993c66c0c636e29ecbb5344252a4a&app_name=doubanmovie&client=e%3AiPhone7%2C2%7Cy%3AiPhone%20OS_8.3%7Cs%3Amobile%7Cf%3Adoubanmovie_2%7Cv%3A3.6.5%7Cm%3A%E8%B1%86%E7%93%A3%E7%94%B5%E5%BD%B1%7Cudid%3A11db9fbc4157cb38f12bbbf6fbcd379dd9e2eb9c&count=10&random=1&start=0&udid=11db9fbc4157cb38f12bbbf6fbcd379dd9e2eb9c&version=2"

/*电影详情*/
#define SHOWING_DETAIL_FRONT_URL @"http://api.douban.com/v2/movie/subject/%@"
#define SHOWING_DETAIL_BEHIND_URL @"?alt=json&apikey=0df993c66c0c636e29ecbb5344252a4a&app_name=doubanmovie&city=%E5%8C%97%E4%BA%AC&client=e%3AiPhone7%2C2%7Cy%3AiPhone%20OS_8.3%7Cs%3Amobile%7Cf%3Adoubanmovie_2%7Cv%3A3.6.5%7Cm%3A%E8%B1%86%E7%93%A3%E7%94%B5%E5%BD%B1%7Cudid%3A11db9fbc4157cb38f12bbbf6fbcd379dd9e2eb9c&udid=11db9fbc4157cb38f12bbbf6fbcd379dd9e2eb9c&version=2"

/*演员信息*/
#define ACTOR_URL @"http://movie.douban.com/celebrity/%@/mobile?t=ios"

/*资讯*/
#define ZXPJ_URL @"http://api.m.mtime.cn/TopList/TopListDetails.api?pageIndex=1&topListId=%@"

/*资讯*/
#define SEARCH_URL @"http://api.douban.com/v2/movie/search?alt=json&apikey=0df993c66c0c636e29ecbb5344252a4a&app_name=doubanmovie&client=e%3AiPhone7%2C2%7Cy%3AiPhone%20OS_8.3%7Cs%3Amobile%7Cf%3Adoubanmovie_2%7Cv%3A3.6.5%7Cm%3A%E8%B1%86%E7%93%A3%E7%94%B5%E5%BD%B1%7Cudid%3A11db9fbc4157cb38f12bbbf6fbcd379dd9e2eb9c&count=20&"

#define SEARCH_NAME_URL @"q=%@&start=0&udid=11db9fbc4157cb38f12bbbf6fbcd379dd9e2eb9c&version=2"


#endif
