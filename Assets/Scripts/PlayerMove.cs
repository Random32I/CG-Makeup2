using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMove : MonoBehaviour
{
    [SerializeField] Rigidbody rig;
    [SerializeField] float speed;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        rig.velocity = new Vector3(Input.GetAxis("Vertical") * speed, 0, Input.GetAxis("Horizontal") * -speed);

        if (Input.GetMouseButtonDown(0))
        {
            Punch();
        }
    }

    void Punch()
    {

    }
}
