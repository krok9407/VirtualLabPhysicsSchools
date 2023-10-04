using DG.Tweening;
using UnityEngine;

public class EnableNotepad : ChangeMouse
{
    Transform TopSide;
    private Sequence animationNotepad;
    [SerializeField] private float durationAnimation = 5f;
    [Range(0f,1f)] [SerializeField] private float offset = 0.1f;
    private BoxCollider _collider;
    private void Awake()
    {
        TopSide = transform.GetChild(0);
        _collider = GetComponent<BoxCollider>();
        
    }
    override public void Enable(bool enable)
    {
        if (enable)
        {
            _collider.enabled = false;
            var cam = Camera.main.transform;
            Quaternion camRotation = cam.rotation;
            Quaternion targetRotation = new()
            {
                eulerAngles = new Vector3(90 - camRotation.eulerAngles.x, transform.eulerAngles.y, camRotation.eulerAngles.z)
            };

            animationNotepad = DOTween.Sequence();
            animationNotepad.Join(TopSide.DOLocalRotate(new Vector3(0, 0, -180), durationAnimation))
                .Join(transform.DOMove(Camera.main.transform.position + (cam.transform.forward * offset), durationAnimation))
                .Join(transform.DORotateQuaternion(targetRotation, durationAnimation / 2f)).
                SetAutoKill(false).OnComplete(() => this.enabled = false).OnRewind(() => this.enabled = true);
        }
        else
        {
            _collider.enabled = true;
            animationNotepad.PlayBackwards();
        }
    }

}
