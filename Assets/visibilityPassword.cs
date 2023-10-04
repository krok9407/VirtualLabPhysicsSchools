using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

public class visibilityPassword : MonoBehaviour,IPointerDownHandler, IPointerUpHandler{

    [SerializeField] private InputField _inputField;
    
    public void Visibility(bool status){
        if(status){
            _inputField.contentType = InputField.ContentType.Standard;
        }else{
            _inputField.contentType = InputField.ContentType.Password;
        }
    }
 
    public void OnPointerDown(PointerEventData eventData){
        Visibility(true);
        _inputField.ForceLabelUpdate();
    }
 
    public void OnPointerUp(PointerEventData eventData){
        Visibility(false);
        _inputField.ForceLabelUpdate();
    }
}
