
const postdao = require('../dao/postDAO');
const termdao = require('../dao/termDAO');


module.exports = {

//初始化
    init : async () =>{

        if(typeof(global.const_terms)=='undefined'||typeof(global.const_title)=='undefined'){
           console.log("初始化数据");
           global.const_title = 'POPULAR1.0';
           global.const_terms = await termdao.getAllTerms();

            console.log(JSON.stringify(global.const_terms)); 
        }
    } ,

    //主页打开
    index: async () => {
        let results;

        //首页文章
        let firstPage = new Promise((resolve, reject) => {
            resolve(postdao.getArticlesByPage(0));
        }
        );

        //文章数量
        let articleNum = new Promise((resolve, reject) => {
            resolve(postdao.getArticleNum());
        });

        //文章类型
        let terms = new Promise((resolve, reject) => {
            resolve(termdao.getAllTerms());
        });

        await Promise.all([firstPage,terms, articleNum]).then((value) => {
            results = value;
            //     console.log(JSON.stringify(value)); 

        });

        return results;

    },


    //获取所有文章类型
    getArticleTerms: async () => {

        let temp_terms = await termdao.getAllTerms();

        //   console.log('ArticleTerms are '+temp_terms[0].term_id);
        if (temp_terms) {
            return temp_terms;
        }

    },

    //获取文章数量
    getArticleNum: async () => {
        let count = await postdao.getArticleNum();
        // console.log('ArticleNum is '+JSON.stringify(count));
        return count[0].post_num;
    },



    //获取一页文章
    getOnePage: async (page) => {

        let results;
        let getpage = postdao.getArticlesByPage(page);
        await getpage.then((value) => {
            results = value;
            //    console.log('Articles------------ '+JSON.stringify(value));
        }
        );

        return results;
    },

    //获取一篇文章
    getOneArticle: async (id) => {

        let results = {
            post: false,
            post_pre: null,
            post_next: null,
            comments: null
        };


        let article = await postdao.getOneArticleById(id);

        if (article.length > 0) {
            results.post = article[0];

            //根据时间，获取前后文章标题，id
            let pre = await postdao.getPrePost(results.post.post_f_date + ' ' + results.post.post_f_time);
          
            if (pre.length > 0) {
                results.post_pre = pre[0];
            }
            let next = await postdao.getNextPost(results.post.post_f_date + ' ' + results.post.post_f_time);
            if (next.length > 0) {
                results.post_next = next[0];
            }

        }

        return results;

    },
    //发布一篇文章
    postOneArticle: async (art) => {
        let date = new Date();
        console.log(date);


        let article = {
            post_author: art.post_author,
            post_date: date,
            post_title: art.post_title,
            post_content: art.post_content,
            post_desc: art.post_desc || '',
            post_status: 1,
            post_type: art.post_type || 1,

        }

        await postdao.postArticle(article);

    },
}