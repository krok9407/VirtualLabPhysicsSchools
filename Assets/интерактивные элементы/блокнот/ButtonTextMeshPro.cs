using UnityEngine;
using UnityEngine.Events;

public class ButtonTextMeshPro : MonoBehaviour
{
    [SerializeField] UnityEvent _event;
    private void OnMouseDown()
    {
        _event.Invoke();
    }
}

