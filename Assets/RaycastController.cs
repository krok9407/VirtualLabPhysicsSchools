
using UnityEngine;

public class RaycastController : MonoBehaviour
{
   
    void Update()
    {
        if (Input.GetMouseButton(1))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;

            if (Physics.Raycast(ray, out hit, 100))
            {
                var obj = hit.collider;
                if (obj.TryGetComponent<Cargo>(out Cargo cargo))
                {
                    cargo.StartPosition();
                }
                else if (obj.TryGetComponent<Dynamometer>(out Dynamometer dynamometer))
                {
                    if (dynamometer.isBusy)
                    {
                        dynamometer.JoiningCargo.StartPosition();
                        dynamometer.isBusy = false;
                        dynamometer.ChangePosition(-dynamometer.JoiningCargo.force[dynamometer.IndexForce]);
                    }
                }
                else if(obj.TryGetComponent<WaterVolume>(out WaterVolume _water))
                    {
                    if (_water.CargoInside)
                        {
                            foreach (var cargoInWater in _water.cargos) {
                                cargoInWater.StartPosition();
                            }
                        }
                    }
            }

        }
    }
}
