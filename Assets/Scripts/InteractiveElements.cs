
using UnityEngine;
using UnityEngine.UI;

public class InteractiveElements : MonoBehaviour
{
    private ClickOnScales[] _clickOnScales;
    private Outline[] _outlines;
    private SelectInteractiveElement[] _changeMouse;
    private DragElements[] _dragElements;

    private WaterVolume[] _waterVolumes;
    private ControllHeight _controllHeight;
    private ChangeDynamometers _changeDynamometers;

    void Awake()
    {
        _changeMouse = GetComponentsInChildren<SelectInteractiveElement>();
        _dragElements = GetComponentsInChildren<DragElements>();
        _clickOnScales = GetComponentsInChildren<ClickOnScales>();
        _outlines = GetComponentsInChildren<Outline>();

        _controllHeight = GetComponentInChildren<ControllHeight>();
        _changeDynamometers = GetComponentInChildren<ChangeDynamometers>();
        _waterVolumes = GetComponentsInChildren<WaterVolume>();

        EnabledAll(false);
    }
    public void EnableAllMouse(bool enabled) {
        foreach (var mouse in _changeMouse)
            mouse.enabled = enabled;
    }
    public void ResetLaboratory()
    {
        //вернуть все объеты на места и сбросить ответы
    }
    
    public void EnabledAll(bool enable)
    {
        EnableAllMouse(enable);

        if (_controllHeight != null) _controllHeight.enabled = enable;
        
        if (_changeDynamometers != null) _changeDynamometers.enabled = enable;

        foreach (var element in _dragElements)
            element.enabled = enable;

        foreach (var button in _clickOnScales)
            button.enabled = enable;

        if (_waterVolumes.Length > 0)
        {
            foreach (var water in _waterVolumes)
                water.enabled = enable;
        }

        if (enable == false)
        {
            foreach (var outline in _outlines)
                outline.enabled = false;
            Cursor.SetCursor(null, Vector2.zero, CursorMode.Auto);
        }
    }
}
