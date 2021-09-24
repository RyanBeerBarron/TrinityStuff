package euler;

public class Euler14
{
	public static int[] numberArray = new int[1000000];
	public static void main(String[] args) 
	{
		int max = 0;
		int number = 0;
		int temp = 0;
		for(int i =0; i<numberArray.length; i++)
		{
			numberArray[i]=i;
		}
		for ( int i = 0; i<numberArray.length; i++)
		{
			if(numberArray[i]!=0)
			{
				temp=countCollatzSequence(numberArray[i]);
				if(temp>max){
					max=temp;
					number = i;}
			}
			
		}
		System.out.print(max + " "+number);
	}
	public static int countCollatzSequence(int n)
	{
		long number = n;
		int count = 0;
		while(number!=1)
		{
			if(number%2==1)
				number=3*number+1;
				if(number<numberArray.length)
					numberArray[(int)number]=0;
				count++;
			while(number%2==0)
				number=number/2;
				if(number<numberArray.length)
					numberArray[(int)number]=0;
				count++;
		}
		
		return count;
	}
}
