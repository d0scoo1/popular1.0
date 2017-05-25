var db = require('../db');

module.exports = {
    //获取友链
    getAllLinks: async () => {
        let sql = "SELECT * FROM pop_links"
            + " WHERE link_user_id = '1'"
            + " AND link_visible = '1'"
            + " order by  link_rating"

        return await db.sequelize.query(sql, { type: db.sequelize.QueryTypes.SELECT });

    },


}