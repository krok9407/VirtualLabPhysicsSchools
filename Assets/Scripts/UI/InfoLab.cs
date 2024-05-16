using UnityEngine;
using UnityEngine.UI;

[System.Serializable]
public class Answer
{
    [SerializeField] private string title;
    public string Title => title;
    [SerializeField] private string answerFirst;

    public bool complited = false;

    public string AnswerFirst => answerFirst;
    [SerializeField] private string answerSecond;
    public string AnswerSecond => answerSecond;
}
[System.Serializable]
public class Laboratory
{
    [SerializeField] private string lesson;
    [SerializeField] private Answer[] answers;
    [SerializeField][TextAreaAttribute] private string task;
    
    public bool complited = false;

    public Answer[] Answers => answers;
    public string Lesson => lesson;
    public string Task => task;
    
}


public class InfoLab : MonoBehaviour
{

    [SerializeField][TextAreaAttribute] private string theory;

    public string Theory => theory;

    [SerializeField] private Laboratory[] laboratorys;
    public Laboratory[] Laboratory => laboratorys;

    [SerializeField] private short number = 1;

    private short activeLab = 0;
    public short ActiveLab => activeLab;

    private float time = 0f;
    private bool startLab;
    [SerializeField] private Text labelText; //зачем?
    private InteractiveElements _elements;

    
    private void Awake()
    {
        _elements = GetComponent<InteractiveElements>();
    }
    public void StartLab(){
        startLab = true;
        labelText.gameObject.SetActive(true);
        _elements.EnabledAll(true);
    }
    public void CloseLab(){
        startLab = true;
        labelText.gameObject.SetActive(false);
        _elements.EnabledAll(false);
    }

    public string GetNumber(){
        return $"Лабораторный комплект №{number}";
    }

    private void Update() {
        if(startLab) {
            time+=Time.deltaTime;
            labelText.text = "Время выполнения работы"+ "\n" +
            (int)time/3600 + ":" +
            (int)time/60+ ":" +
            (int)time%60;
        }
    }
    
}
