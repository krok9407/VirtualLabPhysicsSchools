using UnityEngine;

public class OnOffScales : MonoBehaviour
{
    [SerializeField] private GameObject tablo;
    private void Awake() {
        tablo.SetActive(false);
    }
    public void OnOff(){
        if(tablo.activeSelf)    tablo.SetActive(false);
        else                    tablo.SetActive(true);  
    }
}
