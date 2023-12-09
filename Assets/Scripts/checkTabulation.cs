using UnityEngine;
using UnityEngine.UI;


public class checkTabulation : MonoBehaviour
{
    private InputField _input;
    void Start()
    {
        _input = GetComponent<InputField>();
    }
    public void Check(){
        if(_input.text.EndsWith('\t'))
        {
            _input.text = _input.text[..^1];
        }
    }
}
