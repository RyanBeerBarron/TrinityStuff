method isPrefix(pre : string, str : string) returns (res : bool)
requires |pre| > 0 && |str| >= 0
ensures  (str[..|pre|] == pre) <==> (res == true)
ensures (str[..|pre|] != pre) <==> (res == false)
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

method isSubstring(sub : string, str: string) returns(res:bool)
requires |str| >= 0 && |sub| > 0
ensures exists x :: str[x..|sub|+x] == sub <==> res == true
{
    if |sub| > |str| || |str| == 0 
        { return false; }
    else
    {   
       var prefix := isPrefix(sub, str);
        if prefix
            { return true;}
        else
        {
            res:= isSubstring(sub, str[1..]);
            return res;
        }    
    }    
}

method haveCommonKSubstrings(k: nat, str1: string, str2: string) returns(found:bool)
requires k >= 0
requires |str1| >= 0 && |str2| >= 0
ensures exists str: string :: k == |str| && 
{
    if k == 0
        { return true; }
    else if k > |str1|
        { return false; }
    else
    {
        var slice := str1[..k];
        var res := isSubstring(slice, str2);
        if res
            { return res; }
        else
        {
            res := haveCommonKSubstrings(k, str1[1..], str2); 
            return res;
        }    
    }    
}

method maxCommunSubstringLength(str1: string, str2: string) returns (len:nat)
{
    var min := if |str1| < |str2| then |str1| else |str2|;
    var k := 0;
    var res := haveCommonKSubstrings(k, str1, str2);
    while res && k < min
    {
        len := k;
        k := k + 1;
        res := haveCommonKSubstrings(k, str1, str2);
    }
    return len;
}