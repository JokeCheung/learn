import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'
import path from 'node:path'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    vueDevTools(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    },
  },
  server:{
    proxy:{
      '/api':{//获取了路径中包含的/api请求
        target:'http://localhost:8080',//后台服务的源
        changeOrigin:true,
        rewrite:(path)=>path.replace(/^\/api/,'')///api替换为''
      }
    }
  }
})
