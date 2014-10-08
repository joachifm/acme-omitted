{-|
Module      : Acme.Undefined
Description : Undefined redefined
Copyright   : (c) 2013-2014 Joachim Fasting
License     : BSD3

Maintainer  : joachifm@fastmail.fm
Stability   : stable
Portability : portable

This module provides an alternative implementation of
\"Prelude.undefined\", intended exclusively for denoting
truly undefinable values.
-}

module Acme.Undefined (
    -- * Usage
    -- $usage
  
    -- * \"Undefined\" redefined
    --
    -- $undefined
    undefined

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
@
module AwesomeSauce where

import Prelude hiding (undefined)
import Acme.Omitted
import Acme.Undefined

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

{-$undefined

Lacking a dedicated name for omitted defintions, users of Standard
Haskell are left with no choice but to use \"undefined\" for both
the undefinable and the omitted.
This makes the standard implementation of \"undefined\" deficient, we
cannot be sure what the programmer has intended, only that the definition is
missing.
The following implementation of undefined is similar in every way to
the standard implementation, but is free from conceptual contamination.
-}

-- | Denotes all values that are, fundamentally, undefinable.
--
-- The contract of 'undefined' is that it will never be used for
-- merely omitted definitions.
undefined :: a
undefined = error "Acme.Undefined.undefined"

{-$observing

Consistent use of 'undefined' and 'omitted' can clarify the intent of the
programmer, but there is still no way to statically prevent incorrect
uses of 'undefined' (e.g., due to ignorance).
Consequently, 'isUndefined' will return bogus results every now and then,
which is why it is modelled as an 'IO' action and not a pure function.

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
implementation of undefined, about which we cannot infer anything except
that its evaluation will terminate with no useful result.
-}

-- | Answer the age-old question \"was this definition omitted?\"
--
-- @
-- isOmitted 0           = return False
-- isOmitted 'undefined' = return False
-- isOmitted 'omitted'   = return True
-- @
isOmitted :: a -> IO Bool
isOmitted = isErrorCall "Acme.Omitted.omitted"

-- | ... or is it really 'undefined'?
--
-- @
-- isUndefined 0           = return False
-- isUndefined 'undefined' = return True
-- isUndefined 'omitted'   = return False
-- @
isUndefined :: a -> IO Bool
isUndefined = isErrorCall "Acme.Undefined.undefined"

-- | A version of 'isUndefined' for \"Prelude.undefined\".
isPreludeUndefined :: a -> IO Bool
isPreludeUndefined = isErrorCall "Prelude.undefined"

isErrorCall :: String -> a -> IO Bool
isErrorCall s x = (E.evaluate x >> return False)
                  `E.catch` (\(E.ErrorCall e) -> return $ e == s)
