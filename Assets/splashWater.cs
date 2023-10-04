using UnityEngine;

public class splashWater : MonoBehaviour
{
    [HideInInspector]public Transform target;
    [SerializeField]
    [Range(0f,1f)]
    private float speed=0.05f;
    void Start()
    {
        gameObject.SetActive(false);
    }
    void SetStartPosition(){
        transform.SetParent(target);
        transform.position = target.position;
        transform.position = new Vector3(transform.position.x, transform.position.y+transform.parent.localScale.z / 3f, transform.position.z); 
    }
    void OnEnable()
    {
        SetStartPosition();
    }
    void Update(){  
        transform.position = Vector3.Lerp(transform.position, target.position, speed);
        var heading = target.position - transform.position;
        var distance = heading.magnitude;
        if(distance<0.01f)
        {
            SetStartPosition();   
        }
    }
}
