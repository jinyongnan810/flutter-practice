import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:material_color_utilities/material_color_utilities.dart';

// ref: https://www.youtube.com/watch?v=7nrhTdS7dHg
class ThemeColorDemo extends StatefulWidget implements DemoWidget {
  const ThemeColorDemo({super.key});
  static const String _title = 'Theme Color Demo';
  static const String _description =
      'Get main color of the image and create a theme based on it.';

  @override
  State<ThemeColorDemo> createState() => _ThemeColorDemoState();
  @override
  String get title => ThemeColorDemo._title;

  @override
  String get description => ThemeColorDemo._description;

  @override
  Widget get icon => const FaIcon(FontAwesomeIcons.question);
}

class _ThemeColorDemoState extends State<ThemeColorDemo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultTheme = Theme.of(context);
    final defaultColorScheme = Theme.of(context).colorScheme;
    final content = Consumer(
      builder: (context, ref, child) {
        final uint8Image = ref.watch(imageProvider);
        final colorScheme =
            ref.watch(colorSchemeProvider(defaultColorScheme)).valueOrNull ??
                defaultColorScheme;
        final mainColor =
            ref.watch(mainColorProvider).valueOrNull ?? Colors.transparent;
        debugPrint(
          'defaultColorScheme: ${defaultColorScheme.primary}, colorScheme: ${colorScheme.primary}, mainColor: $mainColor',
        );

        return Theme(
          data: defaultTheme.copyWith(colorScheme: colorScheme),
          child: Center(
            child: Column(
              children: [
                if (uint8Image.asData?.value != null)
                  Image.memory(
                    uint8Image.asData!.value,
                    width: 300,
                    height: 400,
                  ),
                const SizedBox(height: 12),
                Text(
                  'This color is the main color of the image above.',
                  style: TextStyle(color: mainColor),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(imageProvider);
                  },
                  child: uint8Image.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Next Image'),
                ),
              ],
            ),
          ),
        );
      },
    );
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: content,
    );
  }
}

final imageProvider = FutureProvider.autoDispose<Uint8List>((ref) async {
  final response = await http.get(Uri.parse('https://picsum.photos/300/400'));
  return response.bodyBytes;
});
final colorSchemeProvider = FutureProvider.autoDispose
    .family<ColorScheme?, ColorScheme>((ref, defaultScheme) async {
  try {
    final futureImage = ref.watch(imageProvider);
    final uint8List = futureImage.valueOrNull;
    if (uint8List == null) {
      return null;
    }
    final image = img.JpegDecoder().decode(uint8List);
    if (image == null) {
      return null;
    }
    final mainColor = await getMainColor(image);
    debugPrint("mainColor: $mainColor");
    // final blended =
    //     Color(Blend.harmonize(mainColor.value, defaultScheme.primary.value));

    return ColorScheme.fromSeed(
      seedColor: mainColor,
      brightness: defaultScheme.brightness,
    );
  } catch (e) {
    debugPrint('error:$e');
    return null;
  }
});

final mainColorProvider = FutureProvider.autoDispose<Color?>((ref) async {
  try {
    final futureImage = ref.watch(imageProvider);
    final uint8List = futureImage.valueOrNull;
    if (uint8List == null) {
      return null;
    }
    final image = img.JpegDecoder().decode(uint8List);
    if (image == null) {
      return null;
    }
    return getMainColor(image);
  } catch (e) {
    debugPrint('error:$e');
    return null;
  }
});

Future<Color> getMainColor(img.Image image) async {
  final bytes = image.getBytes(order: img.ChannelOrder.rgb);
  final pixels = <int>[];
  for (var i = 0; i < bytes.length; i += 3) {
    pixels.add(
      img.rgbaToUint32(bytes[i], bytes[i + 1], bytes[i + 2], 255),
    );
  }
  final quantized = await QuantizerCelebi().quantize(pixels, 128);
  final ranked = Score.score(quantized.colorToCount);
  debugPrint('ranked: ${ranked.map((e) => Color(e))}');
  return Color(ranked.first);
}
