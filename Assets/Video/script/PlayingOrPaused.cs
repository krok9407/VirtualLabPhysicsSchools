using UnityEngine;
using UnityEngine.UI;

public class PlayingOrPaused : MonoBehaviour
{
    private Image img;
    private Sprite defaultPic;
    [SerializeField] private Sprite secondPic;
    [HideInInspector] public UnityEngine.Video.VideoPlayer videoPlayer;
    [SerializeField] private Video.Screen projector;
    [HideInInspector] public Video.Monitor monitor;
    [HideInInspector] public EnableComputer enableComputer;
    [SerializeField] private ChangingSound changingSound;
    void Start()
    {
        img = GetComponent<Image>();
        defaultPic = img.sprite;
    }
    private void OnEnable()
    {
        changingSound.videoPlayer = videoPlayer;
    }
    public void CloseLessons(){
        videoPlayer.Stop();            
        img.sprite = defaultPic;
        projector.Off();  
        monitor.Off();
    }
    public void CloseCanvas()
    {
        enableComputer.Enable(false);
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
