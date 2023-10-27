using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ZoomScales : ChangeMouse
{
    [SerializeField] private GameObject CameraTop;
    [SerializeField] private GameObject mainCamera;
    [SerializeField] private GameObject ButtonExit;
    override public void Enable(bool enable) {
        if (enable)
        {
            CameraTop.SetActive(true);
            mainCamera.SetActive(false);
            ButtonExit.SetActive(true);
        }
        else
        {
            CameraTop.SetActive(false);
            mainCamera.SetActive(true);
            ButtonExit.SetActive(false);
        }
    }
}
