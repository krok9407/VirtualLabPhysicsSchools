using UnityEngine;
using System.Collections.Generic;

public class Complects : MonoBehaviour
{
    private List<GameObject> allObjects = new List<GameObject>();
    void Start()
    {
        for (int i = 0; i < transform.childCount; i++)
        {
            var obj = transform.GetChild(i).gameObject;
            allObjects.Add(obj);
            obj.SetActive(false);
        }
    }
}
