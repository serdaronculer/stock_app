import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/pages/main_page.dart';
import 'package:stock_app/pages/stock_page.dart';

class ListPage extends ConsumerStatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListPageState();
}

class _ListPageState extends ConsumerState<ListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListItem(
          title: "Stok Listesi",
          icon: Icons.book,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StockPage())),
        ),
        ListItem(
          title: "Stok Tablosu",
          icon: Icons.book,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage())),
        ),
        ListItem(
          title: "Kategori Listesi",
          icon: Icons.category,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage())),
        ),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(title),
        trailing: Icon(icon),
      ),
    );
  }
}
