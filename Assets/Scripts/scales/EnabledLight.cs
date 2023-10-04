using UnityEngine;

public class EnabledLight : MonoBehaviour
{
    private bool isEnabled = false;
    [ColorUsage(true, true)]
    public Color EnabledColor;
    [ColorUsage(true, true)]
    public Color DisabledColor;
    public void EnableLight(MeshRenderer meshRenderer)
    {
        if (isEnabled)
        {
            meshRenderer.material.SetVector("_FaceColor", DisabledColor);
            isEnabled = false;
        }
        else
        {
            meshRenderer.material.SetVector("_FaceColor", EnabledColor);
            isEnabled = true;
        }
    }
}
