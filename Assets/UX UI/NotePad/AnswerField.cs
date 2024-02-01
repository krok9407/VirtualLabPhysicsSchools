using UnityEngine;
using TMPro;

public class AnswerField : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI title;
    [SerializeField] private TextMeshProUGUI[] labels;
    [SerializeField] private TextMeshProUGUI[] answers;
    void Start()
    {
        //CleanField();
    }
    void CleanField()
    {
        title.text = "";
        foreach (var label in labels)
        {
            label.text = "";
        }
        foreach(var answer in answers)
        {
            CleanAnswer(answer);
        }
    }
    public void CleanAnswer(TextMeshProUGUI answer)
    {
        answer.text = "";
    }
    public void SetAnswer(string title, string labelFirst, string labelSecond)
    {
        this.title.text = title;
        labels[0].text = labelFirst;
        labels[1].text = labelSecond;
    }
    string GetAnswer(int colNumber)
    {
        return answers[colNumber].text;
    }
}
