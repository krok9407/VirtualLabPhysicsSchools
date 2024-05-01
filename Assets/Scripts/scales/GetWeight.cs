using UnityEngine;
using System.Collections;

public class GetWeight : MonoBehaviour
{
    [SerializeField] private OnOffScales OnOffScales;
    private BoxCollider _boxCollider;
    float massObjects = 0f;
    public float lastMass = 0f;
    public TMPro.TextMeshPro WeightText;
    private string[] measurementSystem = {"g", "oz", "ct"};
    private string charMeasurement = "g";
    public void SetMeansurementSystem(int index){
        charMeasurement = measurementSystem[index];
    }
    [SerializeField] private float speedToDrawNumber=0.05f;
    void OnCollisionEnter(Collision col) {
        massObjects = GetAllMass();
        StartCoroutine(SetNumber(speedToDrawNumber));
    }
    public void ResetMass()
    {
        WeightText.text = "0.00"+ charMeasurement;
    }
    void OnCollisionStay(Collision other)
    {
        massObjects = GetAllMass();
        if (lastMass != massObjects) StartCoroutine(SetNumber(speedToDrawNumber));
    }
    void OnCollisionExit(Collision col) {
        massObjects = GetAllMass();
        StartCoroutine(SetNumber(speedToDrawNumber));
    }
    private void Start() {
        _boxCollider = GetComponent<BoxCollider>();
        WeightText.text = "0,00g";
    }

    private float GetAllMass(){
        float newMass = 0f;
        Collider[] hitColliders = Physics.OverlapBox(_boxCollider.bounds.center, _boxCollider.bounds.size/2f);
        foreach (var collider in hitColliders)
        {
            if(collider.TryGetComponent<Cargo>(out Cargo cargo))
            {
                if (!cargo.contactToGround && !cargo._rigidbody.isKinematic){
                    newMass+=cargo.currentMass;
                }
            }
        }
         return newMass;
    }
    public bool checkError(float mass)
    {
        if ((charMeasurement == "g" && mass < 200)
                    || (charMeasurement == "oz" && mass < 7.1)
                    || (charMeasurement == "ct" && mass < 1000))
            return false;
        else return true;
    }
    /*public void RepaintWeight(){
        WeightText.text= "";
        float mass = GetAllMass();
        if (checkError(mass)) { WeightText.text = "ERROR";  }
        else WeightText.text = mass.ToString() + charMeasurement;
    }*/
    private IEnumerator SetNumber(float speed){
        float currentTime = 0f;
        while (currentTime <= 1f) {
            yield return new WaitForSeconds(speed / 4f);
            currentTime += speed;

            float currentWeight = Mathf.Lerp(lastMass, massObjects, currentTime);
            if(currentWeight<99) currentWeight = (float)System.Math.Round(currentWeight, 4);
            else currentWeight = (float)System.Math.Round(currentWeight, 2);

            if (checkError(currentWeight)) { WeightText.text = "ERROR"; print("ошибка"); }
            else WeightText.text = currentWeight.ToString() + charMeasurement;
        }
        lastMass = massObjects;
    yield return null;
    }
}
