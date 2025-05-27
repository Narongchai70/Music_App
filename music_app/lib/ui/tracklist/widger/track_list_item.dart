import 'package:flutter/material.dart';
import 'package:music_app/data/models/tracks_model.dart';

class TrackListItem extends StatelessWidget {
  final TrackModel track;
  final bool isPlaying;
  final VoidCallback onTap;
  final void Function(TrackModel track)? onMoreTap;

  const TrackListItem({
    super.key,
    required this.track,
    required this.isPlaying,
    required this.onTap,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: isPlaying ? Colors.blue[50] : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    track.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.music_note),
                  ),
                ),
                if (isPlaying)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.black54,
                      child: const Center(
                        child: Icon(
                          Icons.equalizer,
                          color: Colors.white70,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    track.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          isPlaying ? FontWeight.bold : FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    track.artistName,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => onMoreTap?.call(track),
            ),
          ],
        ),
      ),
    );
  }
}
