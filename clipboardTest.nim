import winim/com
import winim/lean
import std/os


proc getCopiedFiles(): seq[string] =
  result = @[]

  if OpenClipboard(0):
    defer: CloseClipboard()

    let hDrop = cast[HDROP](GetClipboardData(CF_HDROP))
    if hDrop != 0:
      # Cast explícito a UINT en vez de tipar el literal como uint32
      let fileCount = DragQueryFile(hDrop, cast[UINT](-1), cast[LPWSTR](nil), UINT(0))

      for i in 0..<fileCount:
        let pathLen = DragQueryFile(hDrop, UINT(i), cast[LPWSTR](nil), UINT(0))
        if pathLen > 0:
          var buffer = newSeq[uint16](pathLen + 1)
          discard DragQueryFile(hDrop, UINT(i), cast[LPWSTR](addr buffer[0]), UINT(buffer.len))
          result.add($cast[WideCString](addr buffer[0]))

when isMainModule:
    var extensionsAllowed = @[".txt", ".jpg", ".png", ".pdf"]
    let files = getCopiedFiles()
    if files.len > 0:
        echo "on clipboard:"
        for f in files:
            let (_, _, ext) = splitFile(f)
            if extensionsAllowed.contains(ext):
                echo "- ", f
            else:
                echo "file extension not allowed"
    else:
        echo "No files on clipboard."