
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
  .post('/login-valid', async (ctx, next) => {

    let msg = '账号密码错误';

    let user_login = ctx.request.body.user_login;
    let user_pwd = ctx.request.body.user_pwd;

    if (user_login == '' || user_pwd == '')
      msg = '请输入账号密码';

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
        msg: msg,

      });

    }


  })
  .get('*', async (ctx, next) => {

    await articleservice.init();

    //这里用户是否登陆验证
    if (ctx.cookies.get('user_cookie')) {
      ctx.state.user = UTILS.parse(ctx.cookies.get('user_cookie'));
      //  console.log(`user_cookie value: ` + ctx.state.user.user_login);
      await next();
    } else {

      ctx.render('login.html', {

      });

    }
  })
  .get('/logout', async (ctx, next) => {

    ctx.cookies.set('user_cookie', '');
    console.log('user logout !');
    ctx.response.redirect('/');

  })
  .get('/', async (ctx, next) => {


    ctx.render('admin-bg.html', {
      title: global.const_title,
      terms: global.const_terms,
      user: ctx.state.user,

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

    let post = {};
    post.post_author_id = ctx.request.body.post_author_id;
    post.post_title = ctx.request.body.post_title;
    post.post_content = ctx.request.body.post_content;
    post.post_excerpt = ctx.request.body.post_excerpt;
    post.post_term = ctx.request.body.post_term;


    let msg = '文章已发布';

    if (ctx.request.body.post_status == 'on') {
      post.post_status = 0;
      msg = '已存草稿,' + new Date();
    } else {
      post.post_status = 1;
    }
    if (ctx.request.body.post_order == 'on') {
      post.post_order = -1;
    } else {
      post.post_status = 0;
    }

    // console.log(post);

    let result = await postservice.insertOnePost(post);
    if (result) {
      ctx.response.redirect('/admin/post-edit/' + result);
    } else {

    }

    // 

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
  .get('/post-edit/:id', async (ctx, next) => {

    let id = ctx.params.id;
    let post = await postservice.getOnePost(id);

    //   console.log(post);

    ctx.render('post-edit.html', {
      title: global.const_title,
      terms: global.const_terms,

      post: post,

    });
  })
  .post('/ajax/post-update', async (ctx, next) => {

    let post = {};
    post.post_id = ctx.request.body.post_id;
    post.post_title = ctx.request.body.post_title;
    post.post_content = ctx.request.body.post_content;
    post.post_excerpt = ctx.request.body.post_excerpt;
    post.post_term = ctx.request.body.post_term;

    console.log(ctx.request.body.post_status);
    console.log(ctx.request.body.post_order);

    if (ctx.request.body.post_status == 'true') {
      post.post_status = 0;
    } else {
      post.post_status = 1;
    }
    if (ctx.request.body.post_order == 'true') {
      post.post_order = -1;
    } else {
      post.post_order = 0;
    }

    await postservice.updateOnePost(post);

    ctx.response.type = 'application/json';

    ctx.response.body = {
      "msg": '文章已更新'
    };
  })
  .get('/post-bin/:id', async (ctx, next) => {

    let id = ctx.params.id;
    let post = await postservice.binOnePost(id);

    ctx.response.redirect('/admin/post-m');

  })
  .get('/post-del/:id', async (ctx, next) => {

    let id = ctx.params.id;
    let post = await postservice.deleteOnePost(id);

    ctx.response.redirect('/admin/post-m');

  })


module.exports = router;
