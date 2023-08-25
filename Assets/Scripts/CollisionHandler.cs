using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollisionHandler : MonoBehaviour {

    private int waveNumber;
    public float distanceX, distanceZ;
    public float[] waveAmplitude;
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnCollisionEnter(Collision collision) {
        if (collision.rigidbody) {
            //increase WaveNumber
            waveNumber++;
            //I only have 8 Value Sets so if its 9 I set it back to 1
            if (waveNumber == 9) {
                waveNumber = 1;
            }

            waveAmplitude[waveNumber - 1] = 0; 
            
            //collision Position
            distanceX = this.transform.position.x - collision.gameObject.transform.position.x;
            distanceZ = this.transform.position.z - collision.gameObject.transform.position.z;

            Renderer renderer = new Renderer();
            renderer.material.SetFloat("_OffsetX" + waveNumber, distanceX);
        }
    }
}
