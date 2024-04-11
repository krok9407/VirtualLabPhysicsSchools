using UnityEngine;

public class RotateImage : MonoBehaviour
{
    private Camera _camera;
    private void Start()
    {
        _camera = GetComponent<Camera>();
    }
    private void Update()
    {
        Vector3 mousePosition = Input.mousePosition;

        Vector3 direction = new Vector2(mousePosition.x - transform.position.x,
            mousePosition.y - transform.position.y);
        transform.up = direction;
        transform.rotation = transform.rotation * Quaternion.Euler(0, 0, -90);
    }

}