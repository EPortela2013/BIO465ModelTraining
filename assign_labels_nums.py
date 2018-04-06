
import re
import os


filename = "images.txt"
output_file = "images_labeled.txt"
input_file_handle = open(filename, "r")
output_file_handle = open(output_file, "w")
labels_file_handle = None

if os.path.isdir('../BIO465LeafPrediction'):
    labels_file_handle = open('../BIO465LeafPrediction/labels.txt', "w")

label = -1
dir_name = ""
pattern = re.compile('^\S+\s*\S*/')

for line in input_file_handle:
    # Extract directory name
    extracted_dir_name = pattern.findall(line)[0]
    extracted_dir_name = extracted_dir_name.replace('/', '')
    line = line.replace('\n', '')

    #Update label number if necessary
    if dir_name != extracted_dir_name:
        dir_name = extracted_dir_name
        label = label + 1
        if labels_file_handle:
            labels_file_handle.write("%s\n" % dir_name)

    output_file_handle.write("%s %d\n" % (line, label))
