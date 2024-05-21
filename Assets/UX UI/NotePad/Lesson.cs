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
        gameObject.name = task;
        if (task.Length > 0)
        {
            StartCoroutine(PrintText(task));
        }
    }

    IEnumerator PrintText(string text)
    {
        foreach (var sym in text)
        {
            taskText.text += sym;
            yield return new WaitForSeconds(1f / (text.Length * speed));
        }
    }

}
