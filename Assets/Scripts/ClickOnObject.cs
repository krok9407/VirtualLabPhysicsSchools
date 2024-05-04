using UnityEngine;
public class ClickOnObject : SelectInteractiveElement
{
    private SittingAnimation controller;

    private void Start()
    {
        controller = FindObjectOfType<SittingAnimation>().GetComponent<SittingAnimation>();
    }

    void OnMouseOver()
    {
        if (this.enabled)
        {
            if (Input.GetMouseButtonDown(0))
            {
                Cursor.SetCursor(null, Vector2.zero, CursorMode.Auto);
                Enable(true);
            }
        }
    }
    virtual public void Enable(bool enable)
    {
        var interactiveElements = FindObjectOfType<InteractiveElements>();
        if (enable)
        {
            interactiveElements.EnabledAll(false);
            controller.busy = true;
        }
        else
        {
            interactiveElements.EnabledAll(true);
            controller.busy = false;
        }
    }
}