
using UnityEngine;
using UnityEngine.UI;

public class InteractiveElements : MonoBehaviour
{
    private ClickOnScales[] _clickOnScales;
    private Outline[] _outlines;
    private SelectInteractiveElement[] _changeMouse;
    private DragElements[] _dragElements;

    void Awake()
    {
        _changeMouse = GetComponentsInChildren<SelectInteractiveElement>();
        _dragElements = GetComponentsInChildren<DragElements>();
        _clickOnScales = GetComponentsInChildren<ClickOnScales>();
        _outlines = GetComponentsInChildren<Outline>();
        OffAll();
    }
    public void EnableAllMouse(bool enabled) {
        foreach (var mouse in _changeMouse)
            mouse.enabled = enabled;
    }
    public void ResetLaboratory()
    {
        //вернуть все объеты на места и сбросить ответы
    }
    
    public void OffAll()
    {
        EnableAllMouse(false);
        Cursor.SetCursor(null, Vector2.zero, CursorMode.Auto);
        foreach (var element in _dragElements)
            element.enabled = false;
        foreach (var button in _clickOnScales)
            button.enabled = false;
        foreach (var outline in _outlines)
            outline.enabled = false;
    }
    public void OnAll()
    {
        EnableAllMouse(true);
        foreach (var element in _dragElements)
            element.enabled = true;
        foreach (var button in _clickOnScales)
            button.enabled = true;
    }
}
