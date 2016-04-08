{-|
Module      : Acme.OmittedOrUndefined.Internal
Description : Internal module
Copyright   : (c) 2016 Joachim Fasting
License     : BSD3

Maintainer  : joachifm@fastmail.fm
Stability   : stable
Portability : portable
-}

module Acme.OmittedOrUndefined.Internal where

import qualified Control.Exception as E

isErrorCall :: String -> a -> IO Bool
isErrorCall s x = (E.evaluate x >> return False)
                  `E.catch` (\(E.ErrorCall e) -> return $ e == s)
