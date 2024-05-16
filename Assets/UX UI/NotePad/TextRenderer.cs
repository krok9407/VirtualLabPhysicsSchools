using TMPro;
using UnityEngine;
using System.Collections.Generic;

public class TextRenderer : MonoBehaviour
{
    public GameObject TitleText;
    public GameObject MainText;
    public GameObject ListText;

    private GameObject label;
    [SerializeField] private List<GameObject> allLabel = new List<GameObject>();
    public List<GameObject> AllList => allLabel;

    public void PrintTheory(string text)
    {
       label = Instantiate(MainText, transform);

       allLabel.Add(label);
       char previous—har = text[0];

        foreach (char symbol in text)
        {
            if ((int)symbol == 13 && (int)previous—har == 46)
            {
                label = Instantiate(MainText, transform);
                allLabel.Add(label);
            }
            else if (((int)symbol == 13 && (int)previous—har == 58) || ((int)symbol == 13 && (int)previous—har == 59))
            {
                label = Instantiate(ListText, transform);
                allLabel.Add(label);
            }
            else
            {
                label.GetComponent<TextMeshProUGUI>().text += symbol;
            }
            previous—har = symbol;
        }
    }
}
