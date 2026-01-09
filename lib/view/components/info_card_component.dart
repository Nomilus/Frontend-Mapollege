import 'package:application_mapollege/core/model/image_model.dart';
import 'package:application_mapollege/core/model/section/member_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class InfoCardComponent extends StatelessWidget {
  const InfoCardComponent({
    super.key,
    required this.icon,
    required this.title,
    required this.children,
  });

  final IconData icon;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(icon, color: theme.colorScheme.primary),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}

class InfoSectionComponent extends StatelessWidget {
  const InfoSectionComponent({
    super.key,
    this.logo,
    required this.title,
    required this.members,
  });

  final ImageModel? logo;
  final String title;
  final List<Widget> members;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: logo != null
            ? CircleAvatar(
                radius: 20,
                backgroundImage: logo?.url != null
                    ? NetworkImage(logo?.url ?? '')
                    : null,
              )
            : null,
        title: Text(title, style: theme.textTheme.titleMedium),
        children: [
          if (members.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'สมาชิก (${members.length})',
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  ...members,
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class InfoRowComponent extends StatelessWidget {
  const InfoRowComponent({
    super.key,
    this.icon,
    this.iconColor,
    required this.label,
    this.labelColor,
    this.value,
    this.valueColor,
    this.content,
  });

  final IconData? icon;
  final Color? iconColor;
  final String label;
  final Color? labelColor;
  final String? value;
  final Color? valueColor;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Icon(icon, size: 20, color: iconColor ?? Colors.grey[600]),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: labelColor ?? Colors.grey[600],
                ),
              ),
              Visibility(
                visible: value != null,
                child: SelectableText(
                  value ?? '-',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: valueColor,
                  ),
                ),
              ),
              Visibility(
                visible: content != null,
                child: content ?? const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InfoMemberComponent extends StatelessWidget {
  const InfoMemberComponent({super.key, required this.member});

  final MemberModel member;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ListTile(
      dense: true,
      leading: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: member.image?.url ?? '',
            fit: BoxFit.cover,
            memCacheWidth: 1024,
            filterQuality: FilterQuality.low,
            alignment: Alignment.topCenter,
            errorWidget: (context, error, stackTrace) => Container(
              color: theme.colorScheme.surfaceContainerHighest,
              child: const Icon(Icons.person),
            ),
            placeholder: (context, url) => Container(
              color: theme.colorScheme.surfaceContainerHighest,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
          ),
        ),
      ),
      title: SelectableText(
        '${member.prefix} ${member.firstName} ${member.lastName}',
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Wrap(
        spacing: 2,
        children: member.positions
            .map((p) => _buildPositionBox(theme, p))
            .toList(),
      ),
    );
  }

  Widget _buildPositionBox(ThemeData theme, Position<Enum> position) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        position.name,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
