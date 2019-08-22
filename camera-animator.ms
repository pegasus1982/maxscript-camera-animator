rollout CameraAnimator "Custom Camera Animator"
(
    -- rollout ui
    groupBox group_Cameras "Cameras" pos:[10, 10] width: 300 height: 250
    button btn_PickCameras "Pick Cameras" pos:[20, 30]

    button btn_SelectAll "Select All" pos:[20, 60]
    button btn_DeselectAll "Deselect All" pos:[80, 60]
    multiListBox lst_Cameras items:#() selection:#() pos:[20, 85] width: 280
    button btn_Export "Export Animation" pos:[80, 225] width:160 height:30

    groupBox group_AssignAnimate "Assign Animation" pos:[10, 280] width: 300 height: 130
    radiobuttons radio_ImportType labels:#("From Scene", "From File") pos:[20, 300] columns: 1
    editText edit_FilePath "File Name" pos:[40,  340] width:190
    button btn_Browse "Browse..." pos:[235, 338]
    button btn_Assign "Assign Animation" pos:[80, 370] width:160 height:30
    -- end rollout ui
)

createdialog CameraAnimator width:320 height:420