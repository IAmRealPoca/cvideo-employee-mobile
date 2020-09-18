package com.fptu.swd391.cvideo_mobile

import android.content.Context
import android.view.View
import com.google.ar.sceneform.rendering.ModelRenderable
import com.google.ar.sceneform.rendering.Texture
import com.google.ar.sceneform.rendering.ViewRenderable
import java.lang.ref.WeakReference
import java.util.concurrent.CompletableFuture

class ModelLoader(owner:  ModelLoaderCallbacks) {
    companion object {
        private const val TAG = "ModelLoader"
    }

    private var owner: WeakReference<ModelLoaderCallbacks> = WeakReference(owner)
    private var futureModelRenderable: CompletableFuture<Void>? = null
    private var futureViewRenderable: CompletableFuture<Void>? = null
    private var futureTexture: CompletableFuture<Void>? = null


    fun loadModel(context: Context, resourceId: Int):Boolean {
        // Load the face regions renderable.
        // This is a skinned model that renders 3D objects mapped to the regions of the augmented face.
        futureModelRenderable = ModelRenderable.builder()
                .setSource(context, resourceId)
                .build()
                .thenAccept {this.setModelRenderable(it)}
                .exceptionally { this.onException(it) }

        return futureModelRenderable != null
    }

    fun loadViewModel(context: Context, view: View): Boolean {
        futureViewRenderable = ViewRenderable.builder()
                .setView(context, view)
                .build()
                .thenAccept { this.setViewRenderable(it) }
                .exceptionally { this.onException(it) }
        return futureViewRenderable != null
    }

    fun loadTexture(context: Context, resourceId: Int): Boolean {
        futureTexture = Texture.builder()
                .setSource(context, resourceId)
                .build()
                .thenAccept { this.setTexture(it) }
                .exceptionally { this.onException(it) }

        return futureTexture != null
    }

    private fun setModelRenderable(modelRenderable: ModelRenderable): ModelRenderable {
        owner.get()!!.setModelRenderable(modelRenderable)
        return  modelRenderable
    }

    private fun setViewRenderable(viewRenderable: ViewRenderable): ViewRenderable {
        owner.get()?.setViewRenderable(viewRenderable)
        return viewRenderable
    }

    private fun setTexture(texture: Texture): Texture {
        owner.get()?.setTexture(texture)
        return texture
    }

    private fun onException(throwable: Throwable): Void? {
        owner.get()?.onLoadException(throwable)
        return null
    }

    interface ModelLoaderCallbacks {
        fun setModelRenderable(modelRenderable: ModelRenderable)
        fun setViewRenderable(viewRenderable: ViewRenderable)
        fun setTexture(texture: Texture)
        fun onLoadException(throwable: Throwable)
    }
}