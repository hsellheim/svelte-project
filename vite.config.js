import { defineConfig } from 'vite'
import { svelte } from '@sveltejs/vite-plugin-svelte'

export default defineConfig({
  base: '/svelte-project/',
  plugins: [svelte()],
  build: {
    outDir: 'docs'
  }
})