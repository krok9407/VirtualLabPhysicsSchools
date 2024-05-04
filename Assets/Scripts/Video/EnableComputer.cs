using UnityEngine;

public class EnableComputer : ClickOnObject
{
    [SerializeField] private GameObject videoPlayer;
    [SerializeField] private PlayingOrPaused videoPlayerCanvas;
    
    override public void Enable(bool enable)
    {
        videoPlayerCanvas.videoPlayer = GetComponentInChildren<UnityEngine.Video.VideoPlayer>();
        videoPlayerCanvas.monitor = GetComponentInChildren<Video.Monitor>();
        videoPlayerCanvas.enableComputer = this;
        videoPlayer.SetActive(enable);
        base.Enable(enable);
    }
}
