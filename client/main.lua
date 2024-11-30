local properties = nil

RegisterNUICallback('buttonSubmit', function(data, cb)
    SetNuiFocus(false, false)
    properties:resolve(data.data)
    properties = nil
    cb('ok')
end)

RegisterNUICallback('closeMenu', function(_, cb)
    SetNuiFocus(false, false)
    properties:resolve(nil)
    properties = nil
    cb('ok')
end)

local function ShowInput(data)
    if not data then return end
    if properties then return end
    
    properties = promise.new()
    
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'OPEN_MENU',
        data = data
    })
    
    return Citizen.Await(properties)
end

exports('ShowInput', ShowInput)

RegisterCommand('testinput', function()
    SetNuiFocus(true, true)
    
    local data = {
        header = "QB Input Test",
        submitText = "Submit",
        inputs = {
            {
                text = "Text Input", 
                name = "text", 
                type = "text", 
                isRequired = true,
                default = "Default Value" 
            },
            {
                text = "Password Field",
                name = "password",
                type = "password",
                isRequired = true
            },
            {
                text = "Number Input",
                name = "number",
                type = "number",
                default = "100"
            },
            {
                text = "Radio Selection",
                name = "radio",
                type = "radio",
                options = {
                    { value = "option1", text = "Option 1" },
                    { value = "option2", text = "Option 2" },
                    { value = "option3", text = "Option 3" }
                }
            },
            {
                text = "Dropdown Menu",
                name = "select",
                type = "select",
                options = {
                    { value = "value1", text = "Selection 1" },
                    { value = "value2", text = "Selection 2" },
                    { value = "value3", text = "Selection 3" }
                }
            },
            {
                text = "Checkbox Group",
                name = "checkbox",
                type = "checkbox",
                options = {
                    { value = "check1", text = "Checkbox 1", checked = false },
                    { value = "check2", text = "Checkbox 2", checked = true },
                    { value = "check3", text = "Checkbox 3", checked = false }
                }
            },
            {
                text = "Color Picker",
                name = "color",
                type = "color",
                default = "#ff0000"
            }
        }
    }
    
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })
end)
