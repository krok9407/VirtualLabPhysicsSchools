using UnityEngine;
using TMPro;

public class LeftPage : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI TaskPage;
    [SerializeField] private TextMeshProUGUI TheoryPage;
    public void FillTask(string task)
    {
        TaskPage.text = task;
    }
    public void FillTheory(string theory)
    {
        TheoryPage.text = theory;
    }
}
