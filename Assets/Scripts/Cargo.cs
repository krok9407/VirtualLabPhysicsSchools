using System.Collections.Generic;
using System.Collections;
using UnityEngine;
using System;

public class Cargo : MonoBehaviour
{
    [SerializeField] private float volume;
    public List<float> mass = new List<float>();
    public List<float> force = new List<float>();
    [HideInInspector] public float currentMass;
    [HideInInspector] public Rigidbody _rigidbody;
    public bool contactToGround = false;
    private Vector3 _startPosition;
    private Quaternion _startRotation;
    private Transform _parent;
    private bool checkJoin = false;

    private enableCargoEffect _effect;
    private WaterVolume _water;
    private MeshRenderer _mesh;
    private DragElements _drag;
    private Dynamometer dynamometer;
    private Collider _collider;

    private void Start()
    {
        _rigidbody = GetComponent<Rigidbody>();
        currentMass = mass[0];
        _startPosition = transform.position;
        _startRotation = transform.rotation;
        _parent = transform.parent;
        _drag = GetComponent<DragElements>();
        _collider = GetComponent<Collider>();
    }

    public void StartPosition()
    {
        transform.position = _startPosition;
        transform.rotation = _startRotation;
        transform.SetParent(_parent);
        _rigidbody.constraints = RigidbodyConstraints.FreezeRotation;
        _rigidbody.useGravity = true;
        _collider.enabled = true;
    }

    public void SetMass(int index)
    {
        currentMass = mass[index];
        _rigidbody.mass = currentMass;
    }

    void OnTriggerEnter(Collider trigger)
    {
        if (trigger.TryGetComponent<WaterVolume>(out WaterVolume _waterVolume))
        {
            _waterVolume.Recalculation(volume);
            _water.cargos.Add(this);
        }
    }

    void OnTriggerExit(Collider trigger)
    {
        if (trigger.TryGetComponent<WaterVolume>(out WaterVolume _waterVolume))
        {
            _waterVolume.Recalculation(-volume);
            _water.cargos.Remove(this);
        }
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
                checkGlass = false;
                checkJoin = false;

                var hitObj = hit.collider.gameObject;

                if (hitObj.TryGetComponent<WaterVolume>(out _water))
                {
                    checkGlass = true;
                    _mesh = _water.gameObject.GetComponent<MeshRenderer>();
                    _mesh.enabled = false;
                    _effect = _water.GetComponentInChildren<enableCargoEffect>();
                    _effect.EnableEffect(Int32.Parse(gameObject.name)-1, true);
                    break;
                }
                else if (hitObj.TryGetComponent<Dynamometer>(out dynamometer))
                {
                    checkJoin = true;
                    //запускаем эффект присоединения к динамометру
                    break;
                }

            }
            if ((!checkGlass || hits.Length < 1) && _effect != null)
            {
                _effect.EnableEffect(Int32.Parse(gameObject.name)-1, false);
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
        if (checkJoin)
        {
            if (!dynamometer.isBusy)
            {
                _rigidbody.useGravity = false;
                _collider.enabled = false;
                _rigidbody.constraints = RigidbodyConstraints.FreezePosition;
                dynamometer.ConnectCargo(transform);
            }
        }
        if (_effect != null)
        {
            if (_effect.gameObject.activeSelf) //почему-то тут ругается, разобраться и стопориться
            {
                _effect.EnableEffect(Int32.Parse(gameObject.name) - 1, false);
                _rigidbody.constraints = RigidbodyConstraints.None;
                Transform attachmentPoint = _water.gameObject.GetComponentInChildren<Attachment>().gameObject.transform;
                gameObject.transform.SetParent(attachmentPoint.transform);
                gameObject.transform.position = attachmentPoint.position;
                gameObject.transform.rotation = attachmentPoint.rotation;
            }
        }
    }
}
