using UnityEngine;

public class ControllHeight : MonoBehaviour
{
    [SerializeField] private float maxY = 0.07f;
    [SerializeField] private float minY = -0.364f;
    public float step = 0.01f;

    private void OnMouseOver()
    {
        if (Input.mouseScrollDelta.y < 0f)
        {
            if (transform.localPosition.y > minY)
                transform.localPosition = new Vector3(transform.localPosition.x, transform.localPosition.y - step, transform.localPosition.z);
        }
        else if (Input.mouseScrollDelta.y > 0f)
        {
            if (transform.localPosition.y < maxY)
                transform.localPosition = new Vector3(transform.localPosition.x, transform.localPosition.y + step, transform.localPosition.z);
        }
    }
}
