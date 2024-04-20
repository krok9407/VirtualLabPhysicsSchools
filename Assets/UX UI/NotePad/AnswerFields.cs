using UnityEngine;
using System.Collections.Generic;
using System.Linq;

public class AnswerFields : MonoBehaviour
{
    private Transform leftCol, rightCol;
    [SerializeField] GameObject answerPrefab;
    [SerializeField] private List<GameObject> answers;
    [SerializeField] GameObject voidAnswer;

    void Start()
    {
        leftCol = transform.GetChild(0);
        rightCol = transform.GetChild(1);
    }
    public void DrawTable(Answer[] answers)
    {
        for (int i = 0; i < answers.Length; i++)
        {
            GameObject answer;
            if (i % 2 == 0)
            {
                answer = Instantiate(answerPrefab, leftCol);
            }
            else
            {
                answer = Instantiate(answerPrefab, rightCol);
            }
            answer.name = $"вопрос {i}";
            var labels = answer.GetComponent<AnswerField>();
            labels.SetAnswer(answers[i].Title, answers[i].AnswerFirst, answers[i].AnswerSecond);
            this.answers.Add(answer);
        }
        if (answers.Length%2==1)
        {
            this.answers.Add(Instantiate(voidAnswer, rightCol));
        }
    }
    public void ClearTable()
    {
        foreach (GameObject answer in answers)
        {
            Destroy(answer);
        }
        answers.Clear();
    }
}
