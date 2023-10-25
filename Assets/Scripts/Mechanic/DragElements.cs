using UnityEngine;

[RequireComponent(typeof(Rigidbody))]
public class DragElements : MonoBehaviour
{
    private Vector3 mouseOffset;
    private float mouseZCoordinate;
    private Rigidbody _rigidbody;
    [HideInInspector] public bool isDrag = false;

    private void Awake(){
        _rigidbody = GetComponent<Rigidbody>();
    }

    private void OnMouseDown(){
        isDrag = true;
        _rigidbody.isKinematic  = true;
        mouseZCoordinate = Camera.main.WorldToScreenPoint(gameObject.transform.position).z;
        mouseOffset = gameObject.transform.position - GetMouseWorldPosition();
    }
    private void OnMouseUp(){
        _rigidbody.isKinematic  = false;
        isDrag = false;
    }
    private Vector3 GetMouseWorldPosition(){
        Vector3 mousePoint = Input.mousePosition;
        mousePoint.z = mouseZCoordinate;
        return Camera.main.ScreenToWorldPoint(mousePoint);
    }
    private void OnMouseDrag(){
        transform.position = GetMouseWorldPosition() + mouseOffset;
    }
}
