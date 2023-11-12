using UnityEngine;

public class EnableComputer : ChangeMouse
{
    [SerializeField] GameObject videoPlayer;
    override public void Enable(bool enable) {
        videoPlayer.SetActive(enable);
    }
}
