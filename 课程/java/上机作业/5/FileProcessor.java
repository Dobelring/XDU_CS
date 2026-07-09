import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;
import java.util.stream.*;

public class FileProcessor {

    public static void main(String[] args) {
        if (args.length < 1) {
            printUsage();
            return;
        }

        Scanner scanner = new Scanner(System.in);

        switch (args[0]) {
            case "1":
                System.out.print("Please enter the file path to process: ");
                String filePath = scanner.nextLine();
                try {
                    processFile(filePath);
                } catch (IOException e) {
                    System.err.println("Error processing file: " + e.getMessage());
                }
                break;
            case "2":
                System.out.print("Please enter the folder path to process: ");
                String folderPath = scanner.nextLine();
                System.out.print("Please enter the string to search for: ");
                String searchString = scanner.nextLine();
                try {
                    searchFiles(folderPath, searchString);
                } catch (IOException e) {
                    System.err.println("Error processing folder: " + e.getMessage());
                }
                break;
            case "3":
                if (args.length < 3) {
                    System.out.println("Please provide source and destination file names as arguments.");
                    printUsage();
                    return;
                }
                String sourceFile = args[1];
                String destFile = args[2];
                try {
                    copyFile(sourceFile, destFile);
                } catch (IOException e) {
                    System.err.println("Error copying file: " + e.getMessage());
                }
                break;
            default:
                printUsage();
        }
    }

    private static void printUsage() {
        System.out.println("Usage:");
        System.out.println("  java FileProcessor 1 - Process a single text file to count letters, words, and paragraphs.");
        System.out.println("  java FileProcessor 2 - Search for a string in all files within a folder.");
        System.out.println("  java FileProcessor 3 <source> <destination> - Copy file from source to destination.");
    }

    private static void processFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        if (!Files.exists(path)) {
            System.err.println("File does not exist.");
            return;
        }

        String content = new String(Files.readAllBytes(path), "UTF-8");

        int paragraphCount = content.split("\n\n").length;
        int wordCount = content.split("\\W+").length;

        int[] letterCount = new int[26];
        for (char c : content.toCharArray()) {
            if (Character.isLetter(c)) {
                letterCount[Character.toLowerCase(c) - 'a']++;
            }
        }

        System.out.println("Paragraph count: " + paragraphCount);
        System.out.println("Word count: " + wordCount);

        for (int i = 0; i < 26; i++) {
            if (letterCount[i] > 0) {
                System.out.println((char) (i + 'a') + ": " + letterCount[i]);}
        }
    }

    private static void searchFiles(String folderPath, String searchString) throws IOException {
        if (!Files.isDirectory(Paths.get(folderPath))) {
            System.err.println("Folder does not exist.");
            return;
        }

        List<Path> resultFiles = Files.walk(Paths.get(folderPath))
                .filter(Files::isRegularFile)
                .filter(path -> {
                    try {
                        return new String(Files.readAllBytes(path), "UTF-8").contains(searchString);
                    } catch (IOException e) {
                        return false;
                    }
                })
                .collect(Collectors.toList());

        System.out.println("Files containing string '" + searchString + "':");
        for (Path file : resultFiles) {
            System.out.println(file.toString());
        }
    }

    private static void copyFile(String sourceFile, String destFile) throws IOException {
        Path srcPath = Paths.get(sourceFile);
        Path dstPath = Paths.get(destFile);

        if (!Files.exists(srcPath)) {
            System.err.println("Source file does not exist.");
            return;
        }

        if (Files.exists(dstPath)) {
            System.err.println("Destination file already exists.");
            return;
        }

        if (srcPath.equals(dstPath)) {
            System.err.println("Source file and destination file are the same.");
            return;
        }

        Files.copy(srcPath, dstPath, StandardCopyOption.REPLACE_EXISTING);
        System.out.println("File copied successfully from " + sourceFile + " to " + destFile);
    }
}