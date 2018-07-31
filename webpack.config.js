const path = require('path');

module.exports = function(env) {
  const production = process.env.NODE_ENV === 'production';

  return {
    devtool: production ? 'source-maps' : 'eval',

    entry: {
      'js/app.js': './assets/js/app.ts', 
    },

    output: {
      filename: '../priv/static/[name]',
      publicPath: '/',
    },

    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: {
            loader: 'babel-loader',
          },
        },
        {
          test: /\.scss$/,
          use: [
            {loader: 'style-loader'},
            {loader: 'css-loader'},
            {loader: 'sass-loader',
             options: {
               includePaths: ['./node_modules', './node_modules/sass-material-colors/sass']}
             }
          ]
        },
        {
          test: /\.css$/,
          use: [
            'style-loader',
            'css-loader'
          ]
        },
        {
          test: /\.tsx?$/,
          loader: 'ts-loader'
        }
      ],
    },

    resolve: {
      modules: ['node_modules', path.resolve(__dirname, 'js')],
      extensions: ['.js', '.ts', '.tsx'],
    },
  };
};