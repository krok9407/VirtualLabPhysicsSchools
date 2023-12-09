using UnityEngine;

public class magniticEffect : MonoBehaviour
{
    [HideInInspector]public Vector3 target;
    [SerializeField]
    [Range(0f,1f)]
    private float speed=0.5f;
    void Update(){
        transform.position = Vector3.Lerp(transform.position, target, speed);
        var heading = target - transform.position;
        var distance = heading.magnitude;
        if(distance<0.01f)
        {
            transform.position = transform.parent.position;    
        }
    }
}
