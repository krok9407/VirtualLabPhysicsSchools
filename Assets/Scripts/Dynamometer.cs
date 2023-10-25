using UnityEngine;

public class Dynamometer : MonoBehaviour
{
    [SerializeField] float minPosition = 0f;
    [SerializeField] float maxPosition = 0.1f;
    [SerializeField] float maxValue = 1.0f;
    [SerializeField] Transform pointJoinng;
    private float value = 1.0f;
    private float position = 1.0f;
    [HideInInspector] public bool isBusy = false;
    private Cargo joiningCargo;

    [HideInInspector] public float Value => value;
    [HideInInspector] public Cargo JoiningCargo => joiningCargo;
    public void ConnectCargo(Transform cargo)
    {
        joiningCargo = cargo.GetComponent<Cargo>();
        cargo.position = pointJoinng.position;
        cargo.rotation = pointJoinng.rotation;
        cargo.transform.SetParent(pointJoinng.transform.parent);
        isBusy = true;
    }
}
