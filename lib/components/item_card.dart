import 'package:breshop/data/models/item.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(item.imagePath,
                      alignment: Alignment.center, fit: BoxFit.cover),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: Theme.of(context).textTheme.bodySmall),
                  Text(item.condition,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: Theme.of(context).textTheme.bodyLarge),
                  if (item.description.isNotEmpty == true)
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 12, color: Colors.grey),
                    ),
                  Row(
                    children: [
                      Text(
                        '${item.price.roundToDouble()} R\$',
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
