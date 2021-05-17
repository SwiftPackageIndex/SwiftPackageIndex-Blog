import { nodeResolve } from '@rollup/plugin-node-resolve'
import commonjs from '@rollup/plugin-commonjs'
import styles from 'rollup-plugin-styles'

export default {
  input: 'Resources/javascripts/main.js',
  output: {
    file: 'Output/main.js',
    assetFileNames: 'main.css',
  },
  plugins: [
    nodeResolve(),
    commonjs(),
    styles({
      mode: ['extract'],
    }),
  ],
}
