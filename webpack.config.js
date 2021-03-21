var path = require('path');
var glob = require('glob');

const root = __dirname;
const resolve = uri => path.resolve(root, uri);

module.exports = {
    entry: { 'handlers' : glob.sync('./src/**/*.ts*') },
    target: "node",
    devtool: "source-map",
    mode: 'production',
    resolve: {
        modules: [resolve("./node_modules")],
        alias: {
            "#enterprise": resolve("src/1-enterprise"),
            "#application": resolve("src/2-application"),
            "#adapter": resolve("src/3-adapter"),
            "#framework": resolve("src/4-framework")
          },
        extensions: ['.ts', '.js'] //resolve all the modules other than index.ts
    },
    externals: [
        /^aws-sdk/i,
        /^dynamoose/i,
      ],
    resolveLoader: {
    modules: [resolve("./node_modules")]
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                use: ["source-map-loader"],
                enforce: "pre"
              },
              {
                test: /\.(ts|js)$/,
                include: [resolve("src")],
                exclude: [/node_module/],
                use: [
                  {
                    loader: "babel-loader"
                  },
                  {
                    loader: path.resolve("di.js"),
                    options: {
                      dependencies: [
                        {
                          whenImport: /#application\/repositories\/i(\w*)/g,
                          dependency: (v, $1) =>
                            `#framework/repositories/${firstLower($1)}`
                        },
                        {
                          whenImport: /#application\/services\/i(\w*)/g,
                          dependency: (v, $1) =>
                            `#framework/services/${firstLower($1)}`
                        }
                      ]
                    }
                  }
                ]
              }
        ]
    },
    optimization: {
      providedExports: true,
      usedExports: true,
      sideEffects: true,
      minimize: false
    },
    stats: {
      colors: true,
      hash: false,
      version: true,
      timings: true,
      assets: true,
      chunks: false,
      chunkGroups: false,
      chunkModules: false,
      chunkOrigins: false,
      children: false,
      source: true,
      errors: true,
      errorDetails: true,
      warnings: true,
      warningsFilter: /export .* was not found in/,
      publicPath: false,
      maxModules: 100,
      modules: false,
      moduleTrace: false,
      reasons: false,
      usedExports: true
    }
      
}