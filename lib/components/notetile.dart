import 'package:flutter/material.dart';
import 'package:minimalnote/components/notesettings.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;

  final String text;
  const NoteTile(
      {super.key,
      required this.text,
      this.onEditPressed,
      this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 10, right: 25, left: 25),
      child: ListTile(
          title: Text(text),
          trailing: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => showPopover(
                width: 100,
                height: 100,
                backgroundColor: Theme.of(context).colorScheme.background,
                context: context,
                bodyBuilder: (context) => NoteSettings(
                  onEditTap: onEditPressed,
                  onDeleteTap: onDeletePressed,
                ),
              ),
            ),
          )),
    );
  }
}
