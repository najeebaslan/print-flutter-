import 'package:flutter/material.dart';
import 'package:print_flutter/printable_data.dart';

Color primary = const Color(0xFF0051FF);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: primary,
              centerTitle: true,
              leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: const Text(
                'تفاصيل الفاتورة -الاصناف',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.deepOrange.withOpacity(0.1),
                  child: Stack(
                    children: const [
                      Icon(
                        Icons.assignment_outlined,
                        color: Colors.deepOrange,
                        size: 100,
                      ),
                      Positioned(
                          bottom: 10,
                          child: Icon(
                            Icons.trending_up,
                            color: Colors.green,
                            size: 60,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'تقرير فاتورة الصادرات',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    buildColumn(
                        key: "رقم الفاتورة", value: '22281', size: size),
                    const SizedBox(
                      width: 20,
                    ),
                    buildColumn(
                        key: "تاريخ الفاتورة", value: '2022-11-30', size: size),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                    height: 1.0,
                    thickness: 0.5,
                    color: Colors.grey.withAlpha(150)),
                const SizedBox(
                  height: 10,
                ),
                buildRowReports(
                  icons: Icons.phone,
                  subTitle: '  +967773228315  ',
                  title: 'رقم الهاتف',
                ),
                buildRowReports(
                  icons: Icons.category,
                  subTitle: 'سامسونج',
                  title: 'اسم الصنف',
                ),
                buildRowReports(
                  icons: Icons.monetization_on,
                  subTitle: '2000 ريال',
                  title: 'سعر الوحدة',
                ),
                buildRowReports(
                  icons: Icons.list_alt,
                  subTitle: '2',
                  title: 'الكمية',
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: size.width / 1.2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: primary,
                      primary: primary,
                      minimumSize: const Size(double.infinity, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () => PrenterData.generate(),
                    child: const Text(
                      "حفظ التقرير",
                      style: TextStyle(color: Colors.white, fontSize: 20.00),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget buildRowReports({
    required String title,
    required String subTitle,
    Widget? child,
    required IconData icons,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: primary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                icons,
                color: primary,
                size: 30,
              )),
          const SizedBox(
            width: 10,
          ),
          Text(
            '$title:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(
            width: 4,
          ),
          child ??
              Text(
                subTitle,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
        ],
      ),
    );
  }

  Widget buildColumn({
    required String key,
    required String value,
    required Size size,
  }) {
    return Expanded(
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              key,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              color: Colors.grey.withOpacity(0.3),
              height: 2,
              width: size.width / 3,
            )
          ],
        ),
      ),
    );
  }
}
