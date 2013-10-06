{- |
Module      : Acme.Omitted
Description : A universal definition of omitted content
Copyright   : (c) 2013 Joachim Fasting
License     : BSD3

Maintainer  : joachim.fasting@gmail.com
Stability   : stable
Portability : portable

A universal definition of \"omitted content\" and methods
for observing whether a definition is merely \"omitted\" or
truly \"undefined\".
-}

module Acme.Omitted
  (
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
  ) where

import Prelude hiding (undefined)
import qualified Control.Exception as E

------------------------------------------------------------------------
-- $omitted
--
-- The difference between \"omitted\" and \"undefined\" is that the
-- programmer may choose to omit something but he cannot define the
-- undefinable.
-- The former is contingent on the whims of the programmer, the latter
-- a fundamental truth.
--
-- Operationally, there is no difference between undefined and omitted;
-- attempting to evaluate either is treated as an error.
--
-- Ideally, programmers would only ever use 'undefined' for things that
-- are truly undefined, e.g., division by zero, and use 'omitted' for
-- definitions that have yet to be written or that are currently not needed.

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

------------------------------------------------------------------------
-- $undefined
--
-- The undefined is that which cannot be named or expressed.
-- As is plain, \"Prelude.undefined\" is deficient.
-- Here is an alternative implementation of \"undefined\" with the
-- appropriate connotations.
--
-- It is impossible to statically verify that a use of \"undefined\"
-- is correct.
-- Nevertheless, by using this version of 'undefined', the programmer
-- explicitly communicates her intent to the reader (and the user).
-- That is, if a user encounters a use of 'undefined', he will know that
-- the definition he tried to evaluate, in fact, is undefinable.
--
-- Note, the operational semantics is equivalent to \"Prelude.undefined\".

-- | Denotes all values that are, fundamentally, undefinable.
--
-- The implicit (as in not statically enforcable) contract of 'undefined'
-- is that it will never be used for merely omitted definitions.
-- For that, see 'omitted'.
undefined :: a
undefined = error "Acme.Omitted.undefined"

------------------------------------------------------------------------
-- $observing
--
-- The following definitions allow the user to discriminate undefined
-- omitted values.
-- Some caveats apply, however.
--
-- Though 'isUndefined' arguably could be a pure function (what is by
-- definition undefinable shall always remain undefined), we feel it most
-- appropriate to keep both 'isOmitted' and 'isUndefined' in 'IO', for
-- reasons of symmetry and because the distinction between omitted and
-- undefined is a 'GHC.Prim.RealWorld' concern (in the end, both denote the
-- same value, i.e., bottom).
--
-- Another reason to keep 'isUndefined' in 'IO' is the regrettable state of
-- modern Haskell, which has forced programmers to use 'undefined' for all
-- sorts of purposes where 'omitted' should have been used instead.
-- Thus it is unsound to assume that 'undefined' values will remain so, or
-- indeed make any assumptions about it at all.
--
-- The confounding of \"undefined\" and \"omitted\" also means that,
-- as it stands, 'isUndefined' will return bogus results for some uses of
-- 'undefined'.
-- A possible refinement is to provide an alternative to \"Prelude.undefined\"
-- that could be assumed to only represent values that are \"truly undefined\".
-- For now, 'isUndefined' is provided as a convenience, but users are adviced to
-- not rely on its results.
-- Users are, however, encouraged to file bugs against libraries making unsound
-- use of 'undefined'.

-- | Answer the age-old question \"was this definition omitted?\"
--
-- @
-- isOmitted 0         = return False
-- isOmitted undefined = return False
-- isOmitted omitted   = return True
-- @
isOmitted :: a -> IO Bool
isOmitted = isErrorCall "omitted"

-- | ... or is it really 'undefined'?
--
-- @
-- isUndefined 0         = return False
-- isUndefined omitted   = return False
-- isUndefined undefined = return True
-- @
isUndefined :: a -> IO Bool
isUndefined = isErrorCall "Prelude.undefined"

isErrorCall :: String -> a -> IO Bool
isErrorCall s x = (E.evaluate x >> return False)
                  `E.catch` (\(E.ErrorCall e) -> return $ e == s)
