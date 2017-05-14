
var db = require('../db');

module.exports = {

//获取所有的文章类型
    getAllTerms : async() => {
        return await db.pop_terms.findAll();
    },

    getAllTermsByUserid : async() => {

    },

}