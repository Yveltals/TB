'use strict'

const path = require('path')

module.exports = {
  dev: {

    // Paths
    assetsSubDirectory: 'static',
    assetsPublicPath: '/',
    proxyTable: {// 在这里配置如下代码 此配置只在npm run dev 下生效

      '/api': {
        target: 'http://127.0.0.1:8080/', 
        changeOrigin: true, //
        pathRewrite: {
          '^/api': '/'
        }
      },
      '/img': {     //图片资源默认以8080端口发起请求
        target: 'http://127.0.0.1:8080/', //
        changeOrigin: true, //
        pathRewrite: {
          '^/': '/'
        }
      }
    },

    // Various Dev Server settings
    host: '127.0.0.1', // can be overwritten by process.env.HOST
    port: 80, 
    autoOpenBrowser: false,
    errorOverlay: true,
    notifyOnErrors: true,
    poll: false,

    useEslint: false,
    showEslintErrorsInOverlay: false,

    /**
     * Source Maps
     */

    devtool: 'cheap-module-eval-source-map',

    cacheBusting: true,

    cssSourceMap: true
  },

  build: {
    // Template for index.html
    index: path.resolve(__dirname, '../dist/index.html'),

    // Paths
    assetsRoot: path.resolve(__dirname, '../dist'),
    assetsSubDirectory: 'static',
    assetsPublicPath: './',

    /**
     * Source Maps
     */

    productionSourceMap: true,
    devtool: '#source-map',

    productionGzip: false,
    productionGzipExtensions: ['js', 'css'],
    bundleAnalyzerReport: process.env.npm_config_report
  }
}
