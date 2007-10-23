readFile <- function( filename ) {
  f <- file(filename)
  lines <- readLines(filename)
  close( f )
  #print( lines )
  return( lines )
}

STRTRIM <- function( str ) {
  ## leading spaces
  str <- sub('[[:space:]]*', '', str)
  ## lagging spaces
  return( sub('[[:space:]]*+$', '', str) )
}

parseArguments <- function( lines ) {
  ## first separate into a list of strings
  cur <- 0
  lastEmpty <- FALSE
  res <- c()
  for( l in 1:length(lines) ) {
    if( lines[l]=="" ) {
      if( cur!=0 && lastEmpty==FALSE )
        cur<-cur+1
      lastEmpty<-TRUE
    }else{
      lastEmpty<-FALSE
      if( cur==0 ) cur <- 1

      #print( l )
      #print( res )
      ## ideally, we would want to trim lines[l], but I can't figure out how
      if( length(res) < cur ) {
        res[cur] <- STRTRIM(lines[l])
      }else{
        res[cur] <- paste( res[cur], STRTRIM(lines[l]), sep=" " )
      }
    }
  }

  ## Then split each list of strings on the _first_ ':'
  resNames <- c()
  for( i in 1:length(res) ) {
    spl <- unlist( strsplit( res[i], ":" ) )
    resNames[i] <- STRTRIM(spl[1])

    spl <- spl[-1]
    spl[1] <- STRTRIM(spl[1]) ## because of the : operator...
    res[i] <- paste( spl, collapse=":" )
  }
  names(res) <- resNames
  #print( resNames )

  return(res)
}

#splitOnColons <- function( lines ) {
#
#  colonLines <- c( grep( ":", lines ), length(lines) )
#
#  res <- list()
#  for( cl in 1:(length(colonLines)-1) ) {
#
#    ## split var and descr on colon
#    spl <- unlist(strsplit(lines[colonLines[cl]],":"))
#    print( spl )
#    option <- spl[1]
#    spl <- spl[-1]
#    optionDesc <- paste( spl, collapse=":" )
#
#    ## and put in the rest of the descr if there is one
#    if( colonLines[cl] != colonLines[cl+1]-1 )
#      optionDesc <- paste( optionDesc,
#                           subset( lines, (colonLines[cl]+1):(colonLines[cl+1]-1) ),
#                           collapse="\n" )
#
#    ## and put it in the results
#    cur <- length(res)+1
#    res[[cur]] <- optionDesc
#    names(res)[cur] <- option
#  }
#
#  return( res )
#}

parseHelp <- function( func ) {
  filename <- help( func, offline=FALSE, chmhelp=NA, htmlhelp=NA )[[1]]

  if( !file.exists(filename) ) {
    ## It might be in a zip file in windows, lets try to extract it

    ## parse off the function name
    funcname <- unlist( strsplit( filename, "/" ) )
    funcname <- funcname[[length(funcname)]]

    ## get the path to the zip file
    ziparchive <- paste( substr( filename, 1, nchar(filename)-nchar(funcname) ), "Rhelp.zip", sep="" )
    if( file.exists(ziparchive) ) {
      ## then we _can_ extract it
      #filename <- zip.file.extract( funcname, ziparchive )
      ## Arghhh!!!! Sometimes I really, _really_ hate R
      tmpd <- tempdir()
      rc <- .Internal( int.unzip(ziparchive,funcname,tmpd) )
      if( rc==0 )
        filename <- attr(rc,"extracted")
    }
  }

  ## Read in all of the lines
  lines <- readFile( filename )

  ## Extract out the relevant lines
  lineStart <- unlist( lapply( lines, substr, start=1, stop=2 ) )
  section <- which( lineStart == "_\b" )
  usageSection <- which( lines == "_\bA_\br_\bg_\bu_\bm_\be_\bn_\bt_\bs:" )

  sectionSection <- which( usageSection==section )
  if( sectionSection == length(section) )
    section <- c(section, length(lines)+1)
  usageLinesB <- section[sectionSection]+1
  usageLinesE <- section[sectionSection+1]-1
  lines <- lines[usageLinesB:usageLinesE]

  return( parseArguments(lines) )
}

## DEBUG ONLY
#lmHelp <- parseHelp( "lm" )