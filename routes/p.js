
var router = require('koa-router')();
var articleservice = require('../service/articleService');

router
/**
 * 获取一篇文章
 */
.get('/:id',async(ctx,next)=>{
  let id = ctx.params.id;
 
  let results = await articleservice.getOneArticle(id);


  if(results.post){
  ctx.render('post.html', {
 
    post_title : results.post.post_title,
    post : results.post,
    post_pre : results.post_pre,
    post_next : results.post_next ,
    terms: global.const_terms,
    title: global.const_title,
  });
}else{
    ctx.render('404.html', {
        message:'没有此文章'
  });
  }
})

.get('/:term/:i',async(ctx, next)=>{


  ctx.render('index.html',{

      });

})


module.exports = router;
