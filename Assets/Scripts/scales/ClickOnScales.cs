using UnityEngine;
using UnityEngine.Events;

public class ClickOnScales : MonoBehaviour
{
    private Animator _animator;
    public UnityEvent events;
    private void Start() {
        _animator = transform.parent.gameObject.GetComponent<Animator>();
    }
    public void OnMouseDown(){
        _animator.SetTrigger(gameObject.name);
        events.Invoke();
    }
}
