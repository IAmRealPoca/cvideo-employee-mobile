package com.fptu.swd391.cvideo_mobile

import android.content.Context
import android.util.AttributeSet
import android.widget.FrameLayout

class QuestionBoard(context: Context, attrs: AttributeSet? = null, defStyle: Int = -1) : FrameLayout(context, attrs, defStyle) {
    init {
        inflate(context, R.layout.question_board, this)
    }
}