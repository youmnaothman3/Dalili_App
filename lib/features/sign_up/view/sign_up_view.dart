import 'package:dalili_app/features/sign_up/contrller/sign_up_contrller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RegisterView extends StatelessWidget {
  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔵 الخلفية
          Positioned.fill(
            child: Image.asset(
              "assets/logo.jpg",
              fit: BoxFit.cover,
            ),
          ),

          // 🧾 الفورم
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 🔷 اللوجو
                    Image.asset("assets/images/logo.png", height: 80),

                    SizedBox(height: 10),

                    Text(
                      "دليل المعاملات الحكومية",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),

                    Text(
                      "منصة إلكترونية موحدة للمعاملات الحكومية",
                      style: TextStyle(color: Colors.grey),
                    ),

                    SizedBox(height: 20),

                    Text(
                      "إنشاء حساب جديد",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      "يرجى تعبئة البيانات لإنشاء حسابك",
                      style: TextStyle(color: Colors.grey),
                    ),

                    SizedBox(height: 20),

                    buildTextField(
                      controller.nameController,
                      "الاسم الكامل",
                      Icons.person,
                    ),

                    buildTextField(
                      controller.birthDateController,
                      "تاريخ الميلاد",
                      Icons.calendar_today,
                    ),

                    buildTextField(
                      controller.phoneController,
                      "رقم الهاتف",
                      Icons.phone,
                    ),

                    Obx(
                      () => buildPasswordField(
                        controller.passwordController,
                        "كلمة السر",
                        controller.isPasswordHidden.value,
                        controller.togglePassword,
                      ),
                    ),

                    Obx(
                      () => buildPasswordField(
                        controller.confirmPasswordController,
                        "إعادة كلمة السر",
                        controller.isConfirmPasswordHidden.value,
                        controller.toggleConfirmPassword,
                      ),
                    ),

                    SizedBox(height: 20),

                    // زر إنشاء حساب
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: controller.register,
                      child: Text("إنشاء الحساب"),
                    ),

                    SizedBox(height: 15),

                    Text("أو"),

                    SizedBox(height: 10),

                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text("لديك حساب؟ تسجيل الدخول"),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "جميع البيانات محمية وآمنة",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget buildPasswordField(
    TextEditingController controller,
    String hint,
    bool isHidden,
    VoidCallback toggle,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        obscureText: isHidden,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(isHidden ? Icons.visibility : Icons.visibility_off),
            onPressed: toggle,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
