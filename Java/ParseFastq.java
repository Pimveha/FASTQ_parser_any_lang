import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;


class ParseFastq {
    public void read_fastq(String path_name) {
        // String path_name = path_name;
        // Map<String, String> fastqMap = new HashMap<String, String, String>();
        try {
            // File move_file = new File("./path_nam.txt");
            String name = "";
            String sequence = "";
            String quality = "";
            File move_file = new File(path_name);
            Scanner myReader = new Scanner(move_file);

            while (myReader.hasNextLine()) {
                String line = myReader.nextLine();
                if (line.startsWith("@")) {
                    name = line;
                    sequence = myReader.nextLine();
                    myReader.nextLine(); // +
                    quality = myReader.nextLine();
                    }
                
                // System.out.println(line.split("\t"));
                procesContent(name, sequence, quality);
                }
            }
        catch (FileNotFoundException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        }
    }
    public void procesContent(String name, String sequence, String quality) {
        System.out.println(name);
        System.out.println(sequence);
        System.out.println(quality);
        System.out.println("---------------------------");
    }

    public static void main(String[] args) {
        String filePath = "../example.fastq";
        ParseFastq parser = new ParseFastq();
        parser.read_fastq(filePath);
    }
}