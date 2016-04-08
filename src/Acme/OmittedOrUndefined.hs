{-|
Module      : Acme.OmittedOrUndefined
Description : Is it truly undefined or merely omitted?
Copyright   : (c) 2013-2016 Joachim Fasting
License     : BSD3

Maintainer  : joachifm@fastmail.fm
Stability   : provisional
Portability : portable
-}

module Acme.OmittedOrUndefined (
    -- * Usage
    -- $usage

    -- * Observing the difference between \"omitted\" and \"undefined\"
    --
    -- $observing
    isOmitted
  , isUndefined
  , isPreludeUndefined
) where

import Acme.OmittedOrUndefined.Internal

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

{-$observing

Consistent use of 'undefined' and 'omitted' can clarify the intent of the
programmer, but there is no way to statically prevent incorrect uses of
'undefined' (e.g., due to ignorance).
Consequently, 'isUndefined' will return bogus results every now and then,
which is why it is modelled as an 'IO' action and not a pure function.

Nevertheless, the user can identify incorrect uses of 'undefined' more
easily than before.
To wit, if

@
isUndefined twoPlusTwo = return True
@

then, surely, something is amiss.

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
