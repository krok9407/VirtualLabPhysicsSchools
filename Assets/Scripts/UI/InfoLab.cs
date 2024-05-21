using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.UIElements;

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
    [SerializeField] [TextAreaAttribute] private string task;
    [SerializeField] private List<GameObject> elements;
    
    public bool complited = false;

    public Answer[] Answers => answers;
    public string Lesson => lesson;
    public string Task => task;
    public List<GameObject> Elements => elements;
    
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
    [SerializeField] private bool startLab = false;
    [SerializeField] private Text timer; 
    private InteractiveElements _elements;

    [SerializeField] public bool changeLaboratory = false;


    private void Awake()
    {
        _elements = GetComponent<InteractiveElements>();
    }
    public void StartLab(){
        startLab = true;
        changeLaboratory = true;
        timer.gameObject.SetActive(true);
        PrintLessonsInfo(0);
    }
    public void CloseLab(){
        startLab = true;
        timer.gameObject.SetActive(false);
        _elements.EnabledAll(false);
    }

    //direction +1 - следующая, -1 - предыдущая
    private void ChangeLaboratory(int direction)
    {
        foreach (GameObject element in laboratorys[activeLab].Elements)
        {
            element.SetActive(false);
        }
        if(direction==1) activeLab++;
        else activeLab--;
        if (activeLab >= laboratorys.Length) activeLab = 0;
        else if (activeLab < 0) activeLab = (short)(laboratorys.Length - 1);
        foreach (GameObject element in laboratorys[activeLab].Elements)
        {
            element.SetActive(true);
        }
    }

    [SerializeField] GameObject enter;
    [SerializeField] GameObject taskBoard;
    [SerializeField] GameObject taskPrefab;
    private List<Lesson> listLessons = new List<Lesson>();
    private void PrintUI(bool enabled, int lengthList = 0, float fontSizeTitle = 48f, string titleText = "заголовок")
    {
        DeleteList();
        enter.SetActive(enabled);
        taskBoard.SetActive(enabled);
        
        if (enabled)
        {
            TextMeshProUGUI title = enter.GetComponentInChildren<TextMeshProUGUI>();
            title.fontSize = fontSizeTitle;
            title.text = titleText;
            for (short i = 0; i < lengthList; i++)
            {
                GameObject listElement = Instantiate(taskPrefab, taskBoard.transform);
                Lesson lesson = listElement.GetComponent<Lesson>();
                lesson.number.text = (i+1).ToString() + '.';
                listLessons.Add(lesson);
            }
        }
    }
    private void DeleteList()
    {
        listLessons.Clear();
        for (int i = 0; i < taskBoard.transform.childCount; i++)
        {
            Destroy(taskBoard.transform.GetChild(i).gameObject);
        }
    }
    public void PrintLessonsInfo(short numberLab = -1)
    {

        int length = laboratorys[numberLab].Answers.Length;

        if (numberLab >= 0)
        {
            Laboratory lab = laboratorys[numberLab];

            if (lab.Answers[length - 1].AnswerSecond == "") { length *= 2; length--; }
            else { length *= 2; }

            PrintUI(true, length,24f, laboratorys[numberLab].Lesson);

            for (int i = 0; i < length; i++)
            {
                Answer answer = lab.Answers[i / 2];

                if (answer.complited) listLessons[i].taskText.fontStyle = FontStyles.Subscript;
                else listLessons[i].taskText.fontStyle = FontStyles.Normal;

                if (i % 2 == 0) listLessons[i].PrintTask(answer.AnswerFirst);
                else listLessons[i].PrintTask(answer.AnswerSecond);
            }
        }
        
    }
    
    public void PrintAllInfo(bool enabled)
    {
        PrintUI(enabled, laboratorys.Length, 48f, $"Лабораторный комплект №{number}");
        for (int i = 0; i < listLessons.Count; i++)
        {
            if (!Laboratory[i].complited) listLessons[i].taskText.fontStyle = FontStyles.Subscript;
            else listLessons[i].taskText.fontStyle = FontStyles.Normal;
            listLessons[i].PrintTask(Laboratory[i].Lesson);
        }
    }

    private void Update() {
        if(startLab) {
            if (changeLaboratory)
            {
                if (Input.GetKeyUp(KeyCode.LeftArrow))
                {
                    ChangeLaboratory(-1);
                    PrintLessonsInfo(activeLab);
                }
                else if (Input.GetKeyUp(KeyCode.RightArrow))
                {
                    ChangeLaboratory(1);
                    PrintLessonsInfo(activeLab);
                }
                else if (Input.GetKeyUp(KeyCode.Return))
                {
                    _elements.EnabledAll(true);
                    changeLaboratory = false;
                    PrintUI(false);
                }
            }
            time +=Time.deltaTime;
            timer.text = "Время выполнения работы"+ "\n" +
            (int)time/3600 + ":" +
            (int)time/60+ ":" +
            (int)time%60;
        }
    }
    
}
