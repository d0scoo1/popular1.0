
var router = require('koa-router')();

let articleservice = require('../service/articleService');
let postservice = require('../service/postService');
const UTILS = require('../utils');

router
  .get('*', async (ctx, next) => {

    await articleservice.init();

    await next();

  })
  .get('/', async (ctx, next) => {

     let user= {
      id : 1 ,
    };

     ctx.render('admin-bg.html', {
      title: global.const_title,
      terms: global.const_terms,
      user: user,

    });


  })

  .get('/post-new', async (ctx, next) => {

    let user= {
      id : 1 ,
    };


    ctx.render('post-new.html', {
      title: global.const_title,
      terms: global.const_terms,
      user: user,

    });


  })
  .get('/post-m' ,async(ctx,next) => {

  //  let maxPage = Math.ceil((await postdao.getEditArticleNum()) / 4);
    let posts = await postservice.getSomePosts(0,10,'>=0');
    let bin = await postservice.getSomePosts(0,10,'=-1');

    ctx.render('post-m.html',{
      title: global.const_title,
      terms: global.const_terms, 
      
      posts: posts,
      bin : bin,

   //   nowPage: 1,
   //   maxPage: maxPage,

    });

})
  .post('/publish', async (ctx, next) => {

    let art = {};
      art.post_author_id = ctx.request.body.post_author_id ;
      art.post_title = ctx.request.body.post_title;
      art.post_content = ctx.request.body.post_content;
      art.post_excerpt = ctx.request.body.post_excerpt;
      art.post_term = ctx.request.body.post_term;

      if (ctx.request.body.post_status == 'on'){
        art.post_status = 0;
      }
      if( ctx.request.body.post_order == 'on'){
         art.post_order = -1;
      }

     console.log(art);

     await articleservice.postOneArticle(art);


  })



module.exports = router;
