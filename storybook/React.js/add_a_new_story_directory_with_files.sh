#!/usr/bin/env bash

# Pass the name of the folder (existing or non-existing) as first argument 
# and the name of the component as the second argument
# Trying to create directory/directories that already exists will print a warning


echo "Running" $0

[ -z "$2" ] && echo "ERROR: Not enough arguments supplied. Provide: 1 = name of folder the new folder should be generated in, 2 = name of component" && exit 1

dir=$1
name=$2

dirPath=$dir/$name

componentFile=./$dirPath/$name.jsx
storyFile=./$dirPath/$name.stories.jsx
testFile=./$dirPath/$name.test.js

[ -d $dirPath ] && echo "Directory "$dirPath" already exists" && echo && exit 1

mkdir -p -v $dirPath

touch $componentFile
touch $storyFile
touch $testFile
echo "Created files for "$name""

echo "import React from 'react';
import { "$name" } from '"$dir"';

const "$name"Default = props => <div data-testid=\"default\"><"$name" {...props} /></div>;

export { "$name"Default };" >> $componentFile


echo "import { "$name"Default } from './"$name"';
import { render } from 'test-utils';

describe('"$name" Default ', () => {

    it('should render without crashing', () => {
        const { getByTestId } = render("$name"Default());
        expect(getByTestId(/default/i)).toBeInTheDocument();
    });

});" >> $testFile


echo "import { storiesOf } from '@storybook/react';
import { "$name"Default } from './"$name"';

storiesOf('"$dir"|"$name"', module)
.addParameters({ jest: ['"$name"'] })
.add('Default', () => {
    return "$name"Default();
});" >> $storyFile


echo "Added content to the "$name" files"
echo "Done"
echo