{- |
Module      : Acme.Omitted
Description : The universal omitted content operator
Copyright   : (c) 2013 Joachim Fasting
License     : BSD3

Maintainer  : joachim.fasting@gmail.com
Stability   : stable
Portability : portable

An implementation of the universal omitted content operator.
This makes it possible to differentiate between the truly \"undefined\"
and the merely \"omitted\".
-}

module Acme.Omitted ((...), omitted, isOmitted, isUndefined) where

import qualified Control.Exception as E

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
