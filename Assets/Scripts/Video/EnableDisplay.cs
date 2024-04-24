using UnityEngine;
using TMPro;


//переписать (чтобы подтягивал от нужной лабы, а не от привязанной)
public class EnableDisplay : MonoBehaviour
{
    [SerializeField] GameObject enter;
    [SerializeField] GameObject taskBoard;
    [SerializeField] GameObject taskPrefab;
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
        enter.SetActive(false);
        Cursor.lockState = CursorLockMode.None;
        Cursor.visible = true;
    }

    private InfoLab infoLab;
    private void OnTriggerEnter(Collider collider)
    {
        if (collider.TryGetComponent<InfoLab>(out infoLab))
        {
            EnableUI(true, infoLab);
        }
    }

    private void EnableUI(bool enabled, InfoLab infoLab)
    {
        enter.SetActive(enabled);
        enter.GetComponentInChildren<TextMeshProUGUI>().text = infoLab.GetNumber();
        taskBoard.SetActive(enabled);
        if (enabled)
        {
            short i = 1;
            foreach (var task in infoLab.Laboratory)
            {
                GameObject newTask = Instantiate(taskPrefab, taskBoard.transform);
                newTask.GetComponent<Task>().number.text = i.ToString()+'.';
                newTask.GetComponent<Task>().PrintTask(task.Lesson);
                i++;
            }
        }
        else
        {
            for (int i = 0; i < taskBoard.transform.childCount; i++)
            {
                Destroy(taskBoard.transform.GetChild(i).gameObject);
            }
        }
    }

    private void OnTriggerStay(Collider collider)
    {
        if (collider.TryGetComponent<InfoLab>(out infoLab))
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
                EnableUI(false, infoLab);
            }
        }
    }
    private void OnTriggerExit(Collider other)
    {
        EnableUI(false, infoLab);
    }

}
