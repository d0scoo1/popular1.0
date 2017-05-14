


var parse = function parseUser(obj) {
    if (!obj) {
        return;
    }
  //  console.log('try parse: ' + obj);
    let s = '';
    if (typeof obj === 'string') {
        s = obj;
    } else if (obj.headers) {
        let cookies = new Cookies(obj, null);
        s = cookies.get('user_cookie');
    }
    if (s) {
        try {
            let user = JSON.parse(Buffer.from(s, 'base64').toString());
       //     console.log(`User: ${user.user_name}, ID: ${user.user_id}`);
            return user;
        } catch (e) {
            // ignore
        }
    }
}


module .exports = {
    parse
};