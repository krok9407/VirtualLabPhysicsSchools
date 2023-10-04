using UnityEngine;

public class EnableComputer : ChangeMouse
{
    [SerializeField] GameObject videoPlayer;
    void Start()
    {
        this.enabled = false;
    }
    override public void Enable(bool enable) {
        videoPlayer.SetActive(enable);
    }
}
