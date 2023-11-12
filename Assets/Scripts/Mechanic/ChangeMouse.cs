using UnityEngine;
using UnityEngine.Video;

public class ChangeMouse : MonoBehaviour
{
    [SerializeField] private Texture2D cursorTexture;

    void Start(){}

    void OnMouseEnter()
    {
        if(this.enabled){
            Cursor.SetCursor(cursorTexture, Vector2.zero, CursorMode.Auto); //проверить почему тут ошибка
        }
    }
    void OnMouseExit()
    {
        if(this.enabled){
            Cursor.SetCursor(null, Vector2.zero, CursorMode.Auto);
        }
    }

    void OnMouseOver()
    {
        if (this.enabled)
        {
            if (Input.GetMouseButtonDown(0))
            {
                Cursor.SetCursor(null, Vector2.zero, CursorMode.Auto);
                FindObjectOfType<InteractiveElements>().EnableAllMouse(false);
                Enable(true);
            }
        }
    }
    virtual public void Enable(bool enable) { }
}
