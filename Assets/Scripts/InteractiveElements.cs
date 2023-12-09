
using UnityEngine;

public class InteractiveElements : MonoBehaviour
{
    private ClickOnScales[] _clickOnScales;
    private SelectInteractiveElement[] _changeMouse;
    private DragElements[] _dragElements;

    void Awake()
    {
        _changeMouse = GetComponentsInChildren<SelectInteractiveElement>();
        _dragElements = GetComponentsInChildren<DragElements>();
        _clickOnScales = GetComponentsInChildren<ClickOnScales>();
        OffAll();
    }
    public void EnableAllMouse(bool enabled) {
        foreach (var mouse in _changeMouse)
            mouse.enabled = enabled;
    }
    
    public void OffAll()
    {
        EnableAllMouse(false);
        foreach (var element in _dragElements)
            element.enabled = false;
        foreach (var button in _clickOnScales)
            button.enabled = false;
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
