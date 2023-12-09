using UnityEngine;
public class ClickOnObject : SelectInteractiveElement
{
    void OnMouseOver()
    {
        if (this.enabled)
        {
            if (Input.GetMouseButtonDown(0))
            {
                Cursor.SetCursor(null, Vector2.zero, CursorMode.Auto);
                Enable(true);
                FindObjectOfType<InteractiveElements>().EnableAllMouse(false);
            }
        }
    }
    virtual public void Enable(bool enable)
    {
        
    }
}