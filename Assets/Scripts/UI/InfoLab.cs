using UnityEngine;
using UnityEngine.UI;
using System.Collections.Generic;

[System.Serializable]
public class Answer
{
    public string title; 
    public string answerFirst;
    public string answerSecond;
}


public class InfoLab : MonoBehaviour
{
    [SerializeField] private int number = 1;
    [SerializeField] private string[] Lessons;

    private float time = 0f;
    private bool startLab;
    [SerializeField] private Text labelText;
    private InteractiveElements _elements;
    public Answer[] answers;
    public Answer[] Answers => answers;

    
    private void Awake()
    {
        _elements = GetComponent<InteractiveElements>();
    }
    public void StartLab(){
        startLab = true;
        labelText.gameObject.SetActive(true);
        _elements.OnAll();
    }
    public void CloseLab(){
        startLab = true;
        labelText.gameObject.SetActive(false);
        _elements.OffAll();
    }

    public string GetNumber(){
        return $"������������ �������� {number}";
    }

    private void Update() {
        if(startLab) {
            time+=Time.deltaTime;
            labelText.text = "����� ���������� ������"+ "\n" +
            (int)time/3600 + ":" +
            (int)time/60+ ":" +
            (int)time%60;
        }
    }
    
}
