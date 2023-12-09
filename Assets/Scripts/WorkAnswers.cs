using UnityEngine;
using System.Collections.Generic;
using TMPro;
using System;

public class WorkAnswers : MonoBehaviour
{
    [SerializeField] GameObject prefabAnswer;
    [SerializeField] private string workText;
    [SerializeField] List<Answers> answers = new List<Answers>();
    private TMP_Text work;
    private Transform secondPage;
    [SerializeField] private float paddingAnswers = 0.33f;
    [SerializeField] WebManager webManager;
    private void Awake()
    {
        work = transform.GetChild(0).GetComponentInChildren<TMP_Text>();
        work.text = workText;
        secondPage = transform.GetChild(1);
        for (int i=0;i< answers.Count;i++)
        {
            var answer = Instantiate(answers[i].prefab, secondPage);
            answers[i].Init(answer);
            answer.transform.localPosition = new Vector3(0, 0, answer.transform.localPosition.z + (paddingAnswers * i));
        }
    }
    public void SendAnswers()
    {
        List <string> valueAnswers = new List<string>();
        foreach (var answer in answers) {
            valueAnswers.Add(answer.GetValue());
        }

        webManager.SetAnswer(webManager.userData.students.id, 1,valueAnswers);
    }
}




[Serializable]
public class Answers 
{
    [HideInInspector] public GameObject prefab;
    [SerializeField]  private string labelText;
    private TMP_Text  labelObject;
    private TMP_Text inputValue;

    public string GetValue() {
        return inputValue.text;
    }

    public void Init(GameObject prefab)
    {
        this.prefab = prefab;
        labelObject = this.prefab.transform.GetChild(0).GetComponent<TMP_Text>();
        labelObject.text = labelText;
        inputValue = this.prefab.transform.GetChild(1).GetComponent<TMP_Text>();
    }
}