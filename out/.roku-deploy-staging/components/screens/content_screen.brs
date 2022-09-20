sub init()
    m.content_grid = m.top.FindNode("content_grid")
    m.header = m.top.FindNode("header")
        'obserwacja pola visible na screenie content
        'fokusowanie na thumbnailsy
        m.top.observeField("visible", "onVisibleChange")
end sub  

sub onVisibleChange()
	if m.top.visible = true then
		m.content_grid.setFocus(true)
	end if
end sub

sub onFeedChanged(obj)
    feed = obj.getData()
    m.header.text = feed.title
    postercontent = createObject("roSGNode","ContentNode")
    regex = createObject("roRegEx", "http://[a-z0-9.:]+", "i")
    for each item in feed.items
        node = createObject("roSGNode","ContentNode")
        node.streamformat = item.streamformat
        node.title = item.title
        node.url = item.url
        ?node.title ; " = " ; node.url
        node.description = item.description
        'node.HDGRIDPOSTERURL = item.thumbnail
        'uses regular expression
        node.HDGRIDPOSTERURL = regex.replace(item.thumbnail,m.host)
        node.SHORTDESCRIPTIONLINE1 = item.title
        node.SHORTDESCRIPTIONLINE2 = item.description
        postercontent.appendChild(node)
    end for
    showpostergrid(postercontent)
end sub  

sub showpostergrid(content)
  m.content_grid.content=content
  m.content_grid.visible=true
  m.content_grid.setFocus(true)
end sub

function updateConfig(params)
	m.host = params.config.host
end function