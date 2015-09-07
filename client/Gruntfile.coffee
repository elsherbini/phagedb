mountFolder = (connect, dir)->
  return connect.static require('path').resolve(dir)


module.exports = (grunt) ->

  appConfig = {
    src: 'src'
    app: 'app'
    tmp: '.tmp'
    serverPort: 9000
    liveReloadPort: 35729
  }

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-less')
  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-open')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-handlebars')

  grunt.initConfig(

    app: appConfig

    coffee:
      dist:
        expand: true
        cwd: '<%= app.src %>/coffee/'
        src: ['{,**}/*.coffee']
        dest: '<%= app.tmp %>/js'
        ext: '.js'

    less:
      dist:
        files: [
            '<%= app.tmp %>/css/bootstrap.css' : '<%= app.app %>/components/bootstrap/less/{bootstrap,responsive}.less'
            '<%= app.tmp %>/css/main.css' : '<%= app.src %>/less/*.less'
        ]

    handlebars:
      compile:
        options:
          namespace: false
          amd: true
        expand: true
        cwd: '<%= app.app %>/templates/'
        src: ['{,**}/*.hbs']
        dest: '<%= app.tmp %>/js/templates'
        ext: '.js'

    connect:
        options:
            port: 9000
            livereload: 35729
            open: true
            hostname: 'localhost'
        livereload:
          options:
            base: [
                '<%= app.tmp %>',
                '<%= app.app %>'
            ]

    watch:
      livereload:
          options:
            livereload: '<%= connect.options.livereload %>'
          files: [
            '<%= app.app %>/{,*/}*html'
            '<%= app.tmp %>/{,*/}*js'
            '<%= app.tmp %>/*/css'
          ]
      coffee:
        files: ['<%= app.src %>/coffee/{,**/}*.coffee']
        tasks: ['coffee:dist']

      less:
        files: ['components/bootstrap/less/{bootstrap,responsive}.less']
        tasks: 'less:dist'

      handlebars:
        files: ['<%= app.app %>/templates/{,*/}*hbs']
        tasks: ['handlebars:compile']

      files:
        files: [
          '<%= app.tmp %>/{,**/}*.{css,js}'
          '<%= app.app %>/{,**/}*.html'
        ]
        tasks: []
  )

  grunt.registerTask('server', [
    'coffee:dist'
    'less:dist'
    'handlebars:compile'
    'connect:livereload'
    'watch'
  ])
