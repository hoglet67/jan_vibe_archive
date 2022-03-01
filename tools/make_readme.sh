#!/bin/bash

video_base_url=https://jan-vibe-archive-videos.s3.eu-west-1.amazonaws.com

cd screenshots
for folder in `ls -d BAS*`
do
    cd $folder
    rm -f README.md
    for png in `ls *.png | sort`
    do
        name=${png%.png}
        basictxt=${name},fd1
        basictxt_file=programs/${folder}/${basictxt}
        video=${folder}/${png%.png}.mp4
        if [[ -f "../../$basictxt_file" ]] ; then
            # Check if we have a video.
            video_link=
            if grep -q "${video}" ../../tools/videos.txt ; then
                has_video=true
                video_link=" - ([video]($video_base_url/$video))"
            else
                has_video=false
            fi

            echo "[*${name}*](../../${basictxt_file})$video_link" >> README.md
            echo >> README.md
            if $has_video ; then
                # There's a video, so we can provide a link
                echo "[![](${png})]($video_base_url/$video)" >> README.md
            else
                echo "![](${png})" >> README.md
            fi
            echo >> README.md
        else
            echo "$folder does not contain a BASIC file '${basictxt_file}' for PNG '${folder}/${png}'"
        fi
    done
    cd ..
done
