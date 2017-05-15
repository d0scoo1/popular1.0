var db = require('../db');

module.exports = {
    //获取一篇文章的评论
    getOnePostComments: async (post_id) => {
        let sql = "SELECT * FROM pop_comments "
            + " WHERE comment_approved = '1' "
            + " AND comment_post_id = '" + post_id + "';";

        return await db.sequelize.query(sql, { type: db.sequelize.QueryTypes.SELECT });

    },

    //发布一条评论
    saveOneComment: async (comment) => {


        await db.pop_comments.create({

            comment_post_id: comment.post_id,
            comment_author: comment.author,
            comment_author_email: comment.author_email,
            comment_author_url: comment.author_url,
            comment_date: comment.date,
            comment_content: comment.content,
            comment_parent: comment.parent,
            comment_approved: comment.approved,

        });

    },

}