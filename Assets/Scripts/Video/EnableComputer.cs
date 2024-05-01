using UnityEngine;

public class EnableComputer : ClickOnObject
{
    [SerializeField] private GameObject videoPlayer;
    [SerializeField] private PlayingOrPaused videoPlayerCanvas;
    private SittingAnimation controller;

    private void Start()
    {
        controller = FindObjectOfType<SittingAnimation>().GetComponent<SittingAnimation>();
    }
    override public void Enable(bool enable)
    {
        videoPlayerCanvas.videoPlayer = GetComponentInChildren<UnityEngine.Video.VideoPlayer>();
        videoPlayerCanvas.monitor = GetComponentInChildren<Video.Monitor>();
        videoPlayerCanvas.enableComputer = this;
        videoPlayer.SetActive(enable);
        var interactiveElements = FindObjectsOfType<InteractiveElements>();
        foreach (var element  in interactiveElements) {
            if (enable)
            {
                element.EnabledAll(false);
                controller.busy = true;
            }
            else
            {
                element.EnabledAll(true);
                controller.busy = false;
            }
        }
    }
}
