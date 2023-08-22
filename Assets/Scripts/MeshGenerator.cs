using System;
using UnityEngine;
public class MeshGenerator : MonoBehaviour {
    private Mesh mesh;
    
    private Vector3[] verticies;
    private int[] triangles;
    private int verticiesLength;

    public int size;
    public float scale;
    
    // Start is called before the first frame update
    void Start() {
        mesh = new Mesh();
        GetComponent<MeshFilter>().mesh = mesh;
        
        CreateShape();
        UpdateMesh();
    }

    void CreateShape() {

        verticies = new Vector3[(size + 1) * (size + 1)];

        float halfSizeX = (scale * size) / 2;
        float halfSizeZ = (scale * size) / 2;
        
        for (int i = 0, z = 0; z <= size; z++) {
            for (int x = 0; x <= size; x++) {
                float xPos = (x * scale) - halfSizeX;
                float zPos = (z * scale) - halfSizeZ;
                float yPos = 0;
                
                verticies[i] = new Vector3(xPos, yPos, zPos);
                i++;
            }
        }

        triangles = new int[size * size * 6];
        
        int vert = 0;
        int tris = 0;

        for (int z = 0; z < size; z++) {
            for (int x = 0; x < size; x++) {
                triangles[tris + 0] = vert + 0;
                triangles[tris + 1] = vert + size + 1;
                triangles[tris + 2] = vert + 1;
                triangles[tris + 3] = vert + 1;
                triangles[tris + 4] = vert + size + 1;
                triangles[tris + 5] = vert + size + 2;

                vert++;
                tris += 6;
            }

            vert++;
        }
    }

    void UpdateMesh(){
        mesh.Clear();
        mesh.vertices = verticies;
        mesh.triangles = triangles;
        
        mesh.RecalculateNormals();
    }
}
