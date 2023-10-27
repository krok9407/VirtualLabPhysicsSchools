using DG.Tweening;
using UnityEngine;

public class Dynamometer : MonoBehaviour
{
    [SerializeField] private Transform spring;
    [SerializeField] float minPosition = 0f;
    [SerializeField] float maxPosition = 0.1f;
    [SerializeField] float maxValue = 1.0f;
    [SerializeField] Transform pointJoinng;
    private float value = 0f;
    private float position = 0f;

    [HideInInspector] public bool isBusy = false;
    private Cargo joiningCargo;
    private short indexForce = 0;
    [HideInInspector] public short IndexForce => indexForce;
    [HideInInspector] public float Value => value;
    [HideInInspector] public Cargo JoiningCargo => joiningCargo;
    private void Start()
    {
        position = minPosition;
        if (maxValue == 5f) indexForce = 1;
        ChangePosition();
    }
    public void ConnectCargo(Transform cargo)
    {
        joiningCargo = cargo.GetComponent<Cargo>();
        cargo.position = pointJoinng.position;
        cargo.rotation = pointJoinng.rotation;
        cargo.transform.SetParent(pointJoinng.transform.parent);
        isBusy = true;
        ChangePosition(joiningCargo.force[indexForce]);
    }
    //выделить в отдельный класс вместе с watervolume
    private float Map(float input, float inputMin, float inputMax, float min, float max)
    {
        return min + (input - inputMin) * (max - min) / (inputMax - inputMin);
    }
    public void ChangePosition(float force = 0f)
    {
        value = Map(position, minPosition, maxPosition, 0f, maxValue);
        value +=force;
        position = Map(value, 0f, maxValue, minPosition, maxPosition);
        spring.DOLocalMoveY(position, 1f);
    }
}
