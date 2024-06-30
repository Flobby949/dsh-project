import { createSSRApp } from 'vue'
import * as Pinia from 'pinia'
import { createUnistorage } from 'pinia-plugin-unistorage'
import App from "./App.vue";

export function createApp() {
  const app = createSSRApp(App)
  const store = Pinia.createPinia()
  app.use(store)
    store.use(createUnistorage())
  return {
    app,
    Pinia, // 此处必须将 Pinia 返回
  }
}
