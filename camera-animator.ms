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
)

createdialog CameraAnimator width:320 height:450