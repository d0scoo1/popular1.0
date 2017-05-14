/**
 * index.js
 * 主要包括：
 * 主页 get  '/'
 * 登录 post '/login'
 * 登出 get  '/logout'
 */
var router = require('koa-router')();

let articleservice = require('../service/articleService');
const UTILS = require('../utils');



/**
 * 打开首页时会刷新所有数据
 * 否则每次只判断内存中是否有数据，如果没有，才会主动向数据库获取
 * 
 */

router

  .get('/', async (ctx, next) => {

    global.const_title = 'POPULAR1.0';
    //获取首页文章，刷新数据
    let results = await articleservice.index();

    let posts = results[0];
    global.const_terms = results[1];
    let temp_articleNum = results[2];
    let maxPage = Math.ceil(temp_articleNum[0].post_num / 4);
    
    console.log("数据已经刷新！");


    let nowPage = 1;


    ctx.render('index.html', {
      title: global.const_title,
      terms: global.const_terms,
      nowPage: 1,
      maxPage: maxPage,
      posts: posts,
     

    });
  })
  .get('*', async (ctx, next) => {
    
     await articleservice.init();

    await next();

  })
  .get('page/:i', async (ctx, next) => {


    ctx.render('index.html', {

    });

  })


module.exports = router;
