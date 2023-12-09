using DG.Tweening;
using UnityEngine;

public class AnimationCargo : MonoBehaviour
{
    [SerializeField] private Vector3 target;
    private Vector3 _startPosition;
    [Range(0.1f, 1f)]
    [SerializeField] private float duration = .5f;
    Sequence mySequence;
    void OnEnable()
    {
        mySequence = DOTween.Sequence();
        _startPosition = transform.position;
        mySequence.Append(transform.DOLocalMove(target, duration).SetLoops(-1, LoopType.Yoyo));
    }
    private void OnDisable()
    {
        mySequence.Kill();
        transform.position = _startPosition;
    }
}
