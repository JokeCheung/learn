package learn.entity

data class User(
    val id: String,
    val username: String,
    val nickname: String,
    val email: String,
    val userPic: String,
    val createTime: String,
    val updateTime: String
) {

    override fun toString(): String {
        return "User(" +"\n"+
                "id='$id', " +"\n"+
                "username='$username', " +"\n"+
                "nickname='$nickname', " +"\n"+
                "email='$email', " +"\n"+
                "userPic='$userPic', " +"\n"+
                "createTime='$createTime', " +"\n"+
                "updateTime='$updateTime')"+"\n"
    }
}