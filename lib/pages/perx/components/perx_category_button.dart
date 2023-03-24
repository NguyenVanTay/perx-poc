import 'package:flutter/material.dart';

class PerxCategoryButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Function()? onTap;

  const PerxCategoryButton(
      {required this.title,
      required this.icon,
      required this.color,
      this.onTap,
      super.key});

  @override
  State<PerxCategoryButton> createState() => _PerxCategoryButtonState();
}

class _PerxCategoryButtonState extends State<PerxCategoryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: widget.color,
          width: 2,
        ),
      ),
      child: TextButton(
        onPressed: widget.onTap,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
            widget.color.withOpacity(0.1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: widget.color,
              size: 42,
            ),
            const SizedBox(height: 8),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.color,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
