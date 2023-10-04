using UnityEngine;
using UnityEngine.UI;

public class InfoLab : MonoBehaviour
{
    private int number = 1;
    [SerializeField] private string nameLab = "Сила Архимеда";
    private float time = 0f;
    private bool startLab;
    [SerializeField] private Text labelText;
    public void StartLab(){
        startLab = true;
        labelText.gameObject.SetActive(true);
    }
    public void StopLab(){
        startLab = true;
        labelText.gameObject.SetActive(false);
    }

    public string GetNumber(){
        return "Лабораторная работа №"+number+"\n"+nameLab;
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
