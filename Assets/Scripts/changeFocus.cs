using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class changeFocus : MonoBehaviour
{
   [SerializeField] private List<Selectable> interactableObj = new List<Selectable>();
   private int activeIndex = 0;
   public void Change(){
        if (Input.GetKeyDown(KeyCode.Tab)) {
            activeIndex++;
            if(activeIndex == interactableObj.Count){
                activeIndex = 0;
            }
            interactableObj[activeIndex].Select();
        }
    }
    private void Update() {
        Change();
    }
}
