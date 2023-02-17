pip install --target ./package pytz requests beautifulsoup4
cd package

# download pandas wheel
curl -O https://files.pythonhosted.org/packages/54/a0/c62d63c5c69be9aae07836e4d7e25e7a6f5590be3d8f2d53f43eeec5c475/pandas-1.5.3-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl

# unzip pandas
unzip pandas-1.5.3-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl

curl -O https://files.pythonhosted.org/packages/9c/ee/77768cade9607687fadbcc1dcbb82dba0554154b3aa641f9c17233ffabe8/numpy-1.24.2-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl

unzip numpy-1.24.2-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl

rm -r *.whl *.dist-info __pycache__

zip -r9 ${OLDPWD}/helloWorldLambda.zip .
cd ${OLDPWD}
rm -rf package