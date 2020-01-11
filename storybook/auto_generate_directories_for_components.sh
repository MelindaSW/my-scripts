#!bin/bash

#Reads the fifth word (the component's name) from index.js file 
#in the directories for components and features and assigns them to arrays
#The names are then used as arguments for running the script
#which evaluates if they already exist and adds new directories in stories/ 
#when they don't. 

echo "Running" $0
echo

components=($(awk '{print $5}' ../components/index.js))
features=($(awk '{print $5}' ../features/index.js))
pages=($(awk '{print $5}' ../pages/index.js))

directories=("components" "features" "pages")

for component in ${components[@]};
do
	./add_new_story_and_test_directory_with_files.sh ${directories[0]} $component
done

for feature in ${features[@]};
do
	./add_new_story_and_test_directory_with_files.sh ${directories[1]} $feature
done

for page in ${pages[@]};
do
	./add_new_story_and_test_directory_with_files.sh ${directories[2]} $page
done

echo $0 "done"
exit 0