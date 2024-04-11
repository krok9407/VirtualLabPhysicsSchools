using UnityEngine;
using TMPro;


public class checkTabulation : MonoBehaviour
{
    private TextMeshProUGUI _input;
    void Start()
    {
        _input = GetComponent<TextMeshProUGUI>();
    }
    public void Check(){
        if(_input.text.EndsWith('\t'))
        {
            _input.text = _input.text[..^1];
        }
    }
}
