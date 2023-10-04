using UnityEngine;
using TMPro;
using DG.Tweening;
using System;

public class ThreeDInputField : MonoBehaviour
{
    bool enable = false;
    private TMP_Text text;
    private MeshRenderer border;
    private MeshRenderer background;
    [SerializeField] private TextType textType;

    void Start() {
        text = GetComponent<TMP_Text>();
        border = transform.GetChild(0).GetComponent<MeshRenderer>();
        border.material.DOFade(0f,1f);
        background = transform.GetChild(1).GetComponent<MeshRenderer>();
        background.material.DOFade(0f, 1f);
    }
    void OnMouseExit() {
        enable= false;
        border.material.DOFade(0f, 1f);
        background.material.DOFade(0f, 1f);
    }
    void OnMouseDown() {
        enable = true;
        background.material.DOFade(1f, 1f);
    }
    void OnMouseOver() {
        border.material.DOFade(1f, 1f);
    }

    void Update()
    {
        if (enable) {
            if (Input.GetKeyDown(KeyCode.Backspace))
            {
                if (text.text.Length > 0)
                {
                    text.text = text.text[..^1];
                }
            }
            else if (!Input.GetKey(KeyCode.Backspace)){
                if (textType == TextType.Числа) {
                    text.text += Input.inputString;
                    if (!double.TryParse(text.text, out double value))
                    {
                        text.text = text.text[..^1];
                    }
                }
            }
        }
    }
}

public enum TextType
{
    Текст,
    Числа,
    Пароль,
    Email,
    Телефон
}
