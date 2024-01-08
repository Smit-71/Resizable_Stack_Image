```dart
class ResizeImage extends StatelessWidget {
    const ResizeImage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: ResizableStackImage(
                child: Image.file(
                    _image!,
                    fit: BoxFit.contain,
                ),
            ),
        );
    }
}
