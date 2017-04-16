using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Linq;



namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {   /**
            thought process: read file, store numbers into c sharp list<>, perform operations on lists, get a resultant list where elements are summed up and divided by numprocesses 
            **/

            /*
             * 
             * before execution, replace below directory 'filedir' with directory of your local sample0 file
             * ||||||||||
             * ||||||||||
             * VVVVVVVVVV
             * 
             * 
             * */
            string filedir = "C:/Users/Ryan/Documents/GitHub/Level1/OS PROGRAM 2/examples0.csv";





            var result = GetCsvContent(filedir); //csv  string data inside array //
            var prseint = new List<int>(); //list to store the converted string data//

            foreach (string item in result) {
                prseint.Add(int.Parse(item));   //string data converted into numeric data//
            }

            calcWait(prseint);//avg wait time//
            //avg turnaround time//
            //throughput//

            Console.ReadKey();
        }


        /*
         * derive burst times and execution times from result set to perform a subtraction operation amongst both
         * lists to get a resultant list of wait times of each process to sum together and average out
         * |||
         * VVV
         */
        public static void calcWait(List<int> proc) {
            List<double> btimes = new List<double>();
            List<double> etimes = new List<double>();
            List<double> wtimes = new List<double>();
            double total = 0.0;
            double totalwait = 0.0;
            for (int i = 0; i <= proc.Count - 1; i+=3) {
                btimes.Add(proc.ElementAt(i+2));
            }
            
            
            foreach (double num in btimes)
            {
                etimes.Add(total + num);
                total += num;
            }

            for (int j = 0; j <= btimes.Count - 1; j++) {
                double wait = etimes.ElementAt(j) - btimes.ElementAt(j);
                wtimes.Add(wait);
                totalwait += wait;
            }

            Console.Write("average wait time for processes in queue: " + (totalwait/etimes.Count));
        }


        /*
         * 
         * 
         */
        public static string[] GetCsvContent(string iFileName)
        {   
            var oCsvContent = new List<string>();
            using (FileStream lFileStream =
                          new FileStream(iFileName, FileMode.Open, FileAccess.Read))
            {
                StringBuilder lFileContent = new StringBuilder();
                using (StreamReader lReader = new StreamReader(lFileStream))
                { 
                    // a string for the csv value
                    string lCsvValue = "";
                    // loop through the file until you read the end
                    while (!lReader.EndOfStream)
                    {
                        // stores each line in a variable
                        string lCsvLine = lReader.ReadLine() + "\n";
                        // for each character in the line...
                        {
                            foreach (char lLetter in lCsvLine)
                            {

                                // if we come across a comma 
                                // AND it's not within a double quote..
                                if (lLetter == ',' | lLetter == '\n')
                                {
                                    // add our string to the array
                                    oCsvContent.Add(lCsvValue);
                                    // null out our string
                                    lCsvValue = null;
                                }
                                else
                                {
                                    // add the character to our string
                                    lCsvValue += lLetter;
                                }
                            }
                        }
                    }
                }
            }
            return oCsvContent.ToArray();
        }
    }
}
