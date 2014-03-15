module.exports = (grunt) ->
    @loadNpmTasks('grunt-bump')
    @loadNpmTasks('grunt-contrib-clean')
    @loadNpmTasks('grunt-contrib-coffee')
    @loadNpmTasks('grunt-contrib-watch')
    @loadNpmTasks('grunt-mocha-cli')

    @initConfig
        clean:
            dist: ['lib']

        coffee:
            options:
                bare: true
            all:
                expand: true,
                cwd: 'src',
                src: ['*.coffee'],
                dest: 'lib',
                ext: '.js'

        watch:
            all:
                options:
                    atBegin: true
                files: ['src/**.coffee', 'test/*{,/*}']
                tasks: ['test']

        mochacli:
            options:
                files: 'test/*.coffee'
                compilers: ['coffee:coffee-script']
                harmony: true
            spec:
                options:
                    reporter: 'spec'

        bump:
            options:
                files: ['package.json']
                commitFiles: ['-a']
                pushTo: 'origin'

    @registerTask 'default', ['test']
    @registerTask 'build', ['clean', 'coffee']
    @registerTask 'test', ['build', 'mochacli']
