using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimationCargo : MonoBehaviour
{
    [SerializeField] private Vector3 target;
    private Vector3 _startPosition;
    [Range(0.1f, 1f)]
    [SerializeField] private float duration = .5f;
    Tween myTween;
    private void OnEnable()
    {
        _startPosition = transform.position;
        myTween = transform.DOLocalMove(target, duration).SetLoops(-1, LoopType.Yoyo);
    }
    private void OnDisable()
    {
        myTween.SetLoops(0);
        myTween.Complete();
        myTween.Kill();
        transform.position = _startPosition;
    }
}
