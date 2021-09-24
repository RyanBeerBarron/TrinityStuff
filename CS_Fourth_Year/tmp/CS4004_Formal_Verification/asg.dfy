predicate isMax(s:seq<nat>, lo:nat) {
    0<=lo<|s| && forall i :: (0<=i<|s| ==> s[i] <= s[lo])
}

method findMax(s:seq<nat>) returns(lo:nat) 
requires 0 < |s|
ensures isMax(s, lo)
{
    lo := 0;
    var hi := |s|-1;
    while(lo < hi) 
        invariant (hi < |s| && lo <= hi && forall i :: (0<=i<=lo || hi <= i <|s| ==> (s[i]<=s[lo] || s[i]<=s[hi])))
        decreases hi-lo
    {
        if(s[lo] <= s[hi]) {
            lo := lo + 1;
        } else {
            hi := hi - 1;
        }
    }
    assert (lo >= hi && hi < |s| && lo <= hi && forall i :: (0<=i<=lo || hi <= i <|s| ==> (s[i]<=s[lo] || s[i]<=s[hi])));
}


predicate isPalindrome(s:string) {
    forall i :: (0<=i<|s|/2 ==> s[i] == s[|s|-1-i])
}

method checkPalindrome(s:string) returns(res:bool)
requires 0 <= |s|
ensures (isPalindrome(s) <==> (res==true) ) 
{
    res := true;
    var i := 0;
    var j := |s|-1;
    while(i<j && res == true)
        invariant (i==|s|-1-j && i<=|s| && ((forall k :: 0<=k<i ==> s[k]==s[|s|-k-1])  <==> res==true ))
        decreases |s| - i
    {
        if s[i] != s[j] {
            res := false;
        }
        i := i + 1;
        j := j -1;
    }
}

// res == true <==> forall k:: (0<=k<i ==> s[k] == s[|s|-k-1])
// forall k :: (0<= k< i ==>s[k]==s[|s|-1-k]) ==> res == true