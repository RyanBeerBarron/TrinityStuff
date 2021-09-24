predicate isPrefixPred(pre:string, str:string)
{
	(|pre| <= |str|) && pre == str[..|pre|]
}

predicate isNotPrefixPred(pre:string, str:string)
{
	(|pre| <= |str|) ==> ! (pre == str[..|pre|]) 
}

// Sanity check: Dafny should be able to automatically prove the following lemma
lemma PrefixNegationLemma(pre:string, str:string)
	ensures  isPrefixPred(pre,str) <==> !isNotPrefixPred(pre,str)
	ensures !isPrefixPred(pre,str) <==>  isNotPrefixPred(pre,str)
{}


predicate isSubstringPred(sub:string, str:string)
{
exists offset:nat :: ( 0 <= offset <= |str|-|sub| && isPrefixPred(sub, str[offset..]))
}

predicate isNotSubstringPred(sub:string, str:string)
{
    forall offset:nat :: (0 <= offset <= |str|-|sub| ==> isNotPrefixPred(sub,str[offset..]))
}

// Sanity check: Dafny should be able to automatically prove the following lemma
lemma SubstringNegationLemma(sub:string, str:string)
	ensures  isSubstringPred(sub,str) <==> !isNotSubstringPred(sub,str)
	ensures !isSubstringPred(sub,str) <==>  isNotSubstringPred(sub,str)
{}


predicate haveCommonKSubstringPred(k:nat, str1:string, str2:string)
{
  exists str:string :: (|str| == k >= 0 && isSubstringPred(str, str1) && isSubstringPred(str, str2))
}

predicate haveNotCommonKSubstringPred(k:nat, str1:string, str2:string)
{
	forall str:string :: (|str| == k >= 0 ==> (isNotSubstringPred(str, str1) || isNotSubstringPred(str, str2)))
}

// Sanity check: Dafny should be able to automatically prove the following lemma
lemma commonKSubstringLemma(k:nat, str1:string, str2:string)
	ensures  haveCommonKSubstringPred(k,str1,str2) <==> !haveNotCommonKSubstringPred(k,str1,str2)
	ensures !haveCommonKSubstringPred(k,str1,str2) <==> haveNotCommonKSubstringPred(k,str1,str2)
{}
