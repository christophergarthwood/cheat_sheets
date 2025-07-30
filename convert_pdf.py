from pdf2image import convert_from_path
import sys
import os
from PyPDF2 import PdfReader

input_extension="PDF"
output_extension="GIF"

if len(sys.argv) > 1:
    try:
        input_file = sys.argv[1]
    except Exception as e:
        raise ExceptionType("Could not parse input filename, check your arguments.")
        exit(2)
else:
    raise ExceptionType("No CLI provided, exiting program.")
    exit(2)

# Path to your PDF file
pdf_path = os.path.dirname(input_file)
pdf_filename = os.path.basename(input_file)
just_the_filename=os.path.splitext(pdf_filename)[0]
root, pdf_extension = os.path.splitext(input_file)

if not os.path.exists(input_file):
    raise ExceptionType(f"The file '{input_file}' does not exist, aborting program.  Check your filesystem, argument names, etc...")
    exit(2)

if not pdf_extension.lower().endswith(input_extension.lower()):
   print(f"Warning: File does not have a .pdf extension: {file_path}")
        
try:
    with open(input_file, 'rb') as file:
        reader = PdfReader(file)
        # Attempt to access a property to trigger parsing and error handling
        _ = len(reader.pages) 
except Exception as e:
    raise ExceptionType(f"Error opening '{input_file}' likely not an actual PDF.  Aborting execution.")
    exit(3)

# Convert PDF pages to a list of PIL Image objects
images = convert_from_path(input_file)

# Save each page as an image
for i, image in enumerate(images):
    # You can change 'PNG' to 'JPEG' for JPG format
    image.save(f'{just_the_filename}_{i+1}.'+output_extension.lower(), output_extension)
