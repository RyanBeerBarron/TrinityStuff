package euler;

public class Euler16 
{

	public static void main(String[] args)
	{
		System.out.println(10/10);
		int[] array = new int[1000];
		for(int i =0; i<array.length; i++)
		{
			array[i]=0;
		}
		array[999] = 1;
		int temp = 0;
		for(int count = 0; count<=999; count++)
		{
			temp=0;
			for ( int i = 999; i>=0; i--)
			{
				if(array[i]!=0){
					array[i]= array[i]*2;}
				array[i]+=temp;
				temp=0;
				if(array[i]>=10)
					temp = array[i]/10;
					array[i]=array[i]%10;		
			}
			int sum = 0;
			boolean leadingZero = true;
			for(int i = 0; i<array.length; i++)
			{
				sum +=array[i];
				if(array[i]!=0)
					leadingZero = false;
				if(!leadingZero)
					System.out.print(array[i]);
			}
			System.out.println(" "+sum);	
		}
		
	}

}
