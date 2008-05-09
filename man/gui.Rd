\name{gui}
\alias{gui}
\alias{guiNestedF}
\alias{guiExec}
\alias{guiFormals}
\alias{mgui}
\alias{fguiNewMenu}
\alias{fguiWindow}
\alias{fguiWindowPrint}
\title{fgui Main Function}
\description{
Rapidly create a GUI interface for a function you created by automatically creating widgets for arguments of the function. Automatically parses help routines for context-sensative help to these arguments. The interface is essentially a wrapper to some tcltk routines to both simplify and facilitate GUI creation. More advanced tcltk routines/GUI objects can be incorporated into the interface for greater customization for the more experienced.

The examples are probably the quickest/easiest way of understanding what this code does.

Use \code{getFromNamespace} and \code{assignInNamespace} to customize any of the widget drawing routines (described elsewhere) that are not to your tastes, or alter the source code (get from CRAN so you get one with comments).

\code{gui} is the main routine, with \code{guiNestedF} providing a means for nested forms (see examples). Along with this is \code{guiFormals}, a modification of the \code{formals} routine to deal with issues.

\code{guiExec} provides the means for `immediate' updates, e.g. for power interfaces; see examples for exactly how to do this.

On the next level, \code{mgui} creates a menuing interface when you want to have seperate routines to create multiple graphical widgets. For example, when converting multiple command line routines in an R package. Just use \code{mgui} instead of \code{fgui}, for the most part -- but if you want the interface modal, only do so on the last mgui call. The functions \code{fguiNewMenu}, \code{fguiWindow}, and \code{fguiWindowPrint} provide lower level workings for this. \code{fguiNewMenu} allows for more general menu additions. \code{fguiWindow} allows for more options in creating the main window (otherwise it is automatically created on the first \code{mgui} call). \code{fguiWindowPrint} prints directly to the console, although many times this is also caught by other routines.
}
\usage{
gui( func,
     argOption=NULL, argFilename=NULL, argList=NULL, argSlider=NULL,
      argCommand=NULL, argEdit=NULL, argFilter=NULL,
     argText=NULL, argType=NULL,
     argGridOrder=1:length(formals(func)), sticky="nws",
     title=NULL,
     exec="Calculate ...",
     callback=NULL,
     output='m',
     helps='auto', helpsFunc=NULL,
     grid=TRUE, modal=TRUE, nameFix=TRUE, getFix=TRUE,
     verbose=FALSE )
guiNestedF( func, nestArg, title=nestArg, exec=NULL, output=NULL, ... )
guiExec( lastTouched=NULL )
guiFormals( func, object )

mgui( func,
      argOption=NULL, argFilename=NULL, argList=NULL, argSlider=NULL,
      argCommand=NULL, argEdit=NULL, argFilter=NULL,
      argText=NULL, argType=NULL,
      argGridOrder=1:length(formals(func)), sticky="nws",
      title=NULL,
      exec="Calculate ...",
      callback=NULL,
      output='m',
      helps='auto', helpsFunc=NULL,
      grid=TRUE, modal=TRUE, nameFix=TRUE, getFix=TRUE,
      verbose=FALSE )
fguiNewMenu( menuText, command=function(){print(paste(menuText,collapse=" > "))} )
fguiWindow( basicMenu=TRUE, title="fgui", text="Please choose an option from the menu." )
fguiWindowPrint( text, endl=TRUE )
}
\arguments{
  \item{func}{The function that should be called upon execution. The one required argument.}

  \item{argOption}{list of options vectors (names should be the same as args of provided function `func', makes the arg become an option widget)}
  \item{argList}{list of strings for lists (names should be the same as args), makes arg be a list widget, which can be customized on the fly (an option cannot be, and has limited size)}
  \item{argSlider}{list of slider ranges (names should be the same as args), makes arg be a slider/range}
  \item{argCommand}{list of functions to execute on command (names same as args), makes arg be a command button}
  \item{argEdit}{list of (width,height) both optional (names same as args), NULL/NA/missing for default, makes arg be an edit box}
  \item{argFilter}{list of file filters (empty for all files, names same as args), makes arg be a file choosing widget}
  \item{argFilename}{list of default filenames (names same as args), makes arg be a file choosing widget}
  \item{argText}{list of default text for text boxes (names same as args), makes arg be a text box (which is the default anyway).}
  \item{argGridOrder}{Order to be gridded; if two objects have the same order, they will be gridded side by side.}

  \item{title}{Window title, defaults to function name.}

  \item{argType}{
    Unspecified is auto-detected, and is strongly recommended (only necessary for `i'). List of the types of each of your arguments, with the name being the same as the argument name.
    `t': text entry.
    `s': slider.
    `f': input for filenames.
    `o': options box (options are put in argOption).
    `l': list box (lists are put in argList, which is 'set', and can be modified by user).
    `c': command button.
    `m': multi-line text entry.
    `i': ignore - option will not be drawn, and the default will be used [not fully tested, try creating a seperate function and using the helpsFunc option].
  }
  \item{exec}{String to use when user should press a button to have them call your function. Empty indicates it should not be drawn (e.g. power interfaces, where you might desire sliders, and an auto-updating answer).}
  \item{callback}{Name of function to handle callbacks, that takes one parameter, a string for the arg that was updated.}
  \item{output}{one of the above, `t', `s', `m', or NULL; will try to auto-choose this as well. If not `m', then an initial value will be set by running the default parameters.}

  \item{helps}{`auto' indicates it will try to load in the help from the package help, if possible. Otherwise this can be a list of strings (with the function argument name for the names) for help.}
  \item{helpsFunc}{NULL indicates it will use the name of the function. If a string is provided, it will try to load the help on the function specified by that string instead.}

  \item{grid}{whether to grid the objects or not (otherwise, just let the user do it)}
  \item{modal}{lock input away from R, suggested}
  \item{nameFix}{boolean, tries to fix names (replaces underscore and period with a space).}
  \item{getFix}{boolean, tries to fix strings that represent R objects - so for instance, if a user wanted to user the dataset 'rivers', they would only need to type 'rivers' (without the quotation marks) to represent the dataset.}

  \item{sticky}{A combination of 'news' for placement.}
  \item{verbose}{Prints out verbose output. Only useful to try to understand what it is doing if you are wanting to customize.}

  \item{nestArg}{Name of the argument to be nested, see examples.}
  \item{...}{Options to nestArg that are passed on to the gui function, so everything you see above.}

  \item{lastTouched}{Not used. Required to have conformity with callback routines.}

  \item{object}{See below, only for nested forms.}

  \item{menuText}{An array of strings representing the menu. E.g. c("File","Exit").}
  \item{command}{Command to be run on click.}
  \item{basicMenu}{Inserts a basic menu (File, etc.).}
  \item{text}{Text in the text box for the gui choosing interface.}
  \item{endl}{Whether to insert a carriage return.}
}
\value{
  Returns a list of the arguments user chose after termination.
}
\details{
  Examples are strong recommended to get the idea of what this does. The reference below is a great one for learning how to use tcltk.
}
\examples{

\dontrun{
##################################################
## *** EXAMPLE 1 ***                            ##
## Basic example of available graphical objects ##

## our function to base the GUI on
demofunc <- function( opt, lst, slide, cmd, ed, txt, flname ) {
  ## Returns a string of output, this will be displayed
  return( paste( "opt:",    opt,
                 "lst:",    paste(lst,collapse=","),
                 "slide:",  slide,
                 "ed:",     ed,
                 "txt:",    txt,
                 "flname:", flname,
                 sep="\n" ) )
}
## Simple callback example
cmdCallback <- function() {
  tkmessageBox( message="Hello World :)", title="A Classic" )
}
## start the gui
res <- gui( demofunc,
            argOption=list(opt=c("TRUE","FALSE")), ## names in list are that of args in func
            argList=list(lst=c(as.character(1:10))),
            argSlider=list(slide=c(0,100,2.5)),   ## start,stop,stepsize
            argCommand=list(cmd=cmdCallback),
            argEdit=list(ed=NULL), ## otherwise (width,height) to tweak, default
            argFilter=list(flname="{{Text files} {.txt}}") )  ## note space inbetween the braces!
## prints out the arguments the user chose
print( res )
}

\dontrun{
########################
## ** EXAMPLE 2 ***   ##
## Auto-loading help! ##
## This is extremely useful if you write your own R package
##  and want to include help with the GUI with no fuss.

## This is what this looks like
help("rnorm")
## Now build a gui
gui( rnorm )

## Now, suppose we wanted to customize it,
##  but we really want to keep all that help...
rnorm2 <- function( n=10, mean=1, sd=2 ) {
  res <- rnorm( n=n, mean=mean, sd=sd )
  return( paste( res, collapse=", " ) )
}
gui( rnorm2, helpsFunc="rnorm" )
}

\dontrun{
######################
## ** EXAMPLE 3 *** ##
## Power interface  ##

ss <- function( alpha=0.05, beta=0.8, sigma=2, effect_size=0.5 ) {
  n <- ceiling(  (qnorm(1-alpha/2) + qnorm(1-beta))^2 * sigma^2 / effect_size^2  )
  print(n)
  return(n)
}
## Create the gui
## Note 1: the use of output in the slider
## Note 2: callback set to the 'guiExec' (fixed) routine,
##          so 'ss' is run with the proper arguments
##          whenever a slider value is changed
gui( ss,
     argSlider=list(alpha=c(0,0.1,0.001),
                    beta=c(0,1,0.01),
                    sigma=c(0,10),
                    effect_size=c(0,10),
                    output=c(0,10000,1)), ## Note the use of output here
     exec=NULL, ## don't draw an execute button
     callback=guiExec
    )
}

\dontrun{
#################################
## *** Example 4 ***           ##
## Sliders setting each other. ##
## You can envision this for more complicated power interfaces
##  that do both calculating power and solving for sample
##  sizes...
## Also includes non-auto help, a waste to bother with
##  if you are planning on creating a package

## Change a default for fun, see `guiSet' function
##  for more details/options
guiSet( "SLIDER_LENGTH", 400 )


sli <- function( alpha=0.5, beta=0.5 ) {
  ## Nothing to do...
}
sliCallback <- function( lastTouched ) {
  if( lastTouched=="alpha" )
    guiSetValue("beta",guiGetValue("alpha"))  ## setting beta to be alpha
  if( lastTouched=="beta" )
    guiSetValue("alpha",guiGetValue("beta"))  ## setting alpha to be beta
}
gui( sli,
     argSlider=list(alpha=c(0,1), beta=c(0,1)),
     output=NULL, exec=NULL, callback=sliCallback,
     helps=list(alpha="type I error", beta="power") )
}

\dontrun{
###############################
## *** EXAMPLE 5 ***         ##
## Parsing R objects example ##
## Suppose you want a user to be able to enter a vector of data,
##  then you can use the following as an example for that.
summaryStats <- function( data ) {
  return( paste( "Mean = ", mean(data), ", Variance = ", var(data), sep="" ) )
}

gui( summaryStats, helps=list(data="Enter the data as an R vector, e.g. 'c(13,66,44,27)' or enter the text 'rivers' to use a builtin dataset (without quotes).") )
}

\dontrun{
###############################
## *** EXAMPLE 6 ***         ##
## Advanced nesting example. ##
## Suppose we have a function 'f', which has too many
##  arguments to comfortably fit on one screen.
f <- function( a=1, b=2, c=3, d=4, e=5, f=6 ) {
  print( "Running f" )
  return( paste( "a =", a, "\n",
                 "b =", b, "\n",
                 "c =", c, "\n",
                 "d =", d, "\n",
                 "e =", e, "\n",
                 "f =", f, "\n", sep="" ) )
}
## Say we split into two functions/forms
f1 <- function( a=1, b=2, c=3 ) {
  print( "Running f1" )
  return( list(a=a,b=b,c=c) )
}
f2 <- function( d=4, e=5, f=6 ) {
  print( "Running f2" )
  return( list(d=d,e=e,f=f) )
}
## Then our main gui function could be
guif <- function( abc, def ) {
  print( "guif" )

  print( "guif: abc" )
  print( abc )
  print( "guif: def" )
  print( def )

  f <- guiFormals( f, c(abc,def) )
  f()
}
gui( guif, argCommand=list(abc=guiNestedF(f1,"abc"), def=guiNestedF(f2,"def")) )
}

###############################
## *** EXAMPLE 7 ***         ##
## The menuing interface.    ##
## Call just as you would gui, same options, same everything,
##  EXCEPT title is now a vector indicating the menu path.
## If you want it modal though, do not do so until the last mgui call, or it will be modal inbetween additions to the menu!
\dontrun{
fguiWindowPrint( "Goes to the console because no window has been created." )
mgui( rgeom, title=c("Random","Geometric") )
mgui( rbinom, title=c("Random","Binomial") )
fguiNewMenu( c("Random","SEPARATOR") ) ## Puts a separator in the menu
mgui( rnorm, title=c("Random","Normal") )
mgui( runif, title=c("Random","Uniform") )
fguiWindowPrint( "Goes to the main window, now that it has been created." )
}
}
\references{
Dalgard, Peter and Wettenhall, James. R tcltk examles. \url{http://www.sciviews.org/_rgui/tcltk/index.html}
}
\keyword{interface}
