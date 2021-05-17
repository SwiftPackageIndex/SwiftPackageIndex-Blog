import { nodeResolve } from '@rollup/plugin-node-resolve'
import commonjs from '@rollup/plugin-commonjs'
import styles from 'rollup-plugin-styles'
import { terser } from 'rollup-plugin-terser'

export default {
  input: 'Resources/javascripts/main.js',
  output: {
    file: 'Output/main.js',
    assetFileNames: 'main.css',
    sourcemap: true,
  },
  plugins: [
    nodeResolve(),
    commonjs(),
    styles({
      mode: ['extract'],
      sourceMap: true,
      minimize: true,
    }),
    terser(),
  ],
}
