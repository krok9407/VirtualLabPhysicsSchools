using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections;
using UnityEngine;
using System;
using UnityStandardAssets.Water;

public class Cargo : MonoBehaviour
{
    [SerializeField] private float volume;
    public List<float> mass = new List<float>();
    [HideInInspector] public float currentMass;
    [HideInInspector] public Rigidbody _rigidbody;
    public bool contactToGround = false;
    private Vector3 _startPosition;
    private Transform _parent;

    private enableCargoEffect _effect;
    private WaterVolume _water;
    private MeshRenderer _mesh;
    private DragElements _drag;


    private void Start()
    {
        _rigidbody = GetComponent<Rigidbody>();
        currentMass = mass[0];
        _startPosition = transform.position;
        _parent = transform.parent;
        _drag = GetComponent<DragElements>();
    }

    public void StartPosition()
    {
        transform.position = _startPosition;
        transform.SetParent(_parent);
    }

    public void SetMass(int index)
    {
        currentMass = mass[index];
        _rigidbody.mass = currentMass;
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.TryGetComponent<WaterVolume>(out WaterVolume _waterVolume))
        {
            StartCoroutine(ChangeVolumeWater(_waterVolume, true));
            _waterVolume.cargoInside = true;
        }
    }

    void OnTriggerExit(Collider other)
    {
        if (other.TryGetComponent<WaterVolume>(out WaterVolume _waterVolume))
        {
            StartCoroutine(ChangeVolumeWater(_waterVolume, false));
            _waterVolume.cargoInside = true;
        }
    }

    // private void OnCollisionEnter(Collision col){
    // if (col.gameObject.TryGetComponent(out Dynamometer dynamometer)){
    //     Transform attachmentPoint = col.gameObject.GetComponentInChildren<Attachment>().gameObject.transform;
    //     gameObject.transform.SetParent(col.transform);
    //     gameObject.transform.position = attachmentPoint.position;
    //     gameObject.transform.rotation = attachmentPoint.rotation;    
    // }
    // }
    private IEnumerator ChangeVolumeWater(WaterVolume _waterVolume, bool fill)
    {
        float goalVolume = 0f;
        while (goalVolume < volume)
        {
            goalVolume += volume * 0.05f;
            if (fill)
            {
                _waterVolume.Recalculation(volume * 0.05f);
            }
            else
            {
                _waterVolume.Recalculation(-volume * 0.05f);
            }
            yield return new WaitForFixedUpdate();
        }
        yield return null;
    }

    void Update()
    {
        bool checkGlass = false;
        if (_drag.isDrag)
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit[] hits;
            hits = Physics.RaycastAll(ray, 100.0F);
            foreach (var hit in hits)
            {
                if (hit.collider.gameObject.TryGetComponent<WaterVolume>(out _water))
                {
                    checkGlass = true;
                    _mesh = _water.gameObject.GetComponent<MeshRenderer>();
                    _mesh.enabled = false;
                    _effect = _water.GetComponentInChildren<enableCargoEffect>();
                    _effect.EnableEffect(Int32.Parse(gameObject.name), true);
                    break;
                }
                else
                {
                    checkGlass = false;
                }
            }
            if ((!checkGlass || hits.Length < 1) && _effect != null)
            {
                _effect.EnableEffect(Int32.Parse(gameObject.name), false);
                _mesh.enabled = true;
            }
        }
    }
    private void OnMouseUp()
    {
        if (_mesh != null)
        {
            _mesh.enabled = true;
        }
        if (_effect.gameObject.activeSelf)
        {
            _effect.EnableEffect(Int32.Parse(gameObject.name), false);
            _rigidbody.constraints = RigidbodyConstraints.None;
            Transform attachmentPoint = _water.gameObject.GetComponentInChildren<Attachment>().gameObject.transform;
            gameObject.transform.SetParent(attachmentPoint.transform);
            gameObject.transform.position = attachmentPoint.position;
            gameObject.transform.rotation = attachmentPoint.rotation;
        }
    }
}
