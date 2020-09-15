package com.fptu.swd391.cvideo_mobile

import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class Question(
        var questionId: Int,
        var questionContent: String,
        var questionTime: Int) {
}