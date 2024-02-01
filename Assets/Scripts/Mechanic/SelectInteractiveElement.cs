using UnityEngine;
using DG.Tweening;
using UnityEngine.UI;

[RequireComponent(typeof(Outline))]
public class SelectInteractiveElement : MonoBehaviour
{
    [SerializeField] private Texture2D cursorTexture;
    [SerializeField] private Outline outline;
    private void Start() { }
    void OnMouseEnter()
    {
        if (this.enabled)
        {
            Cursor.SetCursor(cursorTexture, Vector2.zero, CursorMode.Auto); //проверить почему тут ошибка
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
