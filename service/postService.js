const db = require('../db');
const UTILS = require('../utils');

module.exports = {


    /**
     * 获取已发布、草稿文章文章
     * @method getSomePosts
     * 
     * @param {Number} page 当前页数
     * @param {Number} num 每页数量
     * @param {Number} status  '=1'为已发布文章，'>=0'为已发布和草稿文章 '=-1'为回收站
     * 
     * @returns {Obj}  单页文章
     */
    getSomePosts: async (page, num, status) => {

        let i = page * num;
        let ii = i + num;

        let sql = "SELECT p.* ,u.user_nickname , date_format(post_date,'%Y-%m-%d')as post_f_date,date_format(post_date,'%H:%i')as post_f_time "
            + " FROM pop_posts as p,pop_users as u "
            + " WHERE p.post_author_id = u.user_id"
            + " AND p.post_status  " + status
            + " order by  post_status ASC,post_date DESC  limit " + i + ", " + ii;

        return await db.sequelize.query(sql, { type: db.sequelize.QueryTypes.SELECT });
    },

    /**
     * 获取已发布、草稿文章文章数量
     * @method getSomePostsNum
     * @param {String} status  =1为已发布文章，>=0为已发布和草稿文章 =-1为回收站
     * 
     * @returns {Number}  单页文章
     */
    getSomePostsNum: async (status) => {

        let sql = "SELECT COUNT(*) AS post_num FROM pop_posts WHERE post_status " + status;

        let result = await db.sequelize.query(sql, { type: db.sequelize.QueryTypes.SELECT });

        return result[0].post_num;
    },


    /**
     * 获取一篇文章
     * @method getOnePost
     * 
     * @param {Int} id 
     * 
     * @returns {} 
     */
    getOnePost: async (id) => {

        let sql = "SELECT * ,date_format(post_date,'%Y-%m-%d')as post_f_date,date_format(post_date,'%H:%i')as post_f_time "
            + " FROM pop_posts as p,pop_users as u ,pop_terms as t "
            + " WHERE p.post_id = '" + id + "'"
            + " AND p.post_author_id = u.user_id"
            + " AND p.post_term = t.term_id ";
        let result = await db.sequelize.query(sql, { type: db.sequelize.QueryTypes.SELECT });

        if (result.length > 0) {
            return result[0];
        } else {
            return false;
        }
    },

    /**
     * 增加一篇文章
     * @method insertOnePost
     * 
     * @param {} post
     * 
     * @return void
     */
    insertOnePost: async (post) => {

        await db.pop_posts.create({

            post_author_id: post.post_author_id,
            post_date: new Date(),
            post_title: post.post_title,
            post_content: post.post_content,
            post_excerpt: post.post_excerpt,
            post_term: post.post_term,
            post_status: post.post_status ,
            post_order: post.post_order ,
        });

        let sql = " SELECT last_insert_id() as post_id";
        let result = await db.sequelize.query(sql, { type: db.sequelize.QueryTypes.SELECT });

        if (result.length > 0) return result[0].post_id;
        else return false;

    },

    /**
     * 更新一篇文章
     * @method updateOnePost
     * 
     * @param {} post
     * 
     * @return void
     */
    updateOnePost: async (post) => {
        
        let date = UTILS.formatDateTime(new Date());
    //    console.log(date);

        let sql = "UPDATE pop_posts "
            + " SET post_date='"+date+"' ,post_title = '"+post.post_title 
            +"' , post_content='"+post.post_content+"', post_excerpt='"+ post.post_excerpt
            +"',post_term='"+post.post_term+"',post_status='"+post.post_status +"',post_order= "+ post.post_order
            +" WHERE post_id =  '"+post.post_id+"'";
        
        await db.sequelize.query(sql, { type: db.sequelize.QueryTypes.UPDATE });
      
    },

    /**
     * 将文章放入回收站
     * @method binOnePost
     * 
     * @param {} post
     * 
     * @return void
     */
    binOnePost: async (post_id) => {

        let sql = "UPDATE pop_posts "
            + " SET post_status= '-1'" 
            +" WHERE post_id =  '"+post_id+"'";
        
        await db.sequelize.query(sql, { type: db.sequelize.QueryTypes.UPDATE });
      
    },

        /**
     * 将文章放入回收站
     * @method deleteOnePost
     * 
     * @param {} post
     * 
     * @return void
     */
    deleteOnePost: async (post_id) => {
        
        let date = UTILS.formatDateTime(new Date());
    //    console.log(date);

        let sql = "DELETE FROM pop_posts WHERE post_id = "+post_id;
           
        
        await db.sequelize.query(sql, { type: db.sequelize.QueryTypes.DELETE });
      
    },



    

}