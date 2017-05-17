var db = require('../db');

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
            + " AND p.post_status  "+status
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

        let sql = "SELECT COUNT(*) AS post_num FROM pop_posts WHERE post_status "+status;
     
        let result = await db.sequelize.query(sql, { type: db.sequelize.QueryTypes.SELECT });
   
        return result[0].post_num;
    },


}