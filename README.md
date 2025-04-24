# FASTQ Phred Score Classifier

This is a simple Bash script that automatically classifies FASTQ files in your current directory into **Phred+33** and **Phred+64** encoded types based on their quality score lines.

## What It Does

- Scans all `.fastq` files in the current directory.
- Extracts quality score lines (every 4th line of each FASTQ entry).
- Converts the characters into their decimal ASCII values using `od`.
- Finds the minimum and maximum ASCII values (ignores spaces and newline codes).
- Based on the ASCII range:
  - Moves the file to `phred33/` if scores are between **33 and 74**
  - Moves the file to `phred64/` if scores are between **64 and 104**
- If the file doesn’t fall into either known range, it flags it as **unrecognized**.

## Limitations

- **Ambiguous Range**: When scores fall entirely within the range **[64, 74]**, the encoding could be **either Phred+33 or Phred+64**.  
  **This script defaults to Phred+33** in this case, as it is the more widely used and modern format.

- The script does **not analyze headers or metadata**, only quality score lines.

## Requirements

- Bash shell
- Standard Linux tools: `awk`, `tr`, `od`, `grep`, `sort`, `head`, `tail`

## Output Example

- Processing file: example.fastq
- Min: 33
- Max: 74
- Phred+33 encoding detected for example.fastq
- Moved example.fastq to phred33/

