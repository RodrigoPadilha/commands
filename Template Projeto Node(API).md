# Criar Diretório do Projeto
    mkdir FOLDER && cd FOLDER
<br>

# Criar Projeto Node
```
  yarn init -y
```
<br>

# Typescript
## Instalar Typescript
```
  yarn add typescript -D
  yarn add ts-node-dev -D
```

## Configurar Typescript (tsconfig.json)
```
  yarn tsc --init
```

**tsconfig.json**        
```js
{
  "compilerOptions": {
    "target": "es2017",                       // Versão do EcmaScript
    "lib": ["es6"],
    "allowJs": true,                          // Permite importar arquvio Javascript dentro de arquivos TypeScript
    "outDir": "./dist",                       // Pasta para o build da aplicação
    "rootDir": "./src",                       // Local onde ficam os arquivos T(não pode retornar null de função tipada para retornar string)
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true,
    "module": "commonjs",        
    // Permite sobrscrever tipagem de outras bibliotecas TypeScript
    "typeRoots": [
      "./node_modules/@types",
      "./src/@types"
    ],
    "resolveJsonModule": true,                // Permite importar arquivos JSON dentro do código          
    "removeComments": true,                   // Remove comentários durante o build
    "esModuleInterop": true,                  // Habilita o uso de Decorators (Ex.: em ORM's)
    "forceConsistentCasingInFileNames": true,
    "strict": false,                          // Força o uso de tipagem em tudo 
    "noEmitOnError": true,
    //"strictNullChecks": true,
    "skipLibCheck": true
  },  
  // Config do Jest para poder fazer o import do tsconfig.json em jest.config.js
  // Faz com que o TypeScript não compile o arquivo jest.config.js            
  "include": [
    "src/**/*"
  ]
}
```

## Config @Paths
```
  yarn add tsconfig-paths -D`
  mkdir src
  mkdir src/@types
  mkdir src/models src/controllers src/views src/config
```

Incluir no arquivo **tsconfig.json** os caminhos que devem ser mapeados:

**tsconfig.json**
```js
{
  "compilerOptions":{
    ...
    // PATHS: tsconfig-paths -> Adicionar este trecho de código
    "baseUrl": ".",     // Caminho inicial para o path fazer o mapeamento
      "paths": {
        // Sempre que um import iniciar com "@models" é feito um mapeamento para o caminho do array
        "@models/*": [            
          "./src/models/*"
        ],
        "@controllers/*": [
          "./src/controllers/*"
        ],
        "@views/*": [
          "./src/views/*"
        ],
        "@config/*": [
          "./src/config/*"
        ]
      }, 
  }
  ...
}
```
<br>

# EsLint
## Install EsLint
```
  yarn add eslint -D
```
## Configura EsLint
```
  yarn eslint --init 
```
Selecione as opções:
  * To check syntax, find problems, and enforce code style
  * JavaScript modules (import/export)
  * None of this 
  * Yes 
  * Node 
  * Use a popular style guide
  * Airbnb 
  * JSON 
  * No


`Instalar dependências sugeridas (COPIAR E COLAR no terminal)`
```js
  //Exemplo:
  yarn add @typescript-eslint/eslint-plugin@latest eslint-config-airbnb-base@latest eslint@^7.32.0 || ^8.2.0 eslint-plugin-import@^2.25.2 @typescript-eslint/parser@latest -D
```

`Inslatar a depenência para os imports dos paths:`
```
  yarn eslint-import-resolver-typescript -D
```

Incluir no arquivo Eslint.rc:

**eslint.rc.json**
```js
{
  ...  

  "rules": {
    "semi": [
            2,
            "always"
        ],
    "import/no-unresolved": "error",
    "import/extensions": [
      "error",
      "ignorePackages",
      {
        "js": "never",
        "jsx": "never",
        "ts": "never",
        "tsx": "never"
      }
   ]
  },
  "settings": {
    "import/parsers": {
      "@typescript-eslint/parser": [
                ".ts",
                ".tsx"
      ]
    },
    "import/resolver": {
            "typescript": {
                "alwaysTryTypes": true,
            }
    }
}
```

## Opcional:
Habilitar as correções automáticas quando salvar arquivos:

**settings.json**
```js
  {
    ... 
    "editor.codeActionOnSave":{ "source.fixAll.eslint":true } 
    ...
  }
```
<br>


# JEST
## Instalar JEST
```
  yarn add jest -D
  yarn add ts-jest -D     // Para o Jest funcionar com o TypeScript
  yarn add @types/jest -D
```

## CONFIG JEST
```
  yarn jest --init
```
Selecione as opções:
  * Yes
  * No
  * node
  * No
  * babel
  * Yes

## Configurar no .eslintrc.json
**eslintrc.json**
``` js
  "env":{
      "jest": true    // Add essa linha para que  não seja apresentado erros em palavras como "expected", etc
  }
```

## Editar o arquivo jest.config.json
```javascript
    const {compilerOptions} = require('./tsconfig.json');
    const {pathsToModuleNameMapper} = require('ts-jest/utils');     
    // Converte os PATHS definidos no tsconfig.json par ao Jest
    module.exports = {
      ...      
      moduleNameMapper: pathsToModuleNameMapper(compilerOptions.paths, {prefix: '<rootDir>'}),    
      ...

      // Mapeamento dos caminhos Path
      preset: 'ts-jest',
      ...
    }
```

## Criar diretório para arquivos de testes
```
  mkdir src/__tests__
```
<br>


# BABEL
## Instalar Babel
```
  yarn add @babel/cli @babel/core @babel/node @babel/preset-env @babel/preset-typescript babel-plugin-module-resolver -D
```

## Criar arquivos
**.eslintignore** (incluir diretórios dist e arquivos .js)
```
  touch .eslintignore && echo dist >> .eslintignore && echo /*.js >> .eslintignore
```
**babel.config**
```
  touch babel.config.js
```


## Configurar o Babel
**babel.config**
```
module.exports = {
  presets: [
    [
      '@babel/preset-env',
      {
        targets: {
          node: 'current'   // Essa configuração faz a conversão para node na versão current (instalada atualmente)
        }
      }
    ],
    '@babel/preset-typescript'  // Preset do TypeScript para entender o código em ".ts"
  ],
  plugins: [
    ['module-resolver', {
      alias: {
        src: './src',
        '@models': './src/models',
        '@controllers': './src/controllers',
        '@views': './src/views',
        '@config': './src/config'
      }
    }]
  ],
  ignore: [
    '**/*.spec.ts'
  ]
}
```
<br>

# Configurar Scripts
**package.json**
```js
{
  ...
  "scripts": {
    "build": "babel src --extensions \".js,.ts\" --out-dir dist --copy-files --no-copy-ignored",
    "start": "NODE_ENV=production node dist/index.js",
    "dev": "NODE_ENV=development ts-node-dev -r tsconfig-paths/register --respawn --transpile-only --ignore-watch node_modules --no-notify src/index.ts",
    "test": "jest"
  },
  ...
}

```
<br>

# API
## Libs e Ferramentas
```  
  yarn add express
  yarn add cors
  yarn add dotenv
  yarn add @types/cors -D
  yarn add @types/express -D
```
## Ambiente
```  
  touch development.env && echo PORT=3000 >> development.env
  touch production.env && echo PORT=8000 >> production.env
```
<br>

# GIT 
## Criar ".gitignore" e adicionar:
```js
  touch .gitignore && echo node_modules >> .gitignore && echo dist >> .gitignore
```
## Inicializar Versionamento
```
  git init
  git add .
  git commit -m "Primeiro Commit"
```
