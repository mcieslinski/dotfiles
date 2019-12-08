#!/bin/bash

# Change the home directory in all the files to dotfiles/test or back
echo "If you are not running this from the dotfiles root, you will not be pleased with what happens. Continue? (y/n): "
read doIt

test "${doIt}" = "n" && echo "A wise decision." && return 1

if [[ "${1}" = "-u" ]]; then
    # Undo the test_dir part
    for i in $(find . -name "*.sh"); do
        echo "${i}" | grep "testify.sh" &> /dev/null
        rmdir "test/.gconf"
        rmdir "test/.gconf/schemas"
        rmdir "test/.gconf/schemas/apps"
        test $? -ne 0 && sed -i 's/\${TEST_DIR}/\~/g' ${i}
    done
else
    for i in $(find . -name "*.sh"); do
        echo "${i}" | grep "testify.sh" &> /dev/null
        mkdir "test/.gconf"
        mkdir "test/.gconf/schemas"
        mkdir "test/.gconf/schemas/apps"
        test $? -ne 0 && sed -i 's/\~/${TEST_DIR}/g' ${i}
    done
fi
