using UnityEngine;
using UnityEngine.UI;

public class Cargos : SelectInteractiveElement
{
    private Cargo[] cargos;
    [SerializeField] private GameObject effect;

    void Start()
    {
        cargos = GetComponentsInChildren<Cargo>();
    }
    public void ResetAll()
    {
        foreach (Cargo cargo in cargos)
        {
            cargo.StartPosition();
        }
    }

    private void OnMouseOver()
    {
        if (this.enabled)
        {
            Cursor.SetCursor(cursorTexture, Vector2.zero, CursorMode.Auto);
            outline.enabled = true;
            effect.SetActive(true);
        }
    }

    private void OnMouseExit()
    { 
        if (this.enabled)
        {
            Cursor.SetCursor(null, Vector2.zero, CursorMode.Auto);
            outline.enabled = false;
            effect.SetActive(false);
        }
    }
}
