using UnityEngine;
using TMPro;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class visibilityPassword : MonoBehaviour,IPointerDownHandler, IPointerUpHandler{

    [SerializeField] private TMP_InputField inputField;
    [SerializeField] private Sprite[] images;

    private Image _image;
    private void Start()
    {
        _image = GetComponent<Image>();
        Visibility(false);
    }
    public void Visibility(bool status){
        if(status){
            inputField.contentType = TMP_InputField.ContentType.Standard;
            _image.sprite = images[0];
        }
        else{
            inputField.contentType = TMP_InputField.ContentType.Password;
            _image.sprite = images[1];
        }
    }
 
    public void OnPointerDown(PointerEventData eventData){
        Visibility(true);
        inputField.ForceLabelUpdate();
    }
 
    public void OnPointerUp(PointerEventData eventData){
        Visibility(false);
        inputField.ForceLabelUpdate();
    }
}
