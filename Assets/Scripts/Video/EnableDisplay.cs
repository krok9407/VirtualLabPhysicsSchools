using UnityEngine;
using UnityEngine.UI;

//переписать (чтобы подтягивал от нужной лабы, а не от привязанной)
public class EnableDisplay : MonoBehaviour
{
    [SerializeField] GameObject enter;
    [SerializeField] float rangeDetected = 2.5f;
    private GameObject sittingCamera;
    private GameObject firstPersonalCharecter;
    [SerializeField] private SittingAnimation sittingAnimation;
    private UnityStandardAssets.Characters.FirstPerson.FirstPersonController firstPersonController;

    private void Start()
    {
        firstPersonalCharecter = transform.GetChild(0).gameObject;
        sittingCamera = transform.GetChild(1).gameObject;
        firstPersonController = GetComponent<UnityStandardAssets.Characters.FirstPerson.FirstPersonController>();
    }


    public void OpenLab(){
        //gameObject.SetActive(false);
        enter.SetActive(false);
        Cursor.lockState = CursorLockMode.None;
        Cursor.visible = true;
    }
    private void OnTriggerEnter(Collider collider)
    {
        if (collider.TryGetComponent<InfoLab>(out InfoLab infoLab))
        {
            enter.SetActive(true);
            enter.GetComponentInChildren<Text>().text = infoLab.GetNumber();
        }
    }
    private void OnTriggerStay(Collider collider)
    {
        if (collider.TryGetComponent<InfoLab>(out InfoLab infoLab))
        {
           
            if (Input.GetKeyDown(KeyCode.Return))
            {
                sittingCamera.SetActive(true);
                sittingAnimation.StartSitting(collider.GetComponent<WorkSpace>(), infoLab);
                sittingAnimation.interactiveElements = collider.GetComponent<InteractiveElements>();
                firstPersonController.enabled = false;
                enter.SetActive(false);
                infoLab.StartLab();
                collider.transform.GetChild(0).gameObject.SetActive(true);
                firstPersonalCharecter.SetActive(false);
            }
        }
    }
    private void OnTriggerExit(Collider other)
    {
        enter.SetActive(false);
    }

}
