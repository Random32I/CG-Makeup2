using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using UnityEngine;

public class PlayerMove : MonoBehaviour
{
    [SerializeField] Rigidbody rig;
    [SerializeField] float speed;
    [SerializeField] GameObject enemy;

    [SerializeField] Material Hologram;
    [SerializeField] Material Diffuse;

    [SerializeField] Material BlueLUT;
    [SerializeField] Material GreenLUT;
    [SerializeField] GameObject camera;

    float timeStamp;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Time.timeSinceLevelLoad - timeStamp >= 0.5f)
        {
            enemy.GetComponent<MeshRenderer>().material = Diffuse;
            camera.GetComponent<CameraLut>().m_renderMaterial = GreenLUT;
        }
        rig.velocity = new Vector3(Input.GetAxis("Vertical") * speed, 0, Input.GetAxis("Horizontal") * -speed);

        if (Input.GetMouseButtonDown(0))
        {
            Punch();
        }
    }

    void Punch()
    {
        enemy.GetComponent<MeshRenderer>().material = Hologram;
        camera.GetComponent<CameraLut>().m_renderMaterial = BlueLUT;
        timeStamp = Time.timeSinceLevelLoad;
    }
}
