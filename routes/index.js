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
    global.const_links = results[3];
    
    console.log("数据已经刷新！");

    let nowPage = 1;    

    ctx.render('index.html', {
      title: global.const_title,
      terms: global.const_terms,
      links: global.const_links,
      posts: posts,
      
      nowPage: 1,
      maxPage: maxPage,
      nextPage:  parseInt(nowPage) + 1,
      prePage:  parseInt(nowPage) - 1,
     

    });
  })
  .get('*', async (ctx, next) => {
    
     await articleservice.init();

    await next();

  })
//
    .get('t/:term_id/:page', async (ctx, next) => {
    
        let nowTerm = ctx.params.term_id;
        let nowPage = ctx.params.page;

        let term_id = 0;

        for(let i =0;i< global.const_terms.length;i++){
          if(global.const_terms[i].term_name == nowTerm){
            term_id = global.const_terms[i].term_id;
          }else{

          }
        }

        let results = await articleservice.getPageByTerm(term_id,nowPage-1);
      //  console.log(JSON.stringify(results));

        let maxPage = Math.ceil((await articleservice.getTermPageNum (term_id)) / 4);
         
          ctx.render('page.html', {
            title: global.const_title,
            terms: global.const_terms,
            links: global.const_links,

            posts : results,
            term_id :term_id,
            term_name :nowTerm,

            nowPage: nowPage,
            maxPage: maxPage,
            nextPage: parseInt(nowPage) + 1,
            prePage: parseInt(nowPage) - 1,

    });

  })
  .get('page/:i', async (ctx, next) => {
       let nowPage = ctx.params.i;
       
    let maxPage = Math.ceil((await articleservice.getArticleNum()) / 4);
    let posts = await articleservice.getOnePage(nowPage-1);

    ctx.render('index.html', {
      title: global.const_title,
      terms: global.const_terms, 
      links: global.const_links, 
      
      posts: posts,

      nowPage: nowPage,
      maxPage: maxPage,
      nextPage: parseInt(nowPage) + 1,
      prePage: parseInt(nowPage) - 1,

    });
  })


module.exports = router;
