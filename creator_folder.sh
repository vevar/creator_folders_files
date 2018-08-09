#!/bin/bash


createDir(){
    local lvl=$1
    local tmpName=$2
    local list_amountDir=$3
    local amountLvls=$4


    if [[ $lvl -eq $amountLvls ]]
    then   
       create_files $numFiles $tmpFileName
       return 
    else
        local i=0
        for (( ; i<listAmountDir[lvl]; ))
        do
            local nameDir="lvl$lvl$tmpName$i"
            mkdir $nameDir

            cd $nameDir
            
            local lvlNext=$(( lvl + 1))
            createDir $lvlNext $tmpName $list_amountDir $amountLvls
            cd ..
            i=$(( i + 1 ))       
        done        
    fi
}

create_files()
{
    local amountFiles=$1
    local tmpfileName=$2

    for (( j=0; j < $amountFiles; j++ ))
    do
        local fileName="$tmpfileName$j"
        touch $fileName
    done
}


path="."
tmpDirName="DirName"
tmpFileName="FileName"

lvls=3
listAmountDir[0]=50
listAmountDir[1]=50
listAmountDir[2]=100

numFiles=200

for (( arg=1; arg<=$#; arg++))
do
    rec=${!arg:0:1}
    if [ "$rec" = "-" ]
    then
        case ${!arg} in
            "-p")
                par=$(( arg + 1 ))
                path=${!par}
                ;;
            "-td")
                par=$(( arg + 1 ))
                tmpDirName=${!par}                
                ;;
            "-tf")
                par=$(( arg + 1 ))
                tmpFileName=${!par}
                ;;
            "-l")
                par=$(( arg + 1 ))
                lvls=${!par}
                for (( k=0; k<lvls; k++ ))
                do
                    par=$(( par + 1))
                    listAmountDir[$k]=${!par}
                done
                ;;
            "-nf")
                par=$(( arg + 1 ))
                numFiles=${!par}
                ;;                
            *)
                ;;
        esac
    fi
done

cd $path 
createDir 0 $tmpDirName ${listAmountDir} $lvls
echo Done!
