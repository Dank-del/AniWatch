// This function will be called when you long press on the blue box or the image
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

void showAnimeContextMenu(BuildContext context, Offset tapPosition,
    String animeName, String animeId, String animeImage, int anime_eps) async {
  final RenderObject? overlay = Overlay.of(context).context.findRenderObject();
  final db = Localstore.instance;
  final result = await showMenu(
      context: context,
      color: ThemeData.dark().dialogBackgroundColor,
      // Show the context menu at the tap location
      position: RelativeRect.fromRect(
          Rect.fromLTWH(tapPosition.dx, tapPosition.dy, 30, 30),
          Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
              overlay.paintBounds.size.height)),

      // set a list of choices for the context menu
      items: [
        const PopupMenuItem(
          value: 'favorites-add',
          child: Text('Add To Favorites'),
        ),
        const PopupMenuItem(
          value: 'watch-list-add',
          child: Text('Add to WatchList [WIP]'),
        ),
        // const PopupMenuItem(
        //   value: 'hide',
        //   child: Text('Hide'),
        // ),
      ]);

  // Implement the logic for each choice here
  switch (result) {
    case 'favorites-add':
      debugPrint('Add To Favorites');
      // var e = await store.record('favs').get(db);
      // debugPrint(e.toString());
      await db.collection('favs').doc(animeId).set({
        "anime_name": animeName,
        "anime_id": animeId,
        "anime_img": animeImage,
        "anime_total_eps": anime_eps
      });
      ShowToast(context, "Added $animeName to favorites");
      // var res = await db.collection('favs').get();
      // debugPrint(res.toString());
      break;
    case 'watch-list-add':
      debugPrint('Add to watch list');
      break;
    case 'hide':
      debugPrint('Hide');
      break;
  }
}

void ShowToast(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      content: Text(
        message,
        style: TextStyle(color: Theme.of(context).primaryColorLight),
      ),
      // action: SnackBarAction(
      //     label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
