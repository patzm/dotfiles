function mov-rename () {
  exiftool -ExtractEmbedded '-FileName<CreateDate' -api QuickTimeUTC -d %Y-%m-%d_%H%M%S%%-c.%%le "$@"
}



