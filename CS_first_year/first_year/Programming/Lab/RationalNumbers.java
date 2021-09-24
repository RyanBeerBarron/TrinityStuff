
public class RationalNumbers 
{
	private int numerator;
	private int denominator;
	public RationalNumbers(int n) 
	{
		numerator = n;
		denominator = 1;
	}
	public RationalNumbers(int n, int m)
	{
		numerator = n;
		denominator = m;
		if(m==0)
			throw new ArithmeticException("Division by zero");
	}
	public RationalNumbers add(RationalNumbers n)
	{
		int numerator1 = numerator;
		int denominator1 = denominator;
		int numerator2= n.numerator;
		int denominator2 = n.denominator;
		if(denominator2 != denominator1)
		{
			numerator1 = numerator1*denominator2;
			numerator2 = numerator2*denominator1;
			denominator2=denominator2*denominator1;
			denominator1 = denominator2;
		}
		return(new RationalNumbers(numerator1+numerator2,denominator1));
	}
	public RationalNumbers subtract(RationalNumbers n)
	{
		int numerator1 = numerator;
		int denominator1 = denominator;
		int numerator2= n.numerator;
		int denominator2 = n.denominator;
		if(denominator2 != denominator1)
		{
			numerator1 = numerator1*denominator2;
			numerator2 = numerator2*denominator1;
			denominator2=denominator2*denominator1;
			denominator1 = denominator2;
		}
		return(new RationalNumbers(numerator1-numerator2,denominator1));
	}
	public RationalNumbers multiply(RationalNumbers n)
	{
		return(new RationalNumbers(numerator*n.numerator,denominator*n.denominator));
	}
	public RationalNumbers divide(RationalNumbers n)
	{
		return(new RationalNumbers(numerator*n.denominator,denominator*n.numerator));
	}
	public boolean equal(RationalNumbers n)
	{
		return(numerator*n.denominator==denominator*n.numerator);
	}
	public boolean isLessThan(RationalNumbers n)
	{
		return(numerator*n.denominator<denominator*n.numerator);
	}
	public RationalNumbers simplify()
	{
		if(numerator == 0)
			return(new RationalNumbers(0,1));
		boolean numeratorSignChange = false;
		boolean denominatorSignChange = false;
		if(numerator<0)
		{
			numerator = 0 - numerator;
			numeratorSignChange = true;
		}
		if(denominator<0)
		{
			denominator = 0 - denominator;
			denominatorSignChange = true;
		}
		int divisor = GCD(numerator,denominator);
		numerator = numerator / divisor;
		denominator = denominator / divisor;
		if(numeratorSignChange)
			numerator = 0 - numerator;
		if(denominatorSignChange)
			denominator = 0 - denominator;
		return(new RationalNumbers(numerator,denominator));
	}
	public static int GCD(int n, int d)
	{
		while(n>0 && d>0)
		{
			if(n>=d)
				n=n-d;
			else d = d-n;
		}
		if(d==0)
			return n;
		else return d;
	}
	public String toString()
	{
		if(denominator == 1)
		{
			String s =Integer.toString(numerator);
			return s;
		}
		String s ="";
		s=s+Integer.toString(numerator)+"/"+Integer.toString(denominator);
		return s;
	}
}




















