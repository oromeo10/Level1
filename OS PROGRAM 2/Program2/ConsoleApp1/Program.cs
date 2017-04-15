using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            int a = 3;
            int b = 4;
            for (int i = 0; i <= 10; i++) {
                Console.WriteLine("Your result is: " + (a + b + i)) ;
                
            }
            Console.ReadKey();

        }
    }
}
