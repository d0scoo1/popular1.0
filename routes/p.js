
var router = require('koa-router')();
var articleservice = require('../service/articleService');

router
  /**
   * 获取一篇文章
   */
  .get('/:id', async (ctx, next) => {
    let id = ctx.params.id;

    let results = await articleservice.getOneArticle(id);

    if (results.post) {
      //获取评论
      let comments = await articleservice.getOnePostComments(id);


      ctx.render('post.html', {
        terms: global.const_terms,
        title: global.const_title,
        links: global.const_links,

        post_title: results.post.post_title,
        post: results.post,
        post_pre: results.post_pre,
        post_next: results.post_next,
        comments: comments,
       

      });
    } else {
      ctx.render('404.html', {
        message: '没有此文章'
      });
    }
  })
  .post('/comment', async (ctx, next) => {
  
  let comment ={ };
   
      comment.post_id = ctx.request.body.comment_post_id || '';
      comment.parent = ctx.request.body.comment_parent || '';
      comment.author = ctx.request.body.comment_author || '';
      comment.author_email = ctx.request.body.comment_author_email || '';
      comment.author_url = ctx.request.body.comment_author_url || '';
      comment.date = new Date();
      comment.content = ctx.request.body.comment_content || '';
      comment.parent = ctx.request.body.comment_parent || '';
      comment.approved = '1';
 
    //  console.log(comment);

      await articleservice.postOneComment(comment);


       let results = await articleservice.getOneArticle(comment.post_id);

    if (results.post) {
      //获取评论
      let comments = await articleservice.getOnePostComments(comment.post_id);


      ctx.render('post.html', {
        terms: global.const_terms,
        title: global.const_title,
        links: global.const_links,

        post_title: results.post.post_title,
        post: results.post,
        post_pre: results.post_pre,
        post_next: results.post_next,
        comments: comments,

      });
    } else {
      ctx.render('404.html', {
        message: '没有此文章'
      });
    }

     

  })



module.exports = router;
