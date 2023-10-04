using System.Collections;
using UnityEngine;

namespace Video{
    public class Monitor : Video.Screen
    {
        private MeshRenderer _renderer;
        private UnityEngine.Video.VideoPlayer videoPlayer;
        [SerializeField] private Material[] materials;
        void Start()
        {
            _renderer = GetComponent<MeshRenderer>();
            _renderer.material = materials[0];
            gameObject.SetActive(false);
            videoPlayer = GetComponent<UnityEngine.Video.VideoPlayer>();
        }
        public new void On(){
            _renderer.material = materials[1];
            gameObject.SetActive(true);
        }
        public new void Off(){
            _renderer.material = materials[0];
            videoPlayer.Pause();
        }
    }
}