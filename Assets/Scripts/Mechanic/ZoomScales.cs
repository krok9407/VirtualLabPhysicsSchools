using UnityEngine;

public class ZoomScales : ClickOnObject
{
    [SerializeField] private GameObject CameraTop;
    [SerializeField] private GameObject mainCamera;
    [SerializeField] private GameObject ButtonExit;
    private BoxCollider _collider;
    private void Awake()
    {
        _collider = GetComponent<BoxCollider>();
    }
    //использовать обычный без перегрузки, настроить эвенет в инспекторе
    override public void Enable(bool enable) {
        if (enable)
        {
            CameraTop.SetActive(true);
            mainCamera.SetActive(false);
            ButtonExit.SetActive(true);
            _collider.enabled = false;
        }
        else
        {
            CameraTop.SetActive(false);
            mainCamera.SetActive(true);
            ButtonExit.SetActive(false);
            _collider.enabled = true;
            FindObjectOfType<InteractiveElements>().EnableAllMouse(false);
        }
    }
}
