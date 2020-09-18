package com.fptu.swd391.cvideo_mobile

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.provider.Settings
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.core.app.ActivityCompat
import com.google.ar.core.Config
import com.google.ar.core.Session
import com.google.ar.sceneform.ux.ArFragment
import java.util.*

/** Implements ArFragment and configures the session for using the augmented faces feature. */
class FaceArFragment : ArFragment() {
    private val permissionList =
            arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.RECORD_AUDIO)

    override fun getSessionConfiguration(session: Session?): Config {
        val config = Config(session)
        config.augmentedFaceMode = Config.AugmentedFaceMode.MESH3D

        return config
    }

    override fun getSessionFeatures(): MutableSet<Session.Feature> {
        return EnumSet.of(Session.Feature.FRONT_CAMERA)
    }

    /**
     * Override to turn off planeDiscoveryController. Plane trackables are not supported with the
     * front camera.
     */
    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        val frameLayout = super.onCreateView(inflater, container, savedInstanceState) as FrameLayout

        planeDiscoveryController.apply {
            hide()
            setInstructionView(null)
        }

        return frameLayout
    }

    /**
     * This adds this permission [WRITER_EXTERNAL_STORAGE] and [RECORD_AUDIO] to the list
     * of permissions presented to the user for granting.
     */
    override fun getAdditionalPermissions(): Array<String> {
        val additionalPermissions = super.getAdditionalPermissions()

        return permissionList + additionalPermissions
    }

    fun hasWritePermission(): Boolean {
        return ActivityCompat.checkSelfPermission(
                this.requireActivity(), permissionList[0]
        ) == PackageManager.PERMISSION_GRANTED
    }

    fun hasRecordAudioPermission(): Boolean {
        return  ActivityCompat.checkSelfPermission(
                this.requireActivity(), permissionList[1]
        ) == PackageManager.PERMISSION_GRANTED
    }

    /** Launch Application Setting to grant permissions. */
    fun launchPermissionSettings() {
        val intent = Intent()
        intent.action = Settings.ACTION_APPLICATION_DETAILS_SETTINGS
        intent.data = Uri.fromParts("package", requireActivity().packageName, null)
        requireActivity().startActivity(intent)
    }
}