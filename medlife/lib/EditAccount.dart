import 'package:flutter/material.dart';

class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03142B),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/Logo.png', height: 100, width: 100),
                Text(
                  "Edit Account",
                  style: TextStyle(
                    color: Color(0xFF70D6FF),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(height: 32),
                _buildInputField("Enter your email", Icons.email, false, controller: _emailController),
                SizedBox(height: 16),
                _buildInputField("Enter your password", Icons.lock, true, controller: _passwordController),
                SizedBox(height: 16),
                _buildInputField("Enter your new password", Icons.lock, true, controller: _newPasswordController),
                SizedBox(height: 16),
                _buildInputField("Confirm your password", Icons.lock, true, controller: _confirmPasswordController, isConfirm: true),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF70D6FF),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text("Create Account"),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hintText, IconData icon, bool isPassword, {bool isConfirm = false, TextEditingController? controller}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? (isConfirm ? _obscureConfirmPassword : _obscurePassword) : false,
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText cannot be empty';
        }
        if (isConfirm && value != _newPasswordController.text) {
          return 'Passwords do not match';
        }
        if (!isConfirm && isPassword && value.length < 6) {
          return 'Password should be at least 6 characters';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Color(0xFF1A2C46),
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isConfirm
                      ? (_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility)
                      : (_obscurePassword ? Icons.visibility_off : Icons.visibility),
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    if (isConfirm) {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    } else {
                      _obscurePassword = !_obscurePassword;
                    }
                  });
                },
              )
            : null,
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // Process data (e.g., save to server, navigate to another screen)
      // For now, let's just show a success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account updated successfully')));
    }
  }
}
