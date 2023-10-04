using UnityEngine;
using System.Collections;

public class GetWeight : MonoBehaviour
{
    [SerializeField] private OnOffScales OnOffScales;
    private BoxCollider _boxCollider;
    float massObjects = 0f;
    float lastMass = 0f;
    public TMPro.TextMeshPro WeightText;
    private string[] measurementSystem = {"g", "oz", "ct"};
    private string charMeasurement;
    public void SetMeansurementSystem(int index){
        charMeasurement = measurementSystem[index];
    }
    [SerializeField] private float speedToDrawNumber=0.05f;
    void OnCollisionEnter(Collision col) {
        massObjects = GetAllMass();
        StartCoroutine(SetNumber(speedToDrawNumber));
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
    public void RepaintWeight(){
        WeightText.text= "";
        float mass = GetAllMass();
        if(mass < 2000f){
            WeightText.text += mass.ToString()+charMeasurement;
        }else{
            WeightText.text = "ERROR";
        }
    }
    private IEnumerator SetNumber(float speed){
        float currentTime = 0f;
        while(currentTime<=1f){
            yield return new WaitForSeconds(speed/4f);
            currentTime+=speed;
            float currentWeight = Mathf.Lerp(lastMass, massObjects, currentTime);
            currentWeight = (float)System.Math.Round(currentWeight, 2);
            if(currentWeight<2000){
                WeightText.text = currentWeight.ToString()+charMeasurement;
            }else{
                WeightText.text = "ERROR";
            }
        }
        lastMass=massObjects;
    yield return null;
    }
}
