using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.Networking;

[System.Serializable]
public class UserData
{
    public Students students;
    public Error error;
}
[System.Serializable]
public class Error
{
    public string errorText;
    public bool isError;
}
[System.Serializable]
public class Students
{
    public int id;
    public string allTime; 
    public string timeFirstLab;

    public Students(int id, string allTime, string timeFirstLab)
    {
        this.id = id;
        this.allTime = allTime;
        this.timeFirstLab = timeFirstLab;
    }
    public void SetAllTime(string allTime) { this.allTime = allTime;}
    public void SetTimeFirstLab(string timeFirstLab) { this.timeFirstLab = timeFirstLab;}
}

public class WebManager : MonoBehaviour
{
    public UserData userData = new UserData();
    [SerializeField] private string targetURL;

    //типы запросов
    public enum RequestType
    {
        logging, setAnswer
    }


    public string GetUserData(UserData data)
    {
        return JsonUtility.ToJson(data);
    }
    public UserData SetUserData(string data)
    {
        return JsonUtility.FromJson<UserData>(data);
    }
    private void Start()
    {
        userData.error = new Error(){errorText="¬ведите логин и пароль",isError = true};
        userData.students = new Students(0,"00:00:00","00:00:00");
        print(GetUserData(userData));
    }


    public void Logging(string login, string password)
    {   
        StopAllCoroutines();
        WWWForm form = new WWWForm();
        form.AddField("type", RequestType.logging.ToString());
        form.AddField("login", login);
        form.AddField("password", password); 
        StartCoroutine(SendData(form));
    }

    public void SetAnswer(int userID,  int numberLaboratory, List<string> answers)
    {
        WWWForm form = new WWWForm();
        form.AddField("type", RequestType.setAnswer.ToString());
        form.AddField("id", userID);
        for (int i = 0; i < answers.Count; i++) { 
            form.AddField("Answer"+(i+1).ToString(), answers[i]);
        }
        StartCoroutine(SendData(form));
    }

    IEnumerator SendData(WWWForm form)
    {
        UnityWebRequest www = UnityWebRequest.Post(targetURL, form);
        yield return www.SendWebRequest();

        if (www.result != UnityWebRequest.Result.Success)
        {
            Debug.Log(www.error);
        }
        else
        {
            userData = SetUserData(www.downloadHandler.text);
        }
    }
}
