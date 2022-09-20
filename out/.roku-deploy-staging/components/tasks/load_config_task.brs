sub init()
    m.top.functionname = "load"
  end sub
  
  function load()
      ? m.top.filepath
      m.sciezka = "pkg:/" + m.top.filepath
      ? m.sciezka
      data=ReadAsciiFile(m.sciezka)
      ? "Config Data: ";data
      json = parseJSON(data)
      m.top.filedata = json
  end function