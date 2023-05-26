import webpack from 'webpack'
import path from 'path'
import MiniCssExtractPlugin from 'mini-css-extract-plugin'
import HtmlWebpackPlugin from 'html-webpack-plugin'
import CopyWebpackPlugin from 'copy-webpack-plugin'
import WebpackPwaManifest from 'webpack-pwa-manifest'
import FaviconsWebpackPlugin from 'favicons-webpack-plugin'

import { manifestJSON } from '../src/configs/config-main'

module.exports = {
  mode: 'production',
  stats: 'errors-only',
  devtool: 'source-map',

  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          { loader: MiniCssExtractPlugin.loader },
          { loader: 'css-loader' },
          { loader: 'resolve-url-loader' },
          {
            loader: 'sass-loader',
            options: {
              sourceMap: true,
              data: '@import "config-styles.scss";',
              includePaths: [
                path.join(__dirname, '..', '/src/configs/theme')
              ]
            }
          }
        ]
      }
    ]
  },

  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: '"production"'
      },
      __DEVELOPMENT__: false
    }),
    new MiniCssExtractPlugin({ filename: '[name].css' }),
    new HtmlWebpackPlugin({
      template: 'src/index.html'
    }),
    new CopyWebpackPlugin([
      { from: 'src/manifest.json' },
      { from: 'src/assets/robots.txt' }
    ]),
    new WebpackPwaManifest(manifestJSON),
    new FaviconsWebpackPlugin('assets/favicons/favicon.svg')
  ]
}
