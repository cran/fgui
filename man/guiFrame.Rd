\name{guiFrame}
\alias{guiFrame}
\alias{guiTextEntry}
\alias{guiSlider}
\alias{guiFilename}
\alias{guiOption}
\alias{guiList}
\alias{guiEdit}
\alias{helpButton}
\alias{getSelectedListElements}
\alias{setListElements}
\title{Various Graphical Widgets}
\description{
  Creates various graphical objects, used internally by the `gui' routine, but exported in case useful and as examples of further customization. Try \code{getFromNamespace} and \code{assignInNamespace} to fully customize these routines in your own code. Documentation in tcltk may also help.

  \code{guiFrame} creates a frame.

  \code{guiTextEntry} creates a short one-line text entry.

  \code{guiSlider} creates a slider with a range of values to choose, useful for power calcs.

  \code{guiFilename} provides a means to get filenames.

  \code{guiOption} allows a choice of options.

  \code{guiList} allows a choice of greater options, which can be modified later. \code{setListElements} and \code{getSelectedListElements} are routines to dynamically set these lists and get the selected elements.

  \code{guiEdit} is an edit box.

  \code{helpButton} creates a helpButton.
}
\usage{
guiFrame( sframe, grid=FALSE, relief="groove",
           borderwidth=2, sticky="nws" )

guiTextEntry( sframe, text, default, width=NULL, helps=NULL )
guiSlider( sframe, text, default, min, max, step=(max-min)/100,
            update=NULL, state="enabled", helps=NULL )
guiFilename( sframe, text="Filename ...", default="", title="",
              filter="{{All files} {.*}}", callback=NULL, helps=NULL )
guiOption( sframe, text, choices, defaultChoice=1,
            update=NULL, helps=NULL )
guiList( sframe, text, name=text, update=NULL, helps=NULL )
guiEdit( sframe, text="", default="", width=NULL, height=NULL,
          readonly=FALSE, helps=NULL )
helpButton( sframe, helps, title )

getSelectedListElements( name )
setListElements( name, elements )
}
\arguments{
  \item{sframe}{The tkframe to grid upon.}

  \item{grid}{Whether the object should be gridded or not. Default is FALSE, so user can grid objects together.}
  \item{relief}{tkframe option}
  \item{borderwidth}{tkframe option}
  \item{sticky}{Combination of `nwes' for stickiness of object.}

  \item{text}{The text of the object, to describe it to the user.}
  \item{default}{Default value for an object.}
  \item{min}{min of slider range}
  \item{max}{max of slider range}
  \item{step}{stepsize of slider range}
  \item{update}{function to send callbacks to, should take one argument (see examples in 'gui' routine)}
  \item{state}{e.g. `readonly', see tcltk docs}
  \item{helps}{An optional string of help to be given when a user clicks the `?' button to provide more information. If NULL, no such button is drawn.}

  \item{title}{Title for the window.}
  \item{filter}{File filter, see examples in 'gui' for the form.}
  \item{callback}{Callback function. For command function, both `callback' and `update' functions are performed.}

  \item{choices}{List of possible choices.}
  \item{defaultChoice}{Default choice to choose, the numeric index to this.}

  \item{name}{Identifier.}
  \item{width}{Width of the edit box.}
  \item{height}{Height of the edit box.}
  \item{readonly}{Whether to create in readonly state.}

  \item{elements}{Array of strings for the list elements.}
}
\details{
  \code{tkFrame} and \code{helpButton} return the tcltk object reference.

  The other routines return a list. The first object, \code{object}, is either a tclVar or the string `no object' for things like command buttons where this does not make sense (use \code{main<-tktoplevel(); res<-tkFrame(main); tclvalue(res$object)}, e.g., to get the value). The second object, \code{guiObject} returns a reference to the tcltk frame gui the object is contained in for gridding purposes.
}
\keyword{interface}
