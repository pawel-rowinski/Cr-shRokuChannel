  sub init()
    m.top.functionname = "request"
    m.top.response = ""
  end sub  
  
  function request()
    url = m.top.url
    http = createObject("roUrlTransfer")
    http.RetainBodyOnError(true)
    port = createObject("roMessagePort")
    http.setPort(port)
    http.setCertificatesFile("pkg:/source/ca-bundle.crt")
    http.InitClientCertificates()
    http.enablehostverification(false)
    http.enablepeerverification(false)
    http.setUrl(url)
    '? http.setUrl(url)
    if http.AsyncGetToString() Then
      msg = wait(10000, port)
      if (type(msg) = "roUrlEvent")
        ' ? msg.getresponsecode()
        if (msg.getresponsecode() > 0 and  msg.getresponsecode() < 400)
          m.top.response = msg.getstring()
        else
          m.top.error = "Feed failed to load. "+ chr(10) +  msg.getfailurereason() + chr(10) + "Code: "+msg.getresponsecode().toStr()+ chr(10) + "URL: "+ m.top.url
          ? "feed load failed: "; msg.getfailurereason();" "; msg.getresponsecode();" "; m.top.url
          m.top.response = ""
        end if
        http.asynccancel()
      else if (msg = invalid)
        ? "feed load failed."
        m.top.error = "Feed failed to load. Unknown reason."
        m.top.response =""
        http.asynccancel()
      end if
    end if
    return 0
  end function

  function load()
    if m.top.filepath = ""
        m.top.error = "Config can't be loaded because filepath not provided."
    else
	    data=ReadAsciiFile("pkg:/"+m.top.filepath)
	    ? "[Load Config Task] Data: "; data
	    json = parseJSON(data)
	    if json = invalid
	        m.top.error = "File contents invalid."
	    else
	        m.top.filedata = json
	    end if
	end if
end function