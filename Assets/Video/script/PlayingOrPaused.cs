using UnityEngine;
using UnityEngine.UI;

public class PlayingOrPaused : MonoBehaviour
{
    private Image img;
    private Sprite defaultPic;
    [SerializeField] private Sprite secondPic;
//    [SerializeField] private UnityEngine.Video.VideoPlayer videoPlayer;
    public UnityEngine.Video.VideoPlayer videoPlayer;
    [SerializeField] private Video.Screen projector;
    //[SerializeField] private Video.Monitor monitor;
     public Video.Monitor monitor;
    void Start()
    {
        img = GetComponent<Image>();
        defaultPic = img.sprite;
    }
    public void CloseLessons(){
        videoPlayer.Stop();            
        img.sprite = defaultPic;
        projector.Off();  
        monitor.Off();
    }
    public void PlayOrPause(){
        if(videoPlayer.isPlaying){  
            projector.Off(); 
            monitor.Off(); 
            img.sprite = defaultPic;
        }else{
            projector.On();
            monitor.On();
            videoPlayer.Play();
            img.sprite = secondPic;
        }
    }
}
