using UnityEngine;
using TMPro;

public class timeVideo : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI allTime;
    [SerializeField] private TextMeshProUGUI currentTime;
    [SerializeField] private UnityEngine.Video.VideoPlayer videoPlayer;
    
    private void Start()
    {
        allTime.text = ((int)videoPlayer.length/60).ToString()+":"+((int)videoPlayer.length%60).ToString();
    }
    private void Update() {
        int min = (int)videoPlayer.clockTime/60,
            sec = (int)videoPlayer.clockTime%60;
        string time = min.ToString()+":"+sec.ToString();
            if(sec<10) time = min.ToString()+":0"+sec.ToString();
             currentTime.text = time;
    }
}

