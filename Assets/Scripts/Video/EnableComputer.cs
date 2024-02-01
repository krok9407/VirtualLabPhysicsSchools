using UnityEngine;

public class EnableComputer : ClickOnObject
{
    [SerializeField] GameObject videoPlayer;
    [SerializeField] PlayingOrPaused videoPlayerCanvas;
    override public void Enable(bool enable)
    {
        videoPlayer.SetActive(enable);
        videoPlayerCanvas.videoPlayer = GetComponentInChildren<UnityEngine.Video.VideoPlayer>();
        videoPlayerCanvas.monitor = GetComponentInChildren<Video.Monitor>();
        videoPlayerCanvas.enableComputer = this;
        var interactiveElements = FindObjectsOfType<InteractiveElements>();
        foreach (var element  in interactiveElements) { 
            if(enable) element.OffAll();
            else element.OnAll();
        }
    }
}
