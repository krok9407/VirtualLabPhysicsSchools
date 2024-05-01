using UnityEngine;

public class ChangeDynamometers : MonoBehaviour
{
    [SerializeField] private GameObject effect;
    [SerializeField] private GameObject[] dynamometers;
    int index = 0;
    private void Start() { }
    public void NextDynamometer(int direction = 1)
    {
        if (direction == -1 && index > 0) index--;
        else if (direction == -1 && index == 0) index = dynamometers.Length - 1;
        else if (direction == 1 && index < (dynamometers.Length - 1)) index++;
        else if (direction == 1 && index == (dynamometers.Length - 1)) index = 0;
        foreach (GameObject obj in dynamometers)
        {
            if (obj != null) { obj.SetActive(false); }
        }
        dynamometers[index].SetActive(true);
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
