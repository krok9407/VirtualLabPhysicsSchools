using DG.Tweening;
using System;
using System.Collections.Generic;
using UnityEngine;

public class WaterVolume : MonoBehaviour
{
    private MeshRenderer _renderer;
    [SerializeField] private float _fullness= 0.47f;
    [SerializeField] private float _maxFullness = 100f;
    [SerializeField] private float _volume = 0f;
    private bool cargoInside = false;
    public bool CargoInside => cargoInside;
    public List<Cargo> cargos = new List<Cargo>();
    void Awake()
    {
        _renderer = GetComponent<MeshRenderer>();
        _renderer.material.SetFloat("_fullness",_fullness);
    }
    public void Recalculation(float cargoVolume = 0f){
        var _lastFullness = _fullness;
        _volume = Map(_fullness,0.47f,0.643f, 0f, _maxFullness);
        _volume+=cargoVolume;
        _fullness = Map(_volume, 0f, _maxFullness, 0.47f,0.643f);
        _renderer.material.DOFloat(_fullness, "_fullness", 1f);
    }
    private float Map(float input, float inputMin, float inputMax, float min, float max){
	    return min + (input - inputMin) * (max - min) / (inputMax - inputMin);
    }
    private void Update()
    {
        if (cargos.Count > 0) cargoInside = true;
        else cargoInside = false;
    }
    private void OnMouseOver() {
        if(Input.mouseScrollDelta.y>0f){
            if(_fullness<0.643f)    _fullness+=0.001f;
        }else if(Input.mouseScrollDelta.y<0f){
            if(_fullness>0.47f)    _fullness-=0.001f;
        }  
        Recalculation();
    }
}
