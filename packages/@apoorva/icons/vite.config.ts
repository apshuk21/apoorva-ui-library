import { defineConfig } from "vite";
import path from "node:path";
import { fileURLToPath } from "node:url";
import svgr from "vite-plugin-svgr";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

export default defineConfig({
  plugins: [svgr()],
  build: {
    lib: {
      entry: path.resolve(__dirname, "src/index.ts"),
      name: "ApoorvaIcons",
      formats: ["es", "cjs"],
    },
    rollupOptions: {
      external: ["react", "react-dom"],
    },
  },
  resolve: {
    alias: {
      "@apoorva/icons": path.resolve(__dirname, "src"),
    },
  },
});
