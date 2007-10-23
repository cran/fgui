\name{guiGetValue}
\alias{guiGetValue}
\alias{guiGetAllValues}
\alias{guiSetValue}
\alias{guiSet}
\alias{guiGet}
\alias{guiGetSafe}
\title{Getting and Setting Values}
\description{
\code{guiGetValue} and \code{guiGetAllValues} are used for getting the values of the objects that you created. This is useful to make more customized responses to user inputs.

The guiGet and guiSet routines get at more internal code to the interface. In particular guiSet can set some internal constants.
}
\usage{
guiGetValue <- function( i )
guiGetAllValues()
guiSetValue( i, value )

guiSet( x, value )
guiGet( x, mode="any", ifnotfound=NA )
guiGetSafe( x, ifnotfound=NA )
}
\arguments{
  \item{i}{Which item in the list to return. If a string, the name of the corresponding arg. If numeric, the index to the arg.}
  \item{x}{String to represent the object. See examples below for constants.}
  \item{mode}{}
  \item{ifnotfound}{Value to return if not found.}
  \item{value}{Value to set in the namespace.}
}
\details{
\code{guiGetAllValues} returns a list of all values of objects created, versus just one specific value. Values are returned as strings, or numeric, depending on the value (it attemps to convert everything to numeric, on failure, returns the string).

\code{guiSet} can be used to set values.
}
\examples{
\dontrun{
values <- guiGetAllValues()
value1 <- guiGetValue(1)
}

\dontrun{
## These are the constants that you can modify
##  to change the way things are displayed.
guiSet( "SLIDER_LENGTH", 500 )
guiSet( "ENTRY_WIDTH", 40 )
guiSet( "LIST_HEIGHT", 15 )
guiSet( "LIST_WIDTH", 15 )
guiSet( "EDIT_WIDTH", 65 )
guiSet( "EDIT_HEIGHT", 5 )
}
}
\keyword{interface}
