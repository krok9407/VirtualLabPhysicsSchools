using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

public class ChangingSound : MonoBehaviour, IPointerDownHandler
{
    [SerializeField] private Scrollbar scrollbar;
    [SerializeField] private Image fillProgressBar;
    private float propScrollToSound;
    public UnityEngine.Video.VideoPlayer videoPlayer;
    void Start()
    {
        propScrollToSound = 1f/GetComponent<RectTransform>().sizeDelta.x;
    }
    private void OnEnable()
    {
        fillProgressBar.fillAmount = scrollbar.value;
        videoPlayer.SetDirectAudioVolume(0, scrollbar.value);
    }
    public void Mute(){
        if(scrollbar.value==0){
            scrollbar.value=1f;
        }else{
           scrollbar.value=0f; 
        }
        SetValue();
    }
    public void SetValue(){
       fillProgressBar.fillAmount = scrollbar.value;
       videoPlayer.SetDirectAudioVolume(0, scrollbar.value);
    }

    public void OnPointerDown(PointerEventData eventData){
       var positionPoint = (eventData.position.x - 576)*propScrollToSound;
       scrollbar.value = positionPoint;
       fillProgressBar.fillAmount = scrollbar.value;
       videoPlayer.SetDirectAudioVolume(0, scrollbar.value);
    }
}
