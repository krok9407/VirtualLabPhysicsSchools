using UnityEngine;

namespace Video{
    public class Screen : MonoBehaviour
    {
        void Start()
        {
            gameObject.SetActive(false);
        }
        public void Off(){
            gameObject.SetActive(false);
        }
        public void On(){
            gameObject.SetActive(true);
        }
    }
}
