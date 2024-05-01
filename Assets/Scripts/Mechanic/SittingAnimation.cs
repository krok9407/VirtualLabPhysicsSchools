using UnityEngine;

public class SittingAnimation : MonoBehaviour
{
    InfoLab infoLab;
    bool isSitting = false;
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
    [SerializeField] PlayingOrPaused videoPlayer;
    Transform targetDirection;
    public InteractiveElements interactiveElements;
    public bool busy = false;
    
    public void StartSitting(WorkSpace workSpace, InfoLab infoLab)
    {
        this.infoLab = infoLab;
        isSitting = true;
        transformCameraSitting = workSpace.chair;
        targetDirection = workSpace.targetVision;
    }

    void Update()
    {
        //заменить на дотвин
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
            }
        }
        if (!busy) { 
            if (Input.GetKeyDown(KeyCode.E))
            {
                infoLab.CloseLab();
                isStandUp = true;
                interactiveElements.EnabledAll(false);
                try
                {
                    videoPlayer.CloseLessons();
                }
                catch { }
            }
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

}
