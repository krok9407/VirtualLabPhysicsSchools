using System.Collections.Generic;
using UnityEngine;

public class ChangingUnits : MonoBehaviour
{
    [SerializeField] private List<Cargo> Cargos = new List<Cargo>();
    [SerializeField] private GetWeight getWeight;
    [SerializeField] private TMPro.TextMeshPro WeightText;
    private int index = 0;
    
    public void ChangeUnits(){
        index++;
        if(index>2) index = 0;
        getWeight.SetMeansurementSystem(index);
        getWeight.lastMass = 0f;
        foreach (var cargo in Cargos)
        {
            cargo.SetMass(index);
        }
        //getWeight.RepaintWeight();
    }
}
