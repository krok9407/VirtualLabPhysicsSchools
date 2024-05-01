using DG.Tweening;
using UnityEngine;

public class MoveArrow : MonoBehaviour
{
    public float speed = 1f;
    private Transform left = null;
    private Transform right = null;
    public Vector3 offset = new Vector3(0.05f,0f,0f);
    private Vector3 leftOffset, rightOffset;
    private Sequence sequence;

    private void Start()
    {
        left = transform.GetChild(0);
        right = transform.GetChild(1);
        gameObject.SetActive(false);
    }

    private void OnEnable()
    {
        sequence = DOTween.Sequence();
        if (left != null || right != null)
        {
            sequence.Append(left.DOLocalMove(left.localPosition + offset, 1f / speed))
                    .Append(left.DOLocalMove(left.localPosition, 1f / speed))
                    .Append(right.DOLocalMove(right.localPosition - offset, 1f / speed))
                    .Append(right.DOLocalMove(right.localPosition, 1f / speed));
        }
    }
    private void Update()
    {
        sequence.OnComplete(() => { sequence.Restart();});
    }

    private void OnDisable()
    {
        sequence.Restart();
        sequence.Pause();
        sequence.Kill();
    }
}
