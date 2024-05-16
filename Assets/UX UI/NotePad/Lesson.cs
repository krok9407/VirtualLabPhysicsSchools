using UnityEngine;
using TMPro;
using System.Collections;

public class Lesson : MonoBehaviour
{
    public TextMeshProUGUI number;
    public TextMeshProUGUI taskText;
    [SerializeField] float speed = 2f;

    public void PrintTask(string task)
    {
        if (task.Length > 0)
        {
            taskText.text = "";
            StartCoroutine(PrintText(task));
        }
    }

    private IEnumerator PrintText(string text, int index=0)
    {
        if (taskText.text == text)
        {
            yield return null;
        }
        else {
            taskText.text += text[index];
            yield return new WaitForSeconds(1f/ (text.Length*speed));
            if (index < text.Length)
            {
                index++;
                StartCoroutine(PrintText(text,index));
            }
        }
    }
}
