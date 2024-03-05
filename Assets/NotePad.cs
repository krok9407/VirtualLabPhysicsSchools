using UnityEngine;
using UnityEngine.UI;
using System.Collections.Generic;

public class NotePad : MonoBehaviour
{
    [SerializeField] List<Button> buttons;
    [SerializeField] List<GameObject> pages;

    [SerializeField] private Color defaultColor = new Color(0.7647059f, 0.7647059f, 0.7647059f);
    [SerializeField] private Color defaultSelected = new Color(0.01960784f, 0.4862745f, 0.9607844f);
    [SerializeField] private List<Image> imagesButton;
    private void Start()
    {
        foreach (var button in buttons)
        {
            imagesButton.Add(button.GetComponent<Image>());
        }
        OpenPage();
    }
    public void OpenPage(Button button=null)
    {
        if (button == null) { button = buttons[0]; }
        if (button == buttons[0])
        {
            pages[0].SetActive(true);
            pages[1].SetActive(false);
            imagesButton[0].color = defaultSelected;
            imagesButton[1].color = defaultColor;
        }
        else
        {
            pages[1].SetActive(true);
            pages[0].SetActive(false);
            imagesButton[1].color = defaultSelected;
            imagesButton[0].color = defaultColor;
        }
    }

}
