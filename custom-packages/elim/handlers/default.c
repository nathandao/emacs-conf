/*
Copyright © 2009 Vivek Dasmohapatra 

email : vivek@etla.org
irc   : fledermaus on freenode, oftc
jabber: fledermaus@jabber.earth.li

This file is part of elim.

elim is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

elim is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with elim.  If not, see <http://www.gnu.org/licenses/>.
*/
#include "default.h"

xmlnode * _h_elim_default( const char *name , 
                           const char *id   , 
                           SEXP_VALUE *args , 
                           gpointer data    )
{
    char *out = sexp_to_str( args );
    fprintf( stderr, ";; unknown function %s:\n%s\n;; ++ --\n", name, out );
    g_free ( out );
    sexp_val_free( args );
    return response_error( EINVAL, id, name, "unknown function" );
}
