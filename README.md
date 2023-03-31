# AllCbrztoPdf
Convert CBR/CBZ to PDF

The Bash script is designed to automatically convert CBR and CBZ files to PDF format. It uses a series of standard Bash commands to work with files and directories, simplifying the management of comic book image files. The script prompts the user to select a root folder, initiates the conversion of all CBR and CBZ files to PDF format within the folder and its subfolders, displays progress using "pv" and creates a combined PDF file using "pdftk". Finally, it saves the resulting PDF file in the same folder as the original file.

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

Download:

$ git clone https://github.com/fconidi/AllCbrztoPdf.git

$ cd AllCbrztoPdf/

$ chmod +x allcbrztopdf.sh

$ ./allcbrztopdf.sh


Note:In case of errors, repeat the operation with fewer cbr/cbz files to convert, max 8 at a time, because you need more cpu and ram
ps: Sometimes it happens that inside rar or zip files, there are images with the wrong extension, mixed up, and therefore the script fails. Try to isolate those that don't work, and then proceed manually.
