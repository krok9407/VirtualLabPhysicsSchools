using UnityEngine;
using DG.Tweening;
using UnityEngine.UI;

public class SelectInteractiveElement : MonoBehaviour
{
    [SerializeField] private Texture2D cursorTexture;
    private Outline outline;
    void Start()
    {
        outline = GetComponent<Outline>();
    }

    void OnMouseEnter()
    {
        if(this.enabled)
        {
            Cursor.SetCursor(cursorTexture, Vector2.zero, CursorMode.Auto); //��������� ������ ��� ������
        }
        outline.enabled = true;
    }
    void OnMouseExit()
    {
        if(this.enabled){
            Cursor.SetCursor(null, Vector2.zero, CursorMode.Auto);
        }
        outline.enabled = false;
    }
}
