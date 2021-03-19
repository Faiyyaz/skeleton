import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<void> getPermission({
    @required Permission permission,
    Function onDecline,
    Function onDenied,
    Function onAccept,
  }) async {
    await _requestPermission(
      permission: permission,
      onDenied: onDenied,
      onAccept: onAccept,
      onDecline: onDecline,
    );
  }

  openPermissionSettings() {
    openAppSettings();
  }

  _requestPermission({
    @required Permission permission,
    Function onDecline,
    Function onDenied,
    Function onAccept,
  }) async {
    PermissionStatus permissionStatus = await permission.request();
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
    @required Permission permission,
  }) async {
    PermissionStatus permissionStatus = await permission.status;
    switch (permissionStatus) {
      case PermissionStatus.granted:
        return true;
        break;
      case PermissionStatus.denied:
        return false;
        break;
      case PermissionStatus.restricted:
        return false;
        break;
      case PermissionStatus.permanentlyDenied:
        return false;
        break;
      default:
        return false;
    }
  }
}
