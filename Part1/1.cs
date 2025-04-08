using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using System.Linq;

class LogProcessor
{
    // 1. פיצול קובץ הלוגים לחלקים קטנים
    public static void SplitFile(string inputFilePath, int chunkSize, string outputPrefix = "chunk_")
    {
        using (StreamReader reader = new StreamReader(inputFilePath))
        {
            int chunkIndex = 0;
            List<string> lines = new List<string>();
            string line;
            while ((line = reader.ReadLine()) != null)
            {
                lines.Add(line);
                if (lines.Count >= chunkSize)
                {
                    File.WriteAllLines($"{outputPrefix}{chunkIndex}.txt", lines);
                    lines.Clear();
                    chunkIndex++;
                }
            }
          
        }
    }

    // 2. ספירת קודי השגיאה בכל חלק
    public static Dictionary<string, int> CountErrorCodes(string filePath)
    {
        // הגדרת ביטוי רגולרי לחילוץ קוד השגיאה
        Regex regex = new Regex(@"Error:\s*(\S+)");
        Dictionary<string, int> errorCounts = new Dictionary<string, int>();

        foreach (string line in File.ReadLines(filePath))
        {
            Match match = regex.Match(line);
            if (match.Success)
            {
                string errorCode = match.Groups[1].Value;
                if (errorCounts.ContainsKey(errorCode))
                    errorCounts[errorCode]++;
                else
                    errorCounts[errorCode] = 1;
            }
        }
        return errorCounts;
    }

    // 3. איחוד ספירות השגיאה מכל החלקים
    public static Dictionary<string, int> MergeDictionaries(List<Dictionary<string, int>> counters)
    {
        Dictionary<string, int> merged = new Dictionary<string, int>();
        foreach (var dict in counters)
        {
            foreach (var pair in dict)
            {
                if (merged.ContainsKey(pair.Key))
                    merged[pair.Key] += pair.Value;
                else
                    merged[pair.Key] = pair.Value;
            }
        }
        return merged;
    }

    // 4. מציאת N קודי השגיאה השכיחים ביותר
    public static List<KeyValuePair<string, int>> GetTopN(Dictionary<string, int> counts, int N)
    {
        return counts.OrderByDescending(pair => pair.Value)
                     .Take(N)
                     .ToList();
    }

    static void Main(string[] args)
    {
        Console.WriteLine("anter path and N");
        string path = Console.ReadLine();
        int N = Convert.ToInt32(Console.ReadLine());
        int chunkSize = 1000; // מספר השורות בכל חלק
       

        // שלב 1: פיצול הקובץ לחלקים
        SplitFile(path, chunkSize);

        // שלב 2: מציאת כל קבצי החלקים (בהנחה שהם נקראים "chunk_*.txt")
        List<Dictionary<string, int>> counters = new List<Dictionary<string, int>>();
        string currentDirectory = Directory.GetCurrentDirectory();
        foreach (string chunkFile in Directory.GetFiles(currentDirectory, "chunk_*.txt"))
        {
            counters.Add(CountErrorCodes(chunkFile));
        }

        // שלב 3: איחוד ספירות קודי השגיאה מכל החלקים
        Dictionary<string, int> totalCounts = MergeDictionaries(counters);

        // שלב 4: מציאת N קודי השגיאה השכיחים ביותר
        var topErrors = GetTopN(totalCounts, N);

        // הדפסת התוצאות
        Console.WriteLine("the most common "+ N +" errors:");
        foreach (var pair in topErrors)
        {
            Console.WriteLine($"{pair.Key}: {pair.Value}");
        }
    }
}

/*
סיבוכיות זמן
פיצול הקובץ- O(L) L -מספר השורות בקובץ  
O(L) ספירת קודי השגיאה בהנחה שעוברים על כל שורה פעם אחת
 מספר קודי השגיאה היחודיים- K
C- מספר הקבצים הקטנים
איחוד כל הספירות הזמן ריצה הוא O(K*C)
מציאת הקודים השכיחים, כלומר מיון המילון המאוחד:
O(k log k)


סיבוכיות מקום:
פיצול הקובץ O(chunk_size)
כי בכל פעם טוענים לזיכרון של התוכנית רק חלק קטן מהקובץ הענק ולכן זה יותר יעיל מבחינת זיכרון
ספירת קודי השגיאה מכל קובץ O(K)- למילון
איחוד הספירות O(K)
*/

/*פלט:
anter path and N
C:\Users\Ruchama\Hadassim\logs.txt
4
the most common 4 errors:
WARN_101 ": 200098
ERR_404 ": 200094
ERR_400 ": 200069
INFO_200 ": 199931

C: \Users\Ruchama\Hadassim\exe1\exe1\bin\Debug\net5 .0\exe1.exe(process 25324) exited with code 0.
To automatically close the console when debugging stops, enable Tools->Options->Debugging->Automatically close the console when debugging stops.
Press any key to close this window . . .
*/







