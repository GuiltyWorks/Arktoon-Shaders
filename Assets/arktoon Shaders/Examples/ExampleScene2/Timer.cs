// Copyright (c) 2021 Guilty
// License : MIT
// GitHub : https://github.com/GuiltyWorks
// Twitter : GuiltyWorks_VRC
// Mail : GuiltyWorks@protonmail.com

using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class Timer : MonoBehaviour {
    [SerializeField]
    private int minute;
    [SerializeField]
    private float seconds;
    private float oldSeconds;
    private Text text;

    void Start() {
        minute = 0;
        seconds = 0f;
        oldSeconds = 0f;
        text = GetComponentInChildren<Text>();
    }

    void Update() {
        seconds += Time.deltaTime;
        if (seconds >= 60f) {
            minute++;
            seconds -= 60f;
        }
        if ((int)seconds != (int)oldSeconds) {
            text.text = minute.ToString("00") + ":" + ((int)seconds).ToString("00");
        }
        oldSeconds = seconds;
    }
}
