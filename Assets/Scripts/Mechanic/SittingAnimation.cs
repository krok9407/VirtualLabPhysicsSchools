using UnityEngine;
using DG.Tweening;
public class SittingAnimation : MonoBehaviour
{
    InfoLab infoLab;
    [SerializeField] private Transform transformFirstPersonCharacter;
    [SerializeField] private GameObject controller;
    [SerializeField] PlayingOrPaused videoPlayer;
    [HideInInspector] public InteractiveElements interactiveElements;
    public bool busy = false;
    Sequence animation;
    [SerializeField] private EnableDisplay enableDisplay;
    [SerializeField] private UnityStandardAssets.Characters.FirstPerson.FirstPersonController firstPersonControllerScript;

    public void Sitting(WorkSpace workSpace, InfoLab infoLab)
    {
        animation = DOTween.Sequence();
        this.infoLab = infoLab;
        Vector3 sittingPosition = new Vector3(workSpace.chair.position.x,
            workSpace.chair.position.y + 1f,
            workSpace.chair.position.z);
        Animation(true, sittingPosition, workSpace.targetVision.position);
    }
    
    public void Animation(bool forward, Vector3 position, Vector3 towards)
    {
        if (forward)
        {
            animation.Join(transform.DOMove(position, 2f)).
            Append(transform.DOLookAt(towards, 2f))
            .SetAutoKill(false)
            .OnComplete(() =>
            {
                infoLab.StartLab();
            })
            .OnRewind(() => 
            {
                transformFirstPersonCharacter.gameObject.SetActive(true);
                enableDisplay.enabled = true;
                firstPersonControllerScript.enabled = true;
                gameObject.SetActive(false);
            });
        }
        else
        {
            animation.Rewind();
        }
    }

    void Update()
    {
        if (!busy)
        {
            if (Input.GetKeyDown(KeyCode.E))
            {
                infoLab.CloseLab();
                interactiveElements.EnabledAll(false);
                Animation(false, transformFirstPersonCharacter.position, transformFirstPersonCharacter.forward);
                try
                {
                    videoPlayer.CloseLessons();
                }
                catch { }
            }
        }
    }
}
