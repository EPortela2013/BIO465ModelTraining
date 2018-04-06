import random
import re
import pandas

def extract_normalized_file_name(line):
	index_of_folder = line.index('/')
	file_substring = line[index_of_folder + 1 : ]
	label_pattern = re.compile('\d+$')
	label = label_pattern.findall(file_substring)[-1]

	index_of_dash = file_substring.find('___')
	index_of_label = label_pattern.search(file_substring).end()

	if index_of_dash == -1:
		return file_substring[ : index_of_label - len(label) - 1]
	else:
		return file_substring[index_of_dash + 3 : index_of_label - len(label) - 1]

def get_folder_name(line):
	index_of_folder = line.index('/')
	return line[ : index_of_folder]

def get_leaf_number(normalized_file_name, grouping_data_frame):
	if not isinstance(grouping_data_frame, pandas.DataFrame):
		return -1

	for row in grouping_data_frame.itertuples():
		if row[1] == normalized_file_name:
			if grouping_data_frame.dtypes[1] == 'float64':
				if not math.isnan(row[2]):
					return int(row[2])
				else:
					return -1
			else:
				return row[2]

	return -1

def main():
    percentage = 0.80 #About 80 percent will go to training data set

    # Seed with a constant so results can be replicated
    random.seed(44377)

    previous_group_file_name = ''
    train_set = set()
    validation_set = set()
    grouping_data_frame = None
    train_file_lines = []
    validation_file_lines = []

    with open('images_labeled.txt', 'r', encoding="utf-8") as input_file, \
    	open('train.txt', 'w', encoding="utf-8") as train_file, \
    	open('validate.txt', 'w', encoding="utf-8") as validate_file:
    	nLines = 0
    	read_lines = []

    	for line in input_file:
    		nLines += 1
    		read_lines.append(line)

    	nTrain = int(nLines * percentage)
    	nValid = nLines - nTrain

    	i = 0
    	for line in read_lines:
    		normalized_file_name = extract_normalized_file_name(line[:-1])
    		group_file_name = 'leaf_grouping/filtered_leafmaps/' + get_folder_name(line) + '.csv'
    		if previous_group_file_name != group_file_name:
    			previous_group_file_name = group_file_name
    			train_set.clear()
    			validation_set.clear()
    			try:
    				grouping_data_frame = pandas.read_csv(group_file_name)
    			except:
    				grouping_data_frame = None
    				pass

    		leaf_number = get_leaf_number(normalized_file_name, grouping_data_frame)

    		r = random.random()

    		if leaf_number == -1:
    			if (i < nTrain and r < percentage):
    				train_file_lines.append(line)
    				i += 1
    			else:
    				validation_file_lines.append(line)
    		else:
    			if leaf_number in train_set:
    				train_file_lines.append(line)
    				i += 1
    				continue
    			if leaf_number in validation_set:
    				validation_file_lines.append(line)
    				continue

    			if (i < nTrain and r < percentage):
    				train_file_lines.append(line)
    				i += 1
    				train_set.add(leaf_number)
    			else:
    				validation_file_lines.append(line)
    				validation_set.add(leaf_number)

    	# Emulate shuffle that would have occurred in building LMDB
    	random.shuffle(train_file_lines)
    	random.shuffle(validation_file_lines)

    	# Write to files
    	train_file.writelines(train_file_lines)
    	validate_file.writelines(validation_file_lines)

if __name__ == '__main__':
    main()
