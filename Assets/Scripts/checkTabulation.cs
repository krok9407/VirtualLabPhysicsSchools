using UnityEngine;
using TMPro;


public class checkTabulation : MonoBehaviour
{
    private TMP_InputField _input;
    void Start()
    {
        _input = GetComponent<TMP_InputField>();
    }
    public void Check(){
        if(_input.text.EndsWith('\t'))
        {
            _input.text = _input.text[..^1];
        }
    }
}
