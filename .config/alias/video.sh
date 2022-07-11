# Video alias
alias res="xrandr --output HDMI-A-0 --mode"
changeres() {
    input=$1
    output=$(echo $1 | sed 's/\.mp4/-new.mp4/')

    realpath --canonicalize-existing $1 &&\
    ffmpeg -i ${input} -vf scale=2048:768,setdar=8/3 ${output}
}

concat() {
    # 1. input list with files names
         # list format:
         # file 'foo.mp4'
         # file 'qux 1.mp4' (If file name has spaces dont use escape characters)
    
    input=$1
    output=$(echo $1 | sed 's/\.txt/-full.mp4/')

    ffmpeg -f concat -safe 0 -i ${input} -c copy ${output}
}
# alias concat='ffmpeg -f concat -safe 0 -i ~/Videos/bazar-bmw/bwv.txt -c copy ~/Videos/bazar-bmw/bmw-full.mp4'

encodeconcat() {
    input=$1
    output=$(echo $1 | sed 's/\.txt/-full.mp4/')


    ffmpeg -safe 0 -f concat -segment_time_metadata 1 -i ${input} -threads 6 -vf select=concatdec_select -af aselect=concatdec_select,aresample=async=1 ${output}
}
# alias encodeconcat='ffmpeg -safe 0 -f concat -segment_time_metadata 1 -i ~/Videos/bazar-bmw/bwv.txt -vf select=concatdec_select -af aselect=concatdec_select,aresample=async=1 ~/Videos/bazar-bmw/bmw-full.mp4'

alias stress='ffmpeg -i ~/Videos/video-tests/justice-league-wo-rencode.mp4 -c:v libx264 -preset veryfast -crf 14 -y foo.mp4'

encode(){
  # Encode file using nvidia gpu instead of cpu.
  # To check more encoding options use this command
  # ffmpeg -help encoder=h264_nvenc
  # source: https://wiki.archlinux.org/title/FFmpeg#NVIDIA_NVENC/NVDEC

  input="${1}"
  output="${2}"
  
  ffmpeg -i "${input}" -c:v h264_nvenc "${output}" 
}
