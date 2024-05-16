using UnityEngine;

public class LeftPage : MonoBehaviour
{
    [SerializeField] private TextRenderer theoryText;
    [SerializeField] private TextRenderer taskText;
    
    public void FillTheory(string theory)
    {
        theoryText.PrintTheory(theory);
    }
    public void FillTask(string task)
    {
        taskText.PrintTheory(task);
    }
    public void ClearAllLabel()
    {
        foreach (GameObject label in theoryText.AllList) Destroy(label);
        foreach (GameObject label in taskText.AllList) Destroy(label);
        theoryText.AllList.Clear();
        taskText.AllList.Clear();
    }
}
