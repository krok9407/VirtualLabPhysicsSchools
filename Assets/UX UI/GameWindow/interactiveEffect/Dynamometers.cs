using UnityEngine;

public class Dynamometers : MonoBehaviour
{
    [SerializeField] private GameObject effect;
    [SerializeField] private Dynamometer[] allDynamometers;
    public Dynamometer[] AllDynamometer => allDynamometers;
    int index = 0;
    private void Start() { }
    public void NextDynamometer(int direction = 1)
    {
        if (direction == -1 && index > 0) index--;
        else if (direction == -1 && index == 0) index = allDynamometers.Length - 1;
        else if (direction == 1 && index < (allDynamometers.Length - 1)) index++;
        else if (direction == 1 && index == (allDynamometers.Length - 1)) index = 0;
        foreach (Dynamometer obj in allDynamometers)
        {
            if (obj != null) { obj.gameObject.SetActive(false); }
        }
        allDynamometers[index].gameObject.SetActive(true);
    }
    private void OnMouseEnter()
    {
        if(this.enabled) effect.SetActive(true);
    }
    private void OnMouseOver()
    {
        if (this.enabled)
        {
            if (Input.GetKeyDown(KeyCode.LeftArrow))
            {
                NextDynamometer(-1);
            }
            else if (Input.GetKeyDown(KeyCode.RightArrow))
            {
                NextDynamometer(1);
            }
        }
    }
    private void OnMouseExit()
    {
        effect.SetActive(false);
    }
}
