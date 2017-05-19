
var router = require('koa-router')();

let articleservice = require('../service/articleService');
let postservice = require('../service/postService');
let userservice = require('../service/userService');

const UTILS = require('../utils');

router
  .get('/login', async (ctx, next) => {

    ctx.render('login.html', {

    });

  })
  .post('/', async (ctx, next) => {

    let user_login = ctx.request.body.user_login;
    let user_pwd = ctx.request.body.user_pwd;
    let user = await userservice.loginValid(user_login, user_pwd);
   
    if (user) {

      //设置cookie

      let cookie_value = Buffer.from(JSON.stringify(user)).toString('base64');
      ctx.cookies.set('user_cookie', cookie_value, { signed: true, maxAge: 60 * 60 * 1000 });
      console.log(`Set user_cookie value: ${cookie_value}`);

      ctx.render('admin-bg.html', {
        title: global.const_title,
        terms: global.const_terms,
        user: user,

      });
    } else {

      ctx.render('login.html', {
        msg : '账号或密码错误'

      });

    }


  })
  .get('*', async (ctx, next) => {

    await articleservice.init();

    //这里用户是否登陆验证
    if (ctx.cookies.get('user_cookie')) {
      ctx.state.user = UTILS.parse(ctx.cookies.get('user_cookie'));
      console.log(`user_cookie value: ` + ctx.state.user.user_login);
      await next();
    } else {

      ctx.render('login.html', {

      });

    }
  })
  .get('/logout', async (ctx, next) => {

    ctx.cookies.set('user_cookie', '');
    console.log('user logout !');
    ctx.render('login.html', {

    });

  })



  .get('/post-new', async (ctx, next) => {


    ctx.render('post-new.html', {
      title: global.const_title,
      terms: global.const_terms,
      user: ctx.state.user,

    });


  })

  .post('/post-new-publish', async (ctx, next) => {

    let art = {};
    art.post_author_id = ctx.request.body.post_author_id;
    art.post_title = ctx.request.body.post_title;
    art.post_content = ctx.request.body.post_content;
    art.post_excerpt = ctx.request.body.post_excerpt;
    art.post_term = ctx.request.body.post_term;

    if (ctx.request.body.post_status == 'on') {
      art.post_status = 0;
    }
    if (ctx.request.body.post_order == 'on') {
      art.post_order = -1;
    }

    console.log(art);

    await articleservice.postOneArticle(art);


  })
  .get('/post-m', async (ctx, next) => {

    let posts_page_num = 10;
    let bin_page_num = 10;

    //  let maxPage = Math.ceil((await postdao.getEditArticleNum()) / 4);
    let posts = await postservice.getSomePosts(0, posts_page_num, '>=0');
    let bin = await postservice.getSomePosts(0, bin_page_num, '=-1');

    ctx.render('post-m.html', {
      title: global.const_title,
      terms: global.const_terms,

      posts: posts,
      bin: bin,

      //   nowPage: 1,
      //   maxPage: maxPage,

    });

  })
  .get('/post-edit', async (ctx, next) => {


    ctx.render('post-edit.html', {
      title: global.const_title,
      terms: global.const_terms,

      posts: posts,
      bin: bin,

      //   nowPage: 1,
      //   maxPage: maxPage,

    });

  })



module.exports = router;
