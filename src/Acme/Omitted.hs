{-|
Module      : Acme.Omitted
Description : A universal definition of omitted content
Copyright   : (c) 2013 Joachim Fasting
License     : BSD3

Maintainer  : joachim.fasting@gmail.com
Stability   : stable
Portability : portable

A universal definition of \"omitted content\", an alternative to
'Prelude.undefined', and methods for observing whether a definition is
merely \"omitted\" or truly \"undefined\".
-}

module Acme.Omitted
  (
    -- * Usage
    --
    -- $usage

    -- * A universal definition of \"omitted content\"
    --
    -- $omitted
    omitted
  , (...)

    -- * \"undefined\" redefined
    --
    -- $undefined
  , undefined

    -- * Observing the difference between \"omitted\" and \"undefined\"
    --
    -- $observing
  , isOmitted
  , isUndefined
  , isPreludeUndefined
  ) where

import Prelude hiding (undefined)
import qualified Control.Exception as E

{-$usage

This module provides an alternative implementation of
\"Prelude.undefined\".
To avoid name clashes with the "Prelude", use a qualified
import or otherwise resolve the conflict.

Use thus

@
module AwesomeSauce where

import Prelude hiding (undefined)
import Acme.Omitted

tooLazyToDefine     = (...)

actuallyUndefinable = undefined

main = do
  merelyOmitted <- 'isOmitted' tooLazyToDefine
  putStrLn \"Definition was merely omitted\"
  (...)
  trulyUndefined <- 'isUndefined' actuallyUndefinable
  putStrLn \"Definition is truly undefinable\"
@
-}

{-$omitted

The difference between \"omitted\" and \"undefined\" is that the
programmer may choose to omit something but she cannot define the
undefinable.
The former is contingent on the whims of the programmer, the latter
a fundamental truth.

Operationally, there is no difference between undefined and omitted;
attempting to evaluate either is treated as an error.

Ideally, programmers would only ever use 'undefined' for things that
are truly undefined, e.g., division by zero, and use 'omitted' for
definitions that have yet to be written or that are currently not needed.
-}

-- | Alternative syntax for 'omitted' that has been carefully
-- optimised for programmer convenience and visual presentation
-- (e.g., for use in printed documents).
--
-- Example usage:
--
--    > definition = (...)
(...) :: a
(...) = omitted

-- | The universal omitted content operator.
--
-- This is sufficient to express _all_ types of omitted content
omitted :: a
omitted = error "omitted"

{-$undefined

Lacking a dedicated name for omitted defintions, users of Standard
Haskell have been left with no choice but to use \"undefined\" for both
the undefinable and the omitted.
This makes the standard implementation of \"undefined\" deficient, we
cannot be sure what the programmer has intended, only that the definition is
missing.
Here is an alternate implementation, similar in most every way to the
standard implementation, but free from conceptual contamination.
-}

-- | Denotes all values that are, fundamentally, undefinable.
--
-- The implicit (as in not statically enforcable) contract of 'undefined'
-- is that it will never be used for merely omitted definitions.
-- For that, see 'omitted'.
undefined :: a
undefined = error "Acme.Omitted.undefined"

{-$observing

Recent developments in the theory of representing undefined things have
made it possible for programmers to more clearly state their intentions,
by using our 'undefined' rather than the one from the Haskell 2010 "Prelude".
There is, however, still no way to statically ensure that 'undefined' is used
correctly.
Consequently, 'isUndefined' will return bogus results every now and then (which is why
it is modelled as an 'IO' action and not a pure function).

Nevertheless, the user can identify incorrect uses of 'undefined' more easily
than before.
To wit, if

@
isUndefined twoPlusTwo = return True
@

then, surely, something is amiss.
We know that the programmer has made the mistake of believing @2+2@ to be undefined,
that she has not simply run out of time or gotten an important phone call while
writing down the solution.

For backwards-compatibility, we also support detecting the standard
implementation of undefined, about which we cannot infer anything
except that its evaluation will terminate with no useful result.
-}

-- | Answer the age-old question \"was this definition omitted?\"
--
-- @
-- isOmitted 0           = return False
-- isOmitted 'undefined' = return False
-- isOmitted 'omitted'   = return True
-- @
isOmitted :: a -> IO Bool
isOmitted = isErrorCall "omitted"

-- | ... or is it really 'undefined'?
--
-- @
-- isUndefined 0           = return False
-- isUndefined 'undefined' = return True
-- isUndefined 'omitted'   = return False
-- @
isUndefined :: a -> IO Bool
isUndefined = isErrorCall "Acme.Omitted.undefined"

-- | A version of 'isUndefined' for \"Prelude.undefined\".
isPreludeUndefined :: a -> IO Bool
isPreludeUndefined = isErrorCall "Prelude.undefined"

isErrorCall :: String -> a -> IO Bool
isErrorCall s x = (E.evaluate x >> return False)
                  `E.catch` (\(E.ErrorCall e) -> return $ e == s)
