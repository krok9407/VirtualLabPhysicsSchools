
using UnityEngine;

public class RaycastController : MonoBehaviour
{
    private Camera cam;
    private void Start()
    {
        cam = GetComponent<Camera>();
    }
    void Update()
    {
        if (Input.GetMouseButton(1))
        {
            Ray ray = cam.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;

            if (Physics.Raycast(ray, out hit, 100))
            {
                var obj = hit.collider;
                if (obj.TryGetComponent<Cargo>(out Cargo cargo))
                {
                    cargo.StartPosition();
                }
                else if (obj.TryGetComponent<Dynamometers>(out Dynamometers dynamometers))
                {
                    foreach (Dynamometer dynamometer in dynamometers.AllDynamometer)
                    {
                        if (dynamometer.isBusy && dynamometer.gameObject.activeSelf)
                        {
                            dynamometer.UnhookCargo();
                        }
                    }
                }
                else if (obj.TryGetComponent<WaterVolume>(out WaterVolume _water))
                {
                    if (_water.CargoInside)
                    {
                        foreach (var cargoInWater in _water.cargos)
                        {
                            cargoInWater.StartPosition();
                        }
                    }
                }
                else if (obj.TryGetComponent<Cargos>(out Cargos cargos))
                {
                    cargos.ResetAll();
                }
            }
        }
    }
}
