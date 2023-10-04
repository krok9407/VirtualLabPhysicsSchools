using UnityEngine;

public class SittingAnimation : MonoBehaviour
{
    bool isSitting = false;
    //bool isMoving = false;
    bool isStandUp = false;
    public Transform transformCameraSitting;
    [SerializeField] private Transform transformFirstPersonCharacter;
    [SerializeField] private UnityStandardAssets.Characters.FirstPerson.FirstPersonController firstPersonControllerScript;
    [SerializeField] private GameObject firstPersonController;
    float speed  = 5f;
    [SerializeField] float minAngleX;
    [SerializeField] float minAngleY;
    [SerializeField] float maxAngleX;
    [SerializeField] float maxAngleY;
    //float speedRotation = 0.5f;
    Transform targetDirection; 

    public void StartSitting(WorkSpace workSpace)
    {
        isSitting = true;
        transformCameraSitting = workSpace.chair;
        targetDirection = workSpace.targetVision;
    }

    void Update()
    {
        if (isSitting)
        {
            Vector3 pos = transformCameraSitting.position;
            Vector3 targetPos = new Vector3 (pos.x - 0.1f, pos.y + 1.05f, pos.z);
            
            Vector3 direction = targetDirection.position - transform.position;
            Quaternion rotation = Quaternion.LookRotation(direction);
            transform.rotation = Quaternion.Lerp(transform.rotation, rotation, speed * Time.deltaTime);
            transform.position = Vector3.Lerp(transform.position, targetPos, speed * Time.deltaTime);
            if (transform.position == targetPos && transform.rotation == rotation){
                minAngleX = transform.rotation.eulerAngles.x - 30;
                if(minAngleX<=0) minAngleX=10f; 
                maxAngleX = transform.rotation.eulerAngles.x + 30;
                if(maxAngleX>=360) maxAngleX-=360f;
                minAngleY = transform.rotation.eulerAngles.y - 35;
                maxAngleY = transform.rotation.eulerAngles.y + 35;
                isSitting = false;
                //isMoving = true;
            }
        }
        
        
        /* if (isMoving)
        {
            RotateView();
        }
        */
        
        if (Input.GetKeyDown(KeyCode.E))
        {
            isStandUp = true;
        }
        
        if (isStandUp)
        {
            transformFirstPersonCharacter.gameObject.SetActive(true);
            Vector3 position = transformFirstPersonCharacter.position;
            transform.position = Vector3.Lerp(transform.position, position, speed * Time.deltaTime);
            Quaternion rotation = transformFirstPersonCharacter.rotation;
            transform.rotation = Quaternion.Lerp(transform.rotation, rotation, speed * Time.deltaTime);
                isStandUp = false;
                firstPersonControllerScript.enabled = true;
                firstPersonController.SetActive(true);
                this.gameObject.SetActive(false);
        }
    }

    /*private void RotateView()
    {
        Vector3 rotation = transform.rotation.eulerAngles;
        
        if (Input.GetKey(KeyCode.W)){            
            rotation.x -= speedRotation;
            if (rotation.x < minAngleX && rotation.x > minAngleX-10f)
                rotation.x = minAngleX;
        }
        else if (Input.GetKey(KeyCode.S)){            
            rotation.x += speedRotation;
            if (rotation.x > maxAngleX && rotation.x < maxAngleX+10f)
                rotation.x = maxAngleX;
        }
        else if (Input.GetKey(KeyCode.A)){
            rotation.y -= speedRotation;
            if (rotation.y < minAngleY){
                rotation.y = minAngleY;
            }       
        }
        else if (Input.GetKey(KeyCode.D)){            
            rotation.y += speedRotation;
            if (rotation.y > maxAngleY){
                rotation.y = maxAngleY;
            }
        }
        transform.rotation = Quaternion.Euler(rotation);
    }
    */
    /*private bool Approximately(Vector3 self, Vector3 other, float allowedDifference)
    {
        var dx = self.x - other.x;
        if (Mathf.Abs(dx) > allowedDifference)
            return false;
 
        var dy = self.y - other.y;
        if (Mathf.Abs(dy) > allowedDifference)
            return false;
 
        var dz = self.z - other.z;
 
        return Mathf.Abs(dz) >= allowedDifference;
    }
    */
}
