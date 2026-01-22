import 'package:mapollege/core/model/image_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mapollege/core/utility/dialog_utility.dart';

class ImageComponent extends StatelessWidget {
  const ImageComponent({super.key, required this.images, required this.theme});

  final List<ImageModel> images;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Container(
        color: theme.colorScheme.surfaceContainerHighest,
        child: Icon(
          Icons.image_not_supported,
          size: 80,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      );
    }

    return _ShowImageComponent(images: images, theme: theme);
  }
}

class _ShowImageComponent extends StatefulWidget {
  const _ShowImageComponent({required this.images, required this.theme});

  final List<ImageModel> images;
  final ThemeData theme;

  @override
  State<_ShowImageComponent> createState() => _ImageComponentState();
}

class _ImageComponentState extends State<_ShowImageComponent> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ColoredBox(
      color: widget.theme.colorScheme.surfaceContainerHighest,
      child: Stack(
        children: [
          PageView.builder(
            allowImplicitScrolling: true,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => DialogUtility.showImage(widget.images[index].url),
                child: CachedNetworkImage(
                  imageUrl: widget.images[index].url,
                  fit: BoxFit.cover,
                  memCacheWidth: 1024,
                  filterQuality: FilterQuality.low,
                  placeholder: (context, url) => Container(
                    color: widget.theme.colorScheme.surfaceContainerHighest,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                  errorWidget: (context, error, stackTrace) => Container(
                    color: widget.theme.colorScheme.surfaceContainerHighest,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.broken_image,
                      size: 80,
                      color: widget.theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              );
            },
          ),
          if (widget.images.length > 1)
            Positioned(
              bottom: 4,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.images.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          if (widget.images.length > 1)
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_currentPage + 1}/${widget.images.length}',
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
