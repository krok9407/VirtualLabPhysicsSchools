using UnityEngine;
using UnityEngine.UI;
using System.Collections.Generic;

public class NotePad : MonoBehaviour
{
    [SerializeField] List<Button> buttons;
    [SerializeField] List<GameObject> pages;
    public void OpenPage(Button button=null)
    {
        if (button == null) { button = buttons[0]; }
        if (button == buttons[0])
        {
            pages[0].SetActive(true);
            pages[1].SetActive(false);
        }
        else
        {
            pages[1].SetActive(true);
            pages[0].SetActive(false);
        }
        button.Select();
    }
    private void OnEnable()
    {
        OpenPage();
    }
}
