using UnityEngine;

public class EnableComputer : ClickOnObject
{
    [SerializeField] GameObject videoPlayer;
    [SerializeField] PlayingOrPaused videoPlayerCanvas;
    override public void Enable(bool enable) {
        videoPlayer.SetActive(enable);
        videoPlayerCanvas.videoPlayer = GetComponentInChildren<UnityEngine.Video.VideoPlayer>();
        videoPlayerCanvas.monitor = GetComponentInChildren<Video.Monitor>();
        var interactiveElements = FindObjectsOfType<InteractiveElements>();
        foreach (var element  in interactiveElements) { element.OffAll(); }
    }
}
