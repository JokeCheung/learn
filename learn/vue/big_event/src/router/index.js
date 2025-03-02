import { createRouter, createWebHistory } from "vue-router";

//导入组件
import LoginVue from "@/views/Login.vue";
import LayoutVue from "@/views/Layout.vue";

import ArticleCategoryVue from "@/article/ArticleCategory.vue";
import ArticleManageVue from "@/article/ArticleManage.vue";
import UserAvatarVue from "@/user/UserAvatar.vue";
import UserInfoVue from "@/user/UserInfo.vue";
import UserResetPasswordVue from "@/user/UserResetPassword.vue";

//定义路由关系
const routes = [
  { path: "/login", component: LoginVue },
  {
    path: "/",
    component: LayoutVue,
    redirect:"/article/manager",
    children: [
      { path: "/article/category", component: ArticleCategoryVue },
      { path: "/article/manager", component: ArticleManageVue },
      { path: "/user/info", component: UserInfoVue },
      { path: "/user/avatar", component: UserAvatarVue },
      { path: "/user/resetPassword", component: UserResetPasswordVue },
    ],
  },
];
//创建路由器
const router = createRouter({
  history: createWebHistory(),
  routes: routes,
});
//导出路由
export default router;
