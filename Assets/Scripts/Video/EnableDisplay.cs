using UnityEngine;
using TMPro;


//переписать (чтобы подтягивал от нужной лабы, а не от привязанной)
public class EnableDisplay : MonoBehaviour
{

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

    private InfoLab infoLab;
    private void OnTriggerEnter(Collider collider)
    {
        if (collider.TryGetComponent<InfoLab>(out infoLab))
        {
            infoLab.PrintAllInfo(true);
        }
    }

    private void OnTriggerStay(Collider collider)
    {
        if (this.enabled)
        {
            if (collider.TryGetComponent<InfoLab>(out infoLab))
            {
                if (Input.GetKeyUp(KeyCode.Return))
                {
                    sittingCamera.SetActive(true);
                    sittingAnimation.Sitting(collider.GetComponent<WorkSpace>(), infoLab);
                    sittingAnimation.interactiveElements = collider.GetComponent<InteractiveElements>();
                    firstPersonController.enabled = false;
                    firstPersonalCharecter.SetActive(false);
                    infoLab.PrintAllInfo(false);
                    this.enabled = false;
                }
            }
        }
    }
    private void OnTriggerExit(Collider other)
    {
        infoLab.PrintAllInfo(false);
    }

}
