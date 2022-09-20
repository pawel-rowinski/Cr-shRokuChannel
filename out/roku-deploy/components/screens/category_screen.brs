function init()

    ? "[category_screen] init()"
    
    m.category_list=m.top.findNode("category_list")
    m.category_list.setFocus(true)
    'sprawdzamy widoczność listy kategorii (category_list)
    m.top.observeField("visible", "onVisibleChange")
    'm.category_list.observeField("itemSelected", "onCategorySelected")
    'm.lab = m.top.findNode("env")
    'm.top.visible = false
end function

sub onVisibleChange()
	if m.top.visible = true then
		m.category_list.setFocus(true)
	end if
end sub

function updateConfig(params)
    categories = params.config.categories
    contentNode = createObject("roSGNode","ContentNode")
    for each category in categories
        node = createObject("roSGNode","category_node")
        node.title = category.title
        node.feed_url = params.config.host + category.feed_url
        contentNode.appendChild(node)
    end for
    m.category_list.content = contentNode
end function

' without Tasks
' sub loadFeed(url)
'     ? "loadFeed! ";url
' end sub

' sub loadFeed(url)
'     m.feed_task = createObject("roSGNode", "load_feed_task")
'     m.feed_task.observeField("response", "onFeedResponse")
'     m.feed_task.url = url
'     m.feed_task.control = "RUN"
'   end sub  
  
'   sub onFeedResponse(obj)
'     ? "onFeedResponse: "; obj.getData()
'   end sub

' sub onCategorySelected(obj)
'     ' if m.top.visible = true
'     '     ? "onCategorySelected field: ", obj.getField()
'     ' ' ? "onCategorySelected data: ";obj.getData()
'     ' ' ? "onCategorySelected checkedItem: ";m.category_list.checkedItem
'     '     ? "onCategorySelected selected ContentNode: "; m.category_list.content.getChild(obj.getData()).title
'     ' end if
'     item = m.category_list.content.getChild(obj.getData())
'     loadFeed(item.feed_url)
' end sub

' function onKeyEvent(key as String, press as Boolean) as Boolean
'     handled = false
'     if press then
'       if (key = "left") then
'         handled = false
'       else
'         if (m.top.visible = false)
'           m.top.visible="true"
'         else
'           if (key = "right") then
'             m.top.visible="false"
'           end if
'         end if
'         handled = true
'       end if
'     end if
'     return handled
'   end function
