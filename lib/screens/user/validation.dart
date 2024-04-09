class Validation {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email không được để trống';
    }
    // Kiểm tra định dạng email bằng regex hoặc các phương pháp khác
    if (!value.contains('@')) {
      return 'Email không hợp lệ';
    }
    return null; // Email hợp lệ
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu không được để trống';
    }
    // Kiểm tra điều kiện khác cho mật khẩu nếu cần
    return null; // Mật khẩu hợp lệ
  }
}
