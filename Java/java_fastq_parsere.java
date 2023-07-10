import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;


class files {
    public ArrayList<String>() read_fastq(String path_name) {
        // String path_name = path_name;
        lines = new ArrayList<String>();
        try {
            // File move_file = new File("./path_nam.txt");
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
                lines.add(line);
                // System.out.println(line.split("\t"));
                }
            }
        catch (FileNotFoundException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        }
        return lines;
    }
}


class fastq