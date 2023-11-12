using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ZoomScales : ChangeMouse
{
    [SerializeField] private GameObject CameraTop;
    [SerializeField] private GameObject mainCamera;
    [SerializeField] private GameObject ButtonExit;
    private BoxCollider _collider;
    private void Awake()
    {
        _collider = GetComponent<BoxCollider>();
    }
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
            FindObjectOfType<InteractiveElements>().EnableAllMouse(true);
        }
    }
}
