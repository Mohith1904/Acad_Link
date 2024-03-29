var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var connectToMongo = require('./db');
const multer = require('multer');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/auth');
var postRouter  = require('./routes/post');
var proposalRouter = require('./routes/proposal');
var profileRouter = require('./routes/profile');
var qnaRouter = require('./routes/qna');
var filterRouter = require('./routes/filter')


var app = express();
const port = process.env.PORT || 5000 ;

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/posts',postRouter);
app.use('/proposal',proposalRouter);
app.use('/profile',profileRouter);
app.use('/qna' ,qnaRouter);
app.use('/',filterRouter)

connectToMongo();
//catch 404 and forward to error handler
// app.use(function(req, res, next) {
//   next(createError(404));
// });

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});



// // Set up storage engine
// const storage = multer.diskStorage({
//   destination: function(req, file, cb) {
//       cb(null, 'public/');
//   },
//   filename: function(req, file, cb) {
//       cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
//   }
// });







app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

app.get('/ping',(req,res)=>{
  res.send('pong')
})

module.exports = app;
