using UnityEngine;

[RequireComponent(typeof(Outline))]
public class SelectInteractiveElement : MonoBehaviour
{
    [SerializeField] protected Texture2D cursorTexture;
    [SerializeField] protected Outline outline;
    private void Start() { }
    void OnMouseEnter()
    {
        if (this.enabled)
        {
            Cursor.SetCursor(cursorTexture, Vector2.zero, CursorMode.Auto); //��������� ������ ��� ������
            outline.enabled = true;
        } 
    }
    void OnMouseExit()
    {   
        if (this.enabled){
            Cursor.SetCursor(null, Vector2.zero, CursorMode.Auto);
            outline.enabled = false;
        }  
    }
}
