using UnityEngine;
using System.Collections;

public class Test : MonoBehaviour
{
    public MovieTexture movie;

    void Start()
    {
        movie.loop = true;
        movie.Play();
    }
}
