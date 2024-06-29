import 'package:flutter_test/flutter_test.dart';
import 'package:mottu_marvel/app/core/helpers/image_helper.dart';

void main() {
  group('ImageHelper.formatImagePath', () {
    test('should return formatted path with extension', () {
      var path = 'path/to/image';
      var extension = 'jpg';
      var expectedResult = 'path/to/image.jpg';

      var result = ImageHelper.formatImagePath(path, extension);

      expect(result, expectedResult);
    });

    test('should handle empty path or extension gracefully', () {
      var emptyPathResult = ImageHelper.formatImagePath('', 'png');
      var emptyExtensionResult =
          ImageHelper.formatImagePath('path/to/image', '');

      expect(emptyPathResult, '.png');
      expect(emptyExtensionResult, 'path/to/image.');
    });
  });
}
