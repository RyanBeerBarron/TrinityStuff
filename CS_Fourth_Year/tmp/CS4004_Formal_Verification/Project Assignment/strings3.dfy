predicate isPrefixPred(pre:string, str:string)

{

	(|pre| <= |str|) && 

	pre == str[..|pre|]

}



predicate isNotPrefixPred(pre:string, str:string)

{

	(|pre| > |str|) || 

	pre != str[..|pre|]

}



lemma PrefixNegationLemma(pre:string, str:string)

	ensures  isPrefixPred(pre,str) <==> !isNotPrefixPred(pre,str)

	ensures !isPrefixPred(pre,str) <==>  isNotPrefixPred(pre,str)

{}



method isPrefix(pre: string, str: string) returns (res:bool)

	ensures !res <==> isNotPrefixPred(pre,str)

	ensures  res <==> isPrefixPred(pre,str)
	decreases |str|	

{

	if |pre| > |str|
        { return false; }
    else 
    {   
        if str == pre
        { 
            res := true;
            return res; 
        }
        else
        { 
            res := isPrefix(pre, str[..|str|-1]);
            return res; 
        } 
    }

}

predicate isSubstringPred(sub:string, str:string)

{

	(exists i :: 0 <= i <= |str| &&  isPrefixPred(sub, str[i..]))

}



predicate isNotSubstringPred(sub:string, str:string)

{

	(forall i :: 0 <= i <= |str| ==> isNotPrefixPred(sub,str[i..]))

}



lemma SubstringNegationLemma(sub:string, str:string)

	ensures  isSubstringPred(sub,str) <==> !isNotSubstringPred(sub,str)

	ensures !isSubstringPred(sub,str) <==>  isNotSubstringPred(sub,str)

{}



method isSubstring(sub: string, str: string) returns (res:bool)
	requires |sub| >= 0
	requires |str| >= 0
	ensures  res <==> isSubstringPred(sub, str)
	decreases |str|
	//ensures !res <==> isNotSubstringPred(sub, str) // This postcondition follows from the above lemma.

{
	if |sub| > |str|
    {
		return false; 
	}
    else
    {   
    	res := isPrefix(sub, str);
        if res
        {
			assert(isPrefixPred(sub,str));
			assert(isPrefixPred(sub[0..0], str[0..]));
			return res;
		}
        else
        {
			assert(|sub| <= |str|);
			assert(isPrefixPred(sub,str) == false);
			assert(isPrefixPred(sub, str) ==> isSubstringPred(sub, str));

            res := isSubstring(sub, str[1..]);
			
			assert(isPrefixPred(sub, str[1..]) ==> isSubstringPred(sub, str[1..]));			
			assert (res <==> isSubstringPred(sub, str[1..]));
            return res;
        }    
    }    

}
// an
// anana




predicate haveCommonKSubstringPred(k:nat, str1:string, str2:string)

{

	exists i1, j1 :: 0 <= i1 <= |str1|- k && j1 == i1 + k && isSubstringPred(str1[i1..j1],str2)

}



predicate haveNotCommonKSubstringPred(k:nat, str1:string, str2:string)

{

	forall i1, j1 :: 0 <= i1 <= |str1|- k && j1 == i1 + k ==>  isNotSubstringPred(str1[i1..j1],str2)

}



lemma commonKSubstringLemma(k:nat, str1:string, str2:string)

	ensures  haveCommonKSubstringPred(k,str1,str2) <==> !haveNotCommonKSubstringPred(k,str1,str2)

	ensures !haveCommonKSubstringPred(k,str1,str2) <==>  haveNotCommonKSubstringPred(k,str1,str2)

{}



method haveCommonKSubstring(k: nat, str1: string, str2: string) returns (found: bool)

	ensures found  <==>  haveCommonKSubstringPred(k,str1,str2)

	//ensures !found <==> haveNotCommonKSubstringPred(k,str1,str2) // This postcondition follows from the above lemma.

{

//TODO: insert your code here

}



method maxCommonSubstringLength(str1: string, str2: string) returns (len:nat)

	requires (|str1| <= |str2|)

	ensures (forall k :: len < k <= |str1| ==> !haveCommonKSubstringPred(k,str1,str2))

	ensures haveCommonKSubstringPred(len,str1,str2)

{

//TODO: insert your code here

}





