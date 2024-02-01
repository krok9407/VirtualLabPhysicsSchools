using DG.Tweening;
using UnityEngine;

public class EnableNotepad : ClickOnObject
{
    Transform TopSide;
    private Sequence animationNotepad;
    [SerializeField] private float durationAnimation = 5f;
    [Range(0f,1f)] [SerializeField] private float offset = 0.1f;
    private BoxCollider _collider;
    [SerializeField]
    private Transform cam;
    private InfoLab infoLab;

    [SerializeField] private Canvas NotepadCanvas;
    AnswerFields answerField;
    private void Awake()
    {
        TopSide = transform.GetChild(0);
        _collider = GetComponent<BoxCollider>();
        infoLab = GetComponentInParent<InfoLab>();
        answerField = NotepadCanvas.GetComponentInChildren<AnswerFields>();
    }
    override public void Enable(bool enable)
    {
        if (enable)
        {
            _collider.enabled = false;
            Quaternion camRotation = cam.rotation;
            Quaternion targetRotation = new()
            {
                eulerAngles = new Vector3(90 - camRotation.eulerAngles.x, camRotation.eulerAngles.y - 180, camRotation.eulerAngles.z)
            };

            answerField.DrawTable(infoLab.Answers);
            animationNotepad = DOTween.Sequence();
            animationNotepad.Join(TopSide.DOLocalRotate(new Vector3(0, 0, -180), durationAnimation))
                .Join(transform.DOMove(Camera.main.transform.position + (cam.transform.forward * offset), durationAnimation))
                .Join(transform.DORotateQuaternion(targetRotation, durationAnimation / 2f)).
                SetAutoKill(false).OnComplete(() => {
                    NotepadCanvas.renderMode = RenderMode.ScreenSpaceOverlay;
                    this.enabled = false;
                }).OnRewind(() => {
                    this.enabled = true;
                    answerField.ClearTable();
                }) ;
        }
        else
        {
            NotepadCanvas.renderMode = RenderMode.ScreenSpaceCamera;
            _collider.enabled = true;
            animationNotepad.PlayBackwards();
            FindObjectOfType<InteractiveElements>().EnableAllMouse(true);
        }

    }
}
