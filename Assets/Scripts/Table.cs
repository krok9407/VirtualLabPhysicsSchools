using UnityEngine;

public class Table : MonoBehaviour
{
   private void OnCollisionEnter(Collision col)
   {
        if (col.gameObject.TryGetComponent(out Cargo cargo)){
            cargo.contactToGround = true;
        }
   }
   private void OnCollisionExit(Collision col) {
        if (col.gameObject.TryGetComponent(out Cargo cargo)){
            cargo.contactToGround = false;
        }
   }
}
