using UnityEngine;


public class enableCargoEffect : MonoBehaviour
{
    private AnimationCargo[] cargos;
    [SerializeField] private Vector3[] targets;
    [SerializeField] private GameObject arrow;
    [SerializeField] private GameObject water;
    void Start()
    {
        cargos = GetComponentsInChildren<AnimationCargo>(); 
        for(int i = 0; i < cargos.Length; i++)
        {
            EnableEffect(i, false);
        }
    }

    public void EnableEffect(int numberEffect, bool isEnabled){
        cargos[numberEffect].gameObject.SetActive(isEnabled);
        arrow.SetActive(isEnabled);
        water.SetActive(isEnabled);
    }
}
