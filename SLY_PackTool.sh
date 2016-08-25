#!/bin/bash
# 深蓝蕴车路宝打包工具
# Author：黄盼青
# Date：2016.03.11

ShellPath=$(pwd)
#工作副本目录
WorkPath=$(pwd)/工程目录副本/xcar/
#Plist配置文件名
MDM_PLIST="mdm.plist"

echo '----------------------------------------------------'
echo '   深蓝蕴车路宝打包工具 v1.0 20160311 by 黄盼青'
echo '----------------------------------------------------'               

# 判断脚本用法是否正确
if [ $# -le 2 ]; then
  echo "用法错误！示例:SLY_PackTool.sh -s [配置文件目录] -o [输出IPA包文件目录]"
  exit 1
fi

# 读取传入参数信息
params=($@)

for i in ${params[@]}; do

	# 获取配置文件目录
	if [ $i == "-s" ]; then
		((i++))
		shift

		INPUT_PATH=${params[$i]}
	fi

	# 获取输出文件目录
	if [ $i == "-o" ]; then
		((i++))
		shift

		OUTPUT_PATH=${params[$i]}
	fi

done

# 校验配置文件
echo "校验Plist配置文件..."
cd ${INPUT_PATH}
if [ ! -f "$MDM_PLIST" ]; then
	echo "错误：找不到MDM打包配置文件!"
	exit 1
else
	checkResut=`Plutil -lint ${INPUT_PATH}/${MDM_PLIST}`
	okStr="${INPUT_PATH}/${MDM_PLIST}: OK"

	if [ ! "$checkResut" == "$okStr" ]; then
		echo "Plist配置文件错误!请检查配置文件是格式否正确！"
		exit 1
	else
		echo "校验成功!"
	fi

fi

# 读取Plist内容(其余配置信息后续加)
APP_Identify=$(/usr/libexec/PlistBuddy -c "Print:CFBundleIdentifier" "${INPUT_PATH}/${MDM_PLIST}")
APP_DisplayName=$(/usr/libexec/PlistBuddy -c "Print:CFBundleDisplayName" "${INPUT_PATH}/${MDM_PLIST}")
APP_Version=$(/usr/libexec/PlistBuddy -c "Print:CFBundleVersion" "${INPUT_PATH}/${MDM_PLIST}")
MDM_AgentID=$(/usr/libexec/PlistBuddy -c "Print:app_agent_id" "${INPUT_PATH}/${MDM_PLIST}")
MDM_CompanyInfo=$(/usr/libexec/PlistBuddy -c "Print:app_company_info" "${INPUT_PATH}/${MDM_PLIST}")
MDM_VersionCode=$(/usr/libexec/PlistBuddy -c "Print:app_version_code" "${INPUT_PATH}/${MDM_PLIST}")

# 拷贝项目代码到工作目录
cd $ShellPath
echo "正在拷贝项目副本到临时文件..."
cp -Rf $WorkPath $ShellPath/temp/
cd temp

# 替换图片资源文件

# 更改info.plist内容

# 编译打包

###工程配置文件路径
project_path=$(pwd)
project_name=$(ls | grep xcodeproj | awk -F.xcodeproj '{print $1}')
target_name=${project_name}
#创建保存打包结果的目录
result_path=${project_path}/build_release_$(date +%Y-%m-%d_%H_%M)
mkdir -p "${result_path}"


#打包完的程序目录
appDir=${build_dir}/${target_name}.app;
#dSYM的路径
dsymDir=${build_dir}/${target_name}.app.dSYM;

xcode_build="xcodebuild -configuration Release -workspace ${ShellPath}/temp/${project_name}.xcworkspace -scheme ${project_name} ONLY_ACTIVE_ARCH=NO TARGETED_DEVICE_FAMILY=1 DEPLOYMENT_LOCATION=YES CONFIGURATION_BUILD_DIR=${result_path}"

echo "开始clean工程,准备编译打包..."
${xcode_build} clean

#编译工程
${xcode_build}  -sdk iphoneos build || exit

#IPA名称
ipa_name="${APP_DisplayName}/${APP_Version}.ipa"
xcrun -sdk iphoneos PackageApplication -v "${appDir}" -o "${ipa_name}"
#拷贝过来.app.dSYM到输出目录
mkdir -p "${result_path}/dsym"
cp -R "${appDir}" "${result_path}/dsym/${target_name}.app"
cp -R "${dsymDir}" "${result_path}/dsym/${target_name}.app.dSYM"



