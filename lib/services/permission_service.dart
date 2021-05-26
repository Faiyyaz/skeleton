import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<void> getPermission({
    required AppPermission appPermission,
    VoidCallback? onDecline,
    VoidCallback? onDenied,
    VoidCallback? onAccept,
  }) async {
    await _requestPermission(
      appPermission: appPermission,
      onDenied: onDenied,
      onAccept: onAccept,
      onDecline: onDecline,
    );
  }

  openPermissionSettings() {
    openAppSettings();
  }

  _requestPermission({
    required AppPermission appPermission,
    VoidCallback? onDecline,
    VoidCallback? onDenied,
    VoidCallback? onAccept,
  }) async {
    PermissionStatus permissionStatus;
    switch (appPermission) {
      case AppPermission.CAMERA:
        permissionStatus = await Permission.camera.request();
        break;
      case AppPermission.GALLERY:
        permissionStatus = Platform.isIOS
            ? await Permission.photos.request()
            : await Permission.storage.request();
        break;
      case AppPermission.LOCATION:
        permissionStatus = await Permission.location.request();
        break;
      default:
        return null;
    }
    switch (permissionStatus) {
      case PermissionStatus.granted:
        if (onAccept != null) {
          onAccept();
        }
        break;
      case PermissionStatus.denied:
        if (Platform.isAndroid) {
          if (onDecline != null) {
            onDecline();
          }
        } else {
          if (onDenied != null) {
            onDenied();
          }
        }
        break;
      case PermissionStatus.restricted:
        if (onDenied != null) {
          onDenied();
        }
        break;
      case PermissionStatus.permanentlyDenied:
        if (onDenied != null) {
          onDenied();
        }
        break;
      default:
    }
  }

  Future<bool> isPermissionAlreadyGranted({
    required AppPermission appPermission,
  }) async {
    PermissionStatus permissionStatus;
    switch (appPermission) {
      case AppPermission.CAMERA:
        permissionStatus = await Permission.camera.request();
        break;
      case AppPermission.GALLERY:
        permissionStatus = Platform.isIOS
            ? await Permission.photos.request()
            : await Permission.storage.request();
        break;
      case AppPermission.LOCATION:
        permissionStatus = await Permission.location.request();
        break;
      default:
        return false;
    }
    switch (permissionStatus) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.denied:
        return false;
      case PermissionStatus.restricted:
        return false;
      case PermissionStatus.permanentlyDenied:
        return false;
      default:
        return false;
    }
  }
}

enum AppPermission {
  CAMERA,
  GALLERY,
  LOCATION,
}
