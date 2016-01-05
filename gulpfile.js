var gulp = require('gulp');
var sass = require('gulp-sass');
var autoprefixer = require('gulp-autoprefixer');
var coffee = require('gulp-coffee');
var concat = require('gulp-concat');

gulp.task('default', ['sass', 'coffee']);

gulp.task('coffee', function() {
    return gulp.src('coffee/*.coffee')
        .pipe(concat('twbs-material.js'))
        .pipe(coffee())
        .pipe(gulp.dest('dist/js'))
});

gulp.task('sass', function () {
    return gulp.src('sass/twbs-material.sass')
        .pipe(sass().on('error', sass.logError))
        .pipe(autoprefixer({
            browsers: ['last 3 versions'],
            cascade: false
        }))
        .pipe(gulp.dest('dist/css'));
});

gulp.task('image-optimization', function () {
    var imagemin = require('gulp-imagemin');
    return gulp.src('img/**/*')
        .pipe(imagemin())
        .pipe(gulp.dest('img'));
});