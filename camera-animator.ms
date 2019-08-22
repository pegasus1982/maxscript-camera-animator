rollout CameraAnimator "Custom Camera Animator"
(
    -- rollout ui
    groupBox group_Cameras "Cameras" pos:[10, 10] width: 300 height: 250
    button btn_PickCameraList "Pick Cameras" pos:[20, 30]

    button btn_SelectAllCameraList "Select All" pos:[20, 60]
    button btn_DeselectAllCameraList "Deselect All" pos:[80, 60]
    multiListBox lst_Cameras items:#() selection:#() pos:[20, 85] width: 280
    button btn_Export "Export Animation" pos:[80, 225] width:160 height:30

    groupBox group_AssignAnimate "Assign Animation" pos:[10, 280] width: 300 height: 160
    checkbutton btn_PickCamera "Pick Camera To Assign" pos:[22, 298] width:170
    edittext edit_TargetCamera "" pos:[200, 300] width:100

    radiobuttons radio_ImportType labels:#("From Scene", "From File") pos:[20, 330] columns: 1
    editText edit_FilePath "File Name" pos:[40,  370] width:190
    button btn_Browse "Browse..." pos:[235, 368]
    button btn_Assign "Assign Animation" pos:[80, 400] width:160 height:30
    -- end rollout ui

    global selectedCamera

    fn getFrameNumberFromName camName = (
        frameSection = (filterstring camName ".")[1]
        result = 0
        cnt = frameSection.count - 1
        for i = 1 to frameSection.count do (
            char = frameSection[i] as Integer
            if char == undefined do char = 0
            result = result + char * (pow 10 cnt)
            cnt = cnt - 1
            -- if (char >= "0" && char <= "9") do (
            -- --     result = result + char
            -- )
        )
        print (result as integer)
    )
    fn getCamerasInfoFromScene = (
        print "get cameras info with list"
        info = #()
        selectIndexes = lst_Cameras.selection
        items = lst_Cameras.items
        print selectIndexes
        for i in selectIndexes do (
            itemInfo = #()
            camName = items[i]
            frame = getFrameNumberFromName(camName)
            cam = execute ("$'"+camName + "'")
            
            append itemInfo frame
            append itemInfo cam.pos
            append itemInfo cam.dir

            append info itemInfo
        )
        return info
    )

    fn getCamerasInfoFromFile = (
        print "get cameras info from file"
    )

    on btn_PickCameraList pressed do (
        print("pick camera list from scene")
        cameraList = $selection
        cameraNames = #()
        for i = 1 to cameraList.count do (
            append cameraNames cameraList[i].name
        )
        lst_Cameras.items = cameraNames
    )

    on btn_SelectAllCameraList pressed do (
        print "select all cameras"
        cameraList = lst_Cameras.items
        selectedList = #()
        for i = 1 to cameraList.count do (
            append selectedList i
        )
        lst_Cameras.selection = selectedList
    )

    on btn_DeselectAllCameraList pressed do (
        print "deselect all cameras"
        lst_Cameras.selection = #()
    )

    on btn_PickCamera changed state do (
        if state == true do (
            try (
                target_Camera = pickobject propt:"Pick Camera"
                edit_TargetCamera.text = target_Camera.name
                btn_PickCamera.checked = false;
                selectedCamera = target_Camera
            ) catch ()
        )
    )

    on btn_Assign pressed do (
        if isValidObj(selectedCamera) then (
            camerasInfo = #()
            if radio_ImportType.state == 1 then (
                camerasInfo = getCamerasInfoFromScene();
            ) else (
                camerasInfo = getCamerasInfoFromFile();
            )

            -- assign animation keys
            with animate on (
                for i = 1 to camerasInfo.count do (
                    item = camerasInfo[i]
                    at time item[1] (
                        selectedCamera.pos = item[2]
                        selectedCamera.dir = item[3]
                    )
                )
            )
            -- end assign animation keys
        ) else (
            messageBox "Camera isn't selected" title:"Error!"
        )
    )
)

createdialog CameraAnimator width:320 height:450