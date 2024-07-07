import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class ShoreBirdDemo extends StatefulWidget implements DemoWidget {
  const ShoreBirdDemo({super.key});
  static const String _title = 'ShoreBird Demo';
  static const String _description = 'https://console.shorebird.dev/';

  @override
  State<ShoreBirdDemo> createState() => _ShoreBirdDemoState();
  @override
  String get title => ShoreBirdDemo._title;

  @override
  String get description => ShoreBirdDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.question);
}

enum VersionStatus {
  initial,
  downloadInProgress,
  downloadCompleted,
  noNewVersion,
}

class _ShoreBirdDemoState extends State<ShoreBirdDemo> {
  final shorebirdCodePush = ShorebirdCodePush();
  VersionStatus status = VersionStatus.initial;
  String versionString = '';
  @override
  void initState() {
    super.initState();
    Future(
      () async {
        final packageInfo = await PackageInfo.fromPlatform();
        final version = packageInfo.version;
        final buildNumber = packageInfo.buildNumber;
        setState(() {
          versionString = '$version+$buildNumber';
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = TextButton(
      onPressed: () async {
        if (status == VersionStatus.downloadCompleted) {
          Restart.restartApp();
          return;
        }
        if (status == VersionStatus.downloadInProgress) {
          return;
        }
        final hasNewPatch =
            await shorebirdCodePush.isNewPatchAvailableForDownload();
        if (hasNewPatch) {
          setState(() {
            status = VersionStatus.downloadInProgress;
          });
          try {
            await shorebirdCodePush.downloadUpdateIfAvailable();
            final isNewPatchReadyToInstall =
                await shorebirdCodePush.isNewPatchReadyToInstall();
            if (isNewPatchReadyToInstall) {
              setState(() {
                status = VersionStatus.downloadCompleted;
              });
            }
          } catch (error, _) {
            print('Error: $error');
          }
        } else {
          setState(() {
            status = VersionStatus.noNewVersion;
          });
        }
      },
      child: Text(
        switch (status) {
          VersionStatus.initial => 'Check for new version',
          VersionStatus.downloadInProgress => 'Downloading new version',
          VersionStatus.downloadCompleted => 'Restart to apply new version',
          VersionStatus.noNewVersion => 'No new version available',
        },
        style: const TextStyle(fontSize: 30),
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text('${widget.title} $versionString')),
      body: Center(
        child: content,
      ),
    );
  }
}
