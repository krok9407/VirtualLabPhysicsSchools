using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class testik : MonoBehaviour
{
    [SerializeField] private WebManager webManager;
    [SerializeField] private TMP_InputField login, password;
    [SerializeField] private TMP_Text error;
    [SerializeField] private GameObject loggingForm, startButton;
    int onceLoggining = 0;
    private string _lastError = "";
    private void Start() {
        _lastError = webManager.userData.error.errorText;
    }
    public void Login(){
        webManager.Logging(login.text, password.text);
    }
    private void Update() {
        if(!webManager.userData.error.isError){
            onceLoggining++;
        }
        if(_lastError != webManager.userData.error.errorText)
        {
            if(webManager.userData.error.errorText == "Password"){
                error.text = "Ошибка \"Не верный пароль\"";
            }else if(webManager.userData.error.errorText == "User"){
                error.text = "Ошибка \"Пользователя с таким именем не существует\"";
            } else {
                error.text ="Ошибка:\"Подключение к серверу отсутствует\"";
            }
        }
        if(onceLoggining == 1){
            loggingForm.SetActive(webManager.userData.error.isError);
            startButton.SetActive(!webManager.userData.error.isError);
        }
    }
}
