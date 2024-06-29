import 'package:flutter_test/flutter_test.dart';
import 'package:mottu_marvel/app/core/helpers/crypto_helpers.dart';

void main() {
  group('CryptoHelpers', () {
    test('generateMd5 returns correct MD5 hash for given input', () {
      const String input = 'hello';
      const String expectedHash = '5d41402abc4b2a76b9719d911017c592';

      final result = CryptoHelpers.generateMd5(input);

      expect(result, expectedHash);
    });

    test('generateMd5 returns correct MD5 hash for empty string', () {
      const String input = '';
      const String expectedHash = 'd41d8cd98f00b204e9800998ecf8427e';

      final result = CryptoHelpers.generateMd5(input);

      expect(result, expectedHash);
    });

    test('generateMd5 returns correct MD5 hash for numeric string', () {
      const String input = '1234567890';
      const String expectedHash = 'e807f1fcf82d132f9bb018ca6738a19f';

      final result = CryptoHelpers.generateMd5(input);

      expect(result, expectedHash);
    });
  });
}
