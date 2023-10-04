using System;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

public class changedTimeBar : MonoBehaviour, IPointerDownHandler
{
    private Scrollbar scrollbar;
    private float propScrollToFrame;
    private float propPositionToFrame;
    private RectTransform _rectTransform;
    private RectTransform canvas;
    [SerializeField] private UnityEngine.Video.VideoPlayer videoPlayer;
    void Start()
    {
        scrollbar = GetComponent<Scrollbar>();
        _rectTransform = GetComponent<RectTransform>();
        propScrollToFrame = 1f/videoPlayer.frameCount;
        propPositionToFrame = videoPlayer.frameCount/_rectTransform.sizeDelta.x;
        canvas = transform.GetComponentInParent<Canvas>().gameObject.GetComponent<RectTransform>();
    }
    void Update(){
        scrollbar.value = videoPlayer.frame*propScrollToFrame;  
    }
    public void OnPointerDown(PointerEventData eventData){
        var positionFrame = (eventData.position.x - (canvas.sizeDelta.x-_rectTransform.sizeDelta.x)/2)*propPositionToFrame;
        videoPlayer.frame = Convert.ToInt32(Math.Round(positionFrame));
    }
}
