# Generic media

function media-show-date() {
  : 'media-show-date: shows the dates that are stored in the file name.'
  exiftool -T -FileName -DateTimeOriginal "$@"
}

function media-meta-update() {
  : 'media-meta-update: updates the metadata of an media (images or videos) base on the file name.
  
  matches for instance
  - "20-03-23 15-02-59 4123.jpg"
  - "22-07-24 14-20-42.jpg"
  - "20-03-23 15-02-59 4123.mov"
  - "22-07-24 14-20-42.mov"
  '
  exiftool \
    -overwrite_original \
    '-DateTimeOriginal<${Filename; s/(\d{2})-(\d{2})-(\d{2}) (\d{2})-(\d{2})-(\d{2})(?: \d+)?\..*/20$1:$2:$3 $4:$5:$6/}' \
    "$@"
}

# Images

function img-shift-tz () {
  : 'img-shift-tz: Shift images timestamps by a specific offset.

  img-shift-tz -=2:30 *.jpg
    shifts by 2h30min back
  '
  tz_shift=${1}
  for file in "${@:2}"; do
    exiftool "-AllDates${tz_shift}" "${file}"
  done
}

function img-rename () {
  exiv2 -Fr '%Y-%m-%d_%H%M%S' "$@"
}

rename_to_jpg() {
  for file in "$@"; do
    if [[ "$file" == *.jpeg || "$file" == *.JPEG ]]; then
      mv "$file" "${file%.*}.jpg"
    elif [[ "$file" == *.JPG ]]; then
      # Handling case-sensitive filesystems by using an intermediate rename
      mv "$file" "${file%.*}.jpg.tmp"
      mv "${file%.*}.jpg.tmp" "${file%.*}.jpg"
    else
      echo "Skipping file $file, extension not matching."
    fi
  done
}

# Videos

function vid-rename () {
  exiftool -ExtractEmbedded '-FileName<CreateDate' -api QuickTimeUTC -d %Y-%m-%d_%H%M%S%%-c.%%le "$@"
}

function vid-shift-tz () {
  # vid-shift-tz -=2 *.mov
  tz_shift=${1}
  for file in "${@:2}"; do
    echo "Shifting timezone of ${file} by ${tz_shift}."
    exiftool '-*date'${tz_shift} "${file}"
  done
}


