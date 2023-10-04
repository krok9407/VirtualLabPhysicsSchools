using UnityEngine.UI;
using UnityEngine;


public class SetName : MonoBehaviour
{
    [SerializeField] private UnityEngine.Video.VideoPlayer videoPlayer;
    void Start()
    {
        gameObject.GetComponent<Text>().text = videoPlayer.clip.name;
    }

}
