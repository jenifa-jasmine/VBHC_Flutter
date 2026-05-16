// =============================================================
//  custom_dropdown_picker.dart
//  Drop this file into your project and import it anywhere.
//  Supports:
//    • Single select (inline overlay)
//    • Multi select (inline overlay)
//    • Searchable / filterable
//    • Icons & subtitles per item
//    • Grouped items (section headers)
//    • Async / future items (with loading state)
//    • Bottom sheet mode (mobile-friendly)
//    • Disabled state
//    • Custom label builder
//    • Error state
//    • Clear button
// =============================================================

import 'package:flutter/material.dart';

// ──────────────────────────────────────────────────────────────
// MODEL
// ──────────────────────────────────────────────────────────────

class DropdownItem<T> {
  final T value;
  final String label;
  final String? subtitle;
  final IconData? icon;
  final Widget? leading;
  final bool isDisabled;
  final String? group; // used for grouped mode

  const DropdownItem({
    required this.value,
    required this.label,
    this.subtitle,
    this.icon,
    this.leading,
    this.isDisabled = false,
    this.group,
  });
}

// ──────────────────────────────────────────────────────────────
// ENUM: picker display mode
// ──────────────────────────────────────────────────────────────

enum DropdownMode {
  overlay,    // floating overlay (default)
  bottomSheet // modal bottom sheet
}

// ──────────────────────────────────────────────────────────────
// THEME
// ──────────────────────────────────────────────────────────────

class DropdownThemeData {
  final Color primaryColor;
  final Color borderColor;
  final Color activeBorderColor;
  final Color backgroundColor;
  final Color overlayColor;
  final Color selectedItemColor;
  final Color hintColor;
  final double borderRadius;
  final double overlayBorderRadius;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? itemStyle;

  const DropdownThemeData({
    this.primaryColor       = const Color(0xFF6C63FF),
    this.borderColor        = const Color(0xFFDDD8FF),
    this.activeBorderColor  = const Color(0xFF6C63FF),
    this.backgroundColor    = Colors.white,
    this.overlayColor       = Colors.white,
    this.selectedItemColor  = const Color(0xFF6C63FF),
    this.hintColor          = const Color(0xFFAAAAAA),
    this.borderRadius       = 14,
    this.overlayBorderRadius = 14,
    this.labelStyle,
    this.hintStyle,
    this.itemStyle,
  });
}

// ──────────────────────────────────────────────────────────────
// SINGLE-SELECT DROPDOWN
// ──────────────────────────────────────────────────────────────

class CustomDropdownPicker<T> extends StatefulWidget {
  final String hint;
  final String? label;
  final T? value;
  final List<DropdownItem<T>> items;
  final ValueChanged<T?> onChanged;
  final Widget? prefixIcon;
  final bool searchable;
  final bool clearable;
  final bool disabled;
  final String? errorText;
  final DropdownMode mode;
  final DropdownThemeData theme;
  final String? searchHint;
  final double? maxOverlayHeight;
  final Widget Function(DropdownItem<T>)? itemBuilder;

  const CustomDropdownPicker({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
    this.label,
    this.prefixIcon,
    this.searchable = false,
    this.clearable = false,
    this.disabled = false,
    this.errorText,
    this.mode = DropdownMode.overlay,
    this.theme = const DropdownThemeData(),
    this.searchHint = 'Search...',
    this.maxOverlayHeight = 260,
    this.itemBuilder,
  });

  @override
  State<CustomDropdownPicker<T>> createState() =>
      _CustomDropdownPickerState<T>();
}

class _CustomDropdownPickerState<T>
    extends State<CustomDropdownPicker<T>>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late AnimationController _animCtrl;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;
  final TextEditingController _searchCtrl = TextEditingController();
  List<DropdownItem<T>> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = widget.items;
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _scaleAnim = Tween<double>(begin: 0.95, end: 1.0).animate(
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _searchCtrl.addListener(_onSearch);
  }

  void _onSearch() {
    final q = _searchCtrl.text.toLowerCase();
    setState(() {
      _filtered = widget.items
          .where((i) => i.label.toLowerCase().contains(q))
          .toList();
    });
    _overlayEntry?.markNeedsBuild();
  }

  @override
  void dispose() {
    _closeOverlay();
    _animCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _toggle() {
    if (widget.disabled) return;
    if (widget.mode == DropdownMode.bottomSheet) {
      _openBottomSheet();
    } else {
      _isOpen ? _closeOverlay() : _openOverlay();
    }
  }

  // ── Overlay mode ──────────────────────────────

  void _openOverlay() {
    _filtered = widget.items;
    _searchCtrl.clear();
    _overlayEntry = _buildOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _animCtrl.forward(from: 0);
    setState(() => _isOpen = true);
  }

  void _closeOverlay() {
    _animCtrl.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
    setState(() => _isOpen = false);
  }

  OverlayEntry _buildOverlayEntry() {
    final box = context.findRenderObject() as RenderBox;
    final size = box.size;
    final theme = widget.theme;

    return OverlayEntry(
      builder: (ctx) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _closeOverlay,
          child: Stack(children: [
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 6),
              child: Material(
                color: Colors.transparent,
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: ScaleTransition(
                    scale: _scaleAnim,
                    alignment: Alignment.topCenter,
                    child: _OverlayPanel(
                      width: size.width,
                      maxHeight: widget.maxOverlayHeight ?? 260,
                      theme: theme,
                      searchable: widget.searchable,
                      searchCtrl: _searchCtrl,
                      searchHint: widget.searchHint ?? 'Search...',
                      items: _filtered,
                      selectedValue: widget.value,
                      itemBuilder: widget.itemBuilder,
                      onSelect: (val) {
                        widget.onChanged(val);
                        _closeOverlay();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }

  // ── Bottom sheet mode ─────────────────────────

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _BottomSheetPanel<T>(
        title: widget.hint,
        items: widget.items,
        selectedValue: widget.value,
        searchable: widget.searchable,
        searchHint: widget.searchHint ?? 'Search...',
        theme: widget.theme,
        itemBuilder: widget.itemBuilder,
        onSelect: (val) {
          widget.onChanged(val);
          Navigator.pop(context);
        },
      ),
    );
  }

  // ── Build ──────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final selected = widget.items.cast<DropdownItem<T>?>().firstWhere(
          (i) => i?.value == widget.value,
          orElse: () => null,
        );
    final hasError = widget.errorText != null;

    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Text(widget.label!,
                style: theme.labelStyle ??
                    const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D2B5F))),
            const SizedBox(height: 6),
          ],
          GestureDetector(
            onTap: _toggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: widget.disabled
                    ? const Color(0xFFF5F5F5)
                    : theme.backgroundColor,
                borderRadius: BorderRadius.circular(theme.borderRadius),
                border: Border.all(
                  color: hasError
                      ? Colors.red
                      : _isOpen
                          ? theme.activeBorderColor
                          : theme.borderColor,
                  width: _isOpen ? 2 : 1.5,
                ),
                boxShadow: _isOpen && !hasError
                    ? [
                        BoxShadow(
                          color: theme.primaryColor.withOpacity(0.12),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  if (widget.prefixIcon != null) ...[
                    widget.prefixIcon!,
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Text(
                      selected?.label ?? widget.hint,
                      style: (selected != null
                              ? theme.itemStyle
                              : theme.hintStyle) ??
                          TextStyle(
                            fontSize: 14,
                            fontWeight: selected != null
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: selected != null
                                ? const Color(0xFF2D2B5F)
                                : theme.hintColor,
                          ),
                    ),
                  ),
                  if (widget.clearable && selected != null)
                    GestureDetector(
                      onTap: () {
                        widget.onChanged(null);
                        if (_isOpen) _closeOverlay();
                      },
                      child: Icon(Icons.close,
                          size: 16, color: theme.hintColor),
                    )
                  else
                    AnimatedRotation(
                      turns: _isOpen ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(Icons.keyboard_arrow_down_rounded,
                          color: theme.primaryColor),
                    ),
                ],
              ),
            ),
          ),
          if (hasError) ...[
            const SizedBox(height: 4),
            Text(widget.errorText!,
                style: const TextStyle(fontSize: 11, color: Colors.red)),
          ],
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// MULTI-SELECT DROPDOWN
// ──────────────────────────────────────────────────────────────

class MultiSelectDropdownPicker<T> extends StatefulWidget {
  final String hint;
  final String? label;
  final List<T> values;
  final List<DropdownItem<T>> items;
  final ValueChanged<List<T>> onChanged;
  final Widget? prefixIcon;
  final bool searchable;
  final bool clearable;
  final bool disabled;
  final String? errorText;
  final DropdownMode mode;
  final DropdownThemeData theme;
  final String? searchHint;
  final double? maxOverlayHeight;
  final int? maxSelections;
  final String Function(List<DropdownItem<T>>)? selectedLabelBuilder;

  const MultiSelectDropdownPicker({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.values = const [],
    this.label,
    this.prefixIcon,
    this.searchable = false,
    this.clearable = false,
    this.disabled = false,
    this.errorText,
    this.mode = DropdownMode.overlay,
    this.theme = const DropdownThemeData(),
    this.searchHint = 'Search...',
    this.maxOverlayHeight = 300,
    this.maxSelections,
    this.selectedLabelBuilder,
  });

  @override
  State<MultiSelectDropdownPicker<T>> createState() =>
      _MultiSelectDropdownPickerState<T>();
}

class _MultiSelectDropdownPickerState<T>
    extends State<MultiSelectDropdownPicker<T>>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late AnimationController _animCtrl;
  late Animation<double> _scaleAnim, _fadeAnim;
  final TextEditingController _searchCtrl = TextEditingController();
  List<DropdownItem<T>> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = widget.items;
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _scaleAnim = Tween<double>(begin: 0.95, end: 1.0).animate(
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _searchCtrl.addListener(_onSearch);
  }

  void _onSearch() {
    final q = _searchCtrl.text.toLowerCase();
    setState(() {
      _filtered =
          widget.items.where((i) => i.label.toLowerCase().contains(q)).toList();
    });
    _overlayEntry?.markNeedsBuild();
  }

  @override
  void dispose() {
    _closeOverlay();
    _animCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _toggle() {
    if (widget.disabled) return;
    if (widget.mode == DropdownMode.bottomSheet) {
      _openBottomSheet();
    } else {
      _isOpen ? _closeOverlay() : _openOverlay();
    }
  }

  void _openOverlay() {
    _filtered = widget.items;
    _searchCtrl.clear();
    _overlayEntry = _buildOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _animCtrl.forward(from: 0);
    setState(() => _isOpen = true);
  }

  void _closeOverlay() {
    _animCtrl.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
    setState(() => _isOpen = false);
  }

  void _toggle_item(T val) {
    final list = List<T>.from(widget.values);
    if (list.contains(val)) {
      list.remove(val);
    } else {
      if (widget.maxSelections != null &&
          list.length >= widget.maxSelections!) {
        return;
      }
      list.add(val);
    }
    widget.onChanged(list);
    _overlayEntry?.markNeedsBuild();
    setState(() {});
  }

  OverlayEntry _buildOverlayEntry() {
    final box = context.findRenderObject() as RenderBox;
    final size = box.size;
    final theme = widget.theme;

    return OverlayEntry(
      builder: (ctx) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _closeOverlay,
        child: Stack(children: [
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 6),
            child: Material(
              color: Colors.transparent,
              child: FadeTransition(
                opacity: _fadeAnim,
                child: ScaleTransition(
                  scale: _scaleAnim,
                  alignment: Alignment.topCenter,
                  child: _MultiOverlayPanel<T>(
                    width: size.width,
                    maxHeight: widget.maxOverlayHeight ?? 300,
                    theme: theme,
                    searchable: widget.searchable,
                    searchCtrl: _searchCtrl,
                    searchHint: widget.searchHint ?? 'Search...',
                    items: _filtered,
                    selectedValues: widget.values,
                    maxSelections: widget.maxSelections,
                    onToggle: _toggle_item,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _MultiBottomSheetPanel<T>(
        title: widget.hint,
        items: widget.items,
        selectedValues: widget.values,
        searchable: widget.searchable,
        searchHint: widget.searchHint ?? 'Search...',
        theme: widget.theme,
        maxSelections: widget.maxSelections,
        onChanged: (list) {
          widget.onChanged(list);
          Navigator.pop(context);
        },
      ),
    );
  }

  String get _displayLabel {
    final selected =
        widget.items.where((i) => widget.values.contains(i.value)).toList();
    if (selected.isEmpty) return widget.hint;
    if (widget.selectedLabelBuilder != null) {
      return widget.selectedLabelBuilder!(selected);
    }
    if (selected.length == 1) return selected.first.label;
    return '${selected.first.label} +${selected.length - 1} more';
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final hasSelection = widget.values.isNotEmpty;
    final hasError = widget.errorText != null;

    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Text(widget.label!,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D2B5F))),
            const SizedBox(height: 6),
          ],
          GestureDetector(
            onTap: _toggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: widget.disabled
                    ? const Color(0xFFF5F5F5)
                    : theme.backgroundColor,
                borderRadius: BorderRadius.circular(theme.borderRadius),
                border: Border.all(
                  color: hasError
                      ? Colors.red
                      : _isOpen
                          ? theme.activeBorderColor
                          : theme.borderColor,
                  width: _isOpen ? 2 : 1.5,
                ),
                boxShadow: _isOpen && !hasError
                    ? [
                        BoxShadow(
                          color: theme.primaryColor.withOpacity(0.12),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  if (widget.prefixIcon != null) ...[
                    widget.prefixIcon!,
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: hasSelection
                        ? Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: widget.items
                                .where((i) => widget.values.contains(i.value))
                                .take(3)
                                .map((i) => _Chip(
                                      label: i.label,
                                      color: theme.primaryColor,
                                      onRemove: () => _toggle_item(i.value),
                                    ))
                                .toList(),
                          )
                        : Text(widget.hint,
                            style: TextStyle(
                                fontSize: 14, color: theme.hintColor)),
                  ),
                  const SizedBox(width: 6),
                  if (widget.clearable && hasSelection)
                    GestureDetector(
                      onTap: () {
                        widget.onChanged([]);
                        if (_isOpen) _closeOverlay();
                      },
                      child: Icon(Icons.close,
                          size: 16, color: theme.hintColor),
                    )
                  else
                    AnimatedRotation(
                      turns: _isOpen ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(Icons.keyboard_arrow_down_rounded,
                          color: theme.primaryColor),
                    ),
                ],
              ),
            ),
          ),
          if (hasError) ...[
            const SizedBox(height: 4),
            Text(widget.errorText!,
                style: const TextStyle(fontSize: 11, color: Colors.red)),
          ],
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// GROUPED DROPDOWN  (items have a `group` property)
// ──────────────────────────────────────────────────────────────

class GroupedDropdownPicker<T> extends StatefulWidget {
  final String hint;
  final String? label;
  final T? value;
  final List<DropdownItem<T>> items;
  final ValueChanged<T?> onChanged;
  final Widget? prefixIcon;
  final bool searchable;
  final bool clearable;
  final bool disabled;
  final DropdownMode mode;
  final DropdownThemeData theme;
  final double? maxOverlayHeight;

  const GroupedDropdownPicker({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
    this.label,
    this.prefixIcon,
    this.searchable = false,
    this.clearable = false,
    this.disabled = false,
    this.mode = DropdownMode.overlay,
    this.theme = const DropdownThemeData(),
    this.maxOverlayHeight = 300,
  });

  @override
  State<GroupedDropdownPicker<T>> createState() =>
      _GroupedDropdownPickerState<T>();
}

class _GroupedDropdownPickerState<T>
    extends State<GroupedDropdownPicker<T>>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late AnimationController _animCtrl;
  late Animation<double> _scaleAnim, _fadeAnim;
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _scaleAnim = Tween<double>(begin: 0.95, end: 1.0).animate(
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _closeOverlay();
    _animCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  Map<String, List<DropdownItem<T>>> get _grouped {
    final q = _searchCtrl.text.toLowerCase();
    final filtered = widget.items
        .where((i) => i.label.toLowerCase().contains(q))
        .toList();
    final Map<String, List<DropdownItem<T>>> map = {};
    for (final item in filtered) {
      final g = item.group ?? 'Other';
      map.putIfAbsent(g, () => []).add(item);
    }
    return map;
  }

  void _toggle() {
    if (widget.disabled) return;
    if (widget.mode == DropdownMode.bottomSheet) {
      _openBottomSheet();
    } else {
      _isOpen ? _closeOverlay() : _openOverlay();
    }
  }

  void _openOverlay() {
    _searchCtrl.clear();
    _overlayEntry = _buildOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _animCtrl.forward(from: 0);
    setState(() => _isOpen = true);
  }

  void _closeOverlay() {
    _animCtrl.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
    setState(() => _isOpen = false);
  }

  OverlayEntry _buildOverlayEntry() {
    final box = context.findRenderObject() as RenderBox;
    final size = box.size;
    final theme = widget.theme;

    return OverlayEntry(builder: (ctx) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _closeOverlay,
        child: Stack(children: [
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 6),
            child: Material(
              color: Colors.transparent,
              child: FadeTransition(
                opacity: _fadeAnim,
                child: ScaleTransition(
                  scale: _scaleAnim,
                  alignment: Alignment.topCenter,
                  child: StatefulBuilder(builder: (_, setInner) {
                    final grouped = _grouped;
                    return Container(
                      width: size.width,
                      constraints: BoxConstraints(
                          maxHeight: widget.maxOverlayHeight ?? 300),
                      decoration: BoxDecoration(
                        color: theme.overlayColor,
                        borderRadius: BorderRadius.circular(
                            theme.overlayBorderRadius),
                        boxShadow: [
                          BoxShadow(
                              color: theme.primaryColor.withOpacity(0.12),
                              blurRadius: 20,
                              offset: const Offset(0, 8)),
                          BoxShadow(
                              color: Colors.black.withOpacity(0.07),
                              blurRadius: 8,
                              offset: const Offset(0, 2)),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            theme.overlayBorderRadius),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.searchable)
                              _SearchBar(
                                  ctrl: _searchCtrl,
                                  hint: 'Search...',
                                  color: theme.primaryColor,
                                  onChanged: (_) {
                                    setInner(() {});
                                    _overlayEntry?.markNeedsBuild();
                                  }),
                            Flexible(
                              child: ListView(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                shrinkWrap: true,
                                children: [
                                  for (final entry in grouped.entries) ...[
                                    _GroupHeader(label: entry.key,
                                        color: theme.primaryColor),
                                    for (final item in entry.value)
                                      _DropdownTile<T>(
                                        item: item,
                                        selected: item.value == widget.value,
                                        theme: theme,
                                        onTap: item.isDisabled
                                            ? null
                                            : () {
                                                widget.onChanged(item.value);
                                                _closeOverlay();
                                              },
                                      ),
                                  ]
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ]),
      );
    });
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        final grouped = _grouped;
        return _BaseBottomSheet(
          title: widget.hint,
          theme: widget.theme,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 24),
            shrinkWrap: true,
            children: [
              for (final entry in grouped.entries) ...[
                _GroupHeader(
                    label: entry.key, color: widget.theme.primaryColor),
                for (final item in entry.value)
                  _DropdownTile<T>(
                    item: item,
                    selected: item.value == widget.value,
                    theme: widget.theme,
                    onTap: item.isDisabled
                        ? null
                        : () {
                            widget.onChanged(item.value);
                            Navigator.pop(context);
                          },
                  ),
              ]
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final selected = widget.items.cast<DropdownItem<T>?>().firstWhere(
          (i) => i?.value == widget.value,
          orElse: () => null,
        );

    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Text(widget.label!,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D2B5F))),
            const SizedBox(height: 6),
          ],
          GestureDetector(
            onTap: _toggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: widget.disabled
                    ? const Color(0xFFF5F5F5)
                    : theme.backgroundColor,
                borderRadius: BorderRadius.circular(theme.borderRadius),
                border: Border.all(
                  color: _isOpen
                      ? theme.activeBorderColor
                      : theme.borderColor,
                  width: _isOpen ? 2 : 1.5,
                ),
                boxShadow: _isOpen
                    ? [
                        BoxShadow(
                            color: theme.primaryColor.withOpacity(0.12),
                            blurRadius: 12,
                            offset: const Offset(0, 4))
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  if (widget.prefixIcon != null) ...[
                    widget.prefixIcon!,
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Text(
                      selected?.label ?? widget.hint,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: selected != null
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: selected != null
                            ? const Color(0xFF2D2B5F)
                            : theme.hintColor,
                      ),
                    ),
                  ),
                  if (widget.clearable && selected != null)
                    GestureDetector(
                      onTap: () {
                        widget.onChanged(null);
                        if (_isOpen) _closeOverlay();
                      },
                      child:
                          Icon(Icons.close, size: 16, color: theme.hintColor),
                    )
                  else
                    AnimatedRotation(
                      turns: _isOpen ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(Icons.keyboard_arrow_down_rounded,
                          color: theme.primaryColor),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// ASYNC DROPDOWN  (items loaded from a Future)
// ──────────────────────────────────────────────────────────────

class AsyncDropdownPicker<T> extends StatefulWidget {
  final String hint;
  final String? label;
  final T? value;
  final Future<List<DropdownItem<T>>> Function() itemsFuture;
  final ValueChanged<T?> onChanged;
  final Widget? prefixIcon;
  final bool searchable;
  final bool clearable;
  final DropdownThemeData theme;
  final double? maxOverlayHeight;

  const AsyncDropdownPicker({
    super.key,
    required this.hint,
    required this.itemsFuture,
    required this.onChanged,
    this.value,
    this.label,
    this.prefixIcon,
    this.searchable = false,
    this.clearable = false,
    this.theme = const DropdownThemeData(),
    this.maxOverlayHeight = 260,
  });

  @override
  State<AsyncDropdownPicker<T>> createState() =>
      _AsyncDropdownPickerState<T>();
}

class _AsyncDropdownPickerState<T> extends State<AsyncDropdownPicker<T>> {
  List<DropdownItem<T>>? _items;
  bool _loading = false;
  String? _error;
  T? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.value;
    _loadItems();
  }

  Future<void> _loadItems() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final result = await widget.itemsFuture();
      if (mounted) setState(() => _items = result);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Text(widget.label!,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D2B5F))),
            const SizedBox(height: 6),
          ],
          _SkeletonDropdownBox(),
        ],
      );
    }
    if (_error != null) {
      return CustomDropdownPicker<T>(
        hint: widget.hint,
        label: widget.label,
        items: const [],
        onChanged: widget.onChanged,
        errorText: 'Failed to load options',
        theme: widget.theme,
      );
    }
    return CustomDropdownPicker<T>(
      hint: widget.hint,
      label: widget.label,
      value: _selected,
      items: _items ?? [],
      onChanged: (val) {
        setState(() => _selected = val);
        widget.onChanged(val);
      },
      prefixIcon: widget.prefixIcon,
      searchable: widget.searchable,
      clearable: widget.clearable,
      theme: widget.theme,
      maxOverlayHeight: widget.maxOverlayHeight,
    );
  }
}

// ──────────────────────────────────────────────────────────────
// PRIVATE SHARED WIDGETS
// ──────────────────────────────────────────────────────────────

class _OverlayPanel<T> extends StatefulWidget {
  final double width;
  final double maxHeight;
  final DropdownThemeData theme;
  final bool searchable;
  final TextEditingController searchCtrl;
  final String searchHint;
  final List<DropdownItem<T>> items;
  final T? selectedValue;
  final Widget Function(DropdownItem<T>)? itemBuilder;
  final ValueChanged<T> onSelect;

  const _OverlayPanel({
    required this.width,
    required this.maxHeight,
    required this.theme,
    required this.searchable,
    required this.searchCtrl,
    required this.searchHint,
    required this.items,
    required this.onSelect,
    this.selectedValue,
    this.itemBuilder,
  });

  @override
  State<_OverlayPanel<T>> createState() => _OverlayPanelState<T>();
}

class _OverlayPanelState<T> extends State<_OverlayPanel<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      constraints: BoxConstraints(maxHeight: widget.maxHeight),
      decoration: BoxDecoration(
        color: widget.theme.overlayColor,
        borderRadius: BorderRadius.circular(widget.theme.overlayBorderRadius),
        boxShadow: [
          BoxShadow(
              color: widget.theme.primaryColor.withOpacity(0.12),
              blurRadius: 20,
              offset: const Offset(0, 8)),
          BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(widget.theme.overlayBorderRadius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.searchable)
              _SearchBar(
                ctrl: widget.searchCtrl,
                hint: widget.searchHint,
                color: widget.theme.primaryColor,
                onChanged: (_) => setState(() {}),
              ),
            Flexible(
              child: widget.items.isEmpty
                  ? const _EmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      shrinkWrap: true,
                      itemCount: widget.items.length,
                      separatorBuilder: (_, __) => const Divider(
                          height: 1, indent: 16, endIndent: 16),
                      itemBuilder: (_, i) {
                        final item = widget.items[i];
                        return widget.itemBuilder != null
                            ? GestureDetector(
                                onTap: () => widget.onSelect(item.value),
                                child: widget.itemBuilder!(item))
                            : _DropdownTile<T>(
                                item: item,
                                selected: item.value == widget.selectedValue,
                                theme: widget.theme,
                                onTap: item.isDisabled
                                    ? null
                                    : () => widget.onSelect(item.value),
                              );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MultiOverlayPanel<T> extends StatefulWidget {
  final double width;
  final double maxHeight;
  final DropdownThemeData theme;
  final bool searchable;
  final TextEditingController searchCtrl;
  final String searchHint;
  final List<DropdownItem<T>> items;
  final List<T> selectedValues;
  final int? maxSelections;
  final ValueChanged<T> onToggle;

  const _MultiOverlayPanel({
    required this.width,
    required this.maxHeight,
    required this.theme,
    required this.searchable,
    required this.searchCtrl,
    required this.searchHint,
    required this.items,
    required this.selectedValues,
    required this.onToggle,
    this.maxSelections,
  });

  @override
  State<_MultiOverlayPanel<T>> createState() => _MultiOverlayPanelState<T>();
}

class _MultiOverlayPanelState<T> extends State<_MultiOverlayPanel<T>> {
  @override
  Widget build(BuildContext context) {
    final reachedMax = widget.maxSelections != null &&
        widget.selectedValues.length >= widget.maxSelections!;

    return Container(
      width: widget.width,
      constraints: BoxConstraints(maxHeight: widget.maxHeight),
      decoration: BoxDecoration(
        color: widget.theme.overlayColor,
        borderRadius:
            BorderRadius.circular(widget.theme.overlayBorderRadius),
        boxShadow: [
          BoxShadow(
              color: widget.theme.primaryColor.withOpacity(0.12),
              blurRadius: 20,
              offset: const Offset(0, 8)),
          BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(widget.theme.overlayBorderRadius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.searchable)
              _SearchBar(
                ctrl: widget.searchCtrl,
                hint: widget.searchHint,
                color: widget.theme.primaryColor,
                onChanged: (_) => setState(() {}),
              ),
            if (widget.maxSelections != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                child: Row(children: [
                  Icon(Icons.info_outline,
                      size: 13, color: widget.theme.primaryColor),
                  const SizedBox(width: 4),
                  Text(
                    'Select up to ${widget.maxSelections}  •  ${widget.selectedValues.length} chosen',
                    style: TextStyle(
                        fontSize: 11, color: widget.theme.primaryColor),
                  ),
                ]),
              ),
            Flexible(
              child: widget.items.isEmpty
                  ? const _EmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      shrinkWrap: true,
                      itemCount: widget.items.length,
                      separatorBuilder: (_, __) => const Divider(
                          height: 1, indent: 16, endIndent: 16),
                      itemBuilder: (_, i) {
                        final item = widget.items[i];
                        final checked =
                            widget.selectedValues.contains(item.value);
                        final greyOut =
                            reachedMax && !checked;
                        return InkWell(
                          onTap: (item.isDisabled || greyOut)
                              ? null
                              : () {
                                  widget.onToggle(item.value);
                                  setState(() {});
                                },
                          child: Opacity(
                            opacity: greyOut ? 0.4 : 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 11),
                              child: Row(
                                children: [
                                  AnimatedContainer(
                                    duration:
                                        const Duration(milliseconds: 150),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: checked
                                          ? widget.theme.primaryColor
                                          : Colors.transparent,
                                      borderRadius:
                                          BorderRadius.circular(5),
                                      border: Border.all(
                                        color: checked
                                            ? widget.theme.primaryColor
                                            : Colors.black26,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: checked
                                        ? const Icon(Icons.check,
                                            size: 13,
                                            color: Colors.white)
                                        : null,
                                  ),
                                  const SizedBox(width: 12),
                                  if (item.icon != null) ...[
                                    Icon(item.icon,
                                        size: 17,
                                        color: checked
                                            ? widget.theme.primaryColor
                                            : Colors.black45),
                                    const SizedBox(width: 8),
                                  ],
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(item.label,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: checked
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                                color: checked
                                                    ? widget.theme
                                                        .primaryColor
                                                    : const Color(
                                                        0xFF2D2B5F))),
                                        if (item.subtitle != null)
                                          Text(item.subtitle!,
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.black45)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DropdownTile<T> extends StatelessWidget {
  final DropdownItem<T> item;
  final bool selected;
  final DropdownThemeData theme;
  final VoidCallback? onTap;

  const _DropdownTile({
    required this.item,
    required this.selected,
    required this.theme,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Opacity(
        opacity: item.isDisabled ? 0.4 : 1,
        child: Container(
          color: selected
              ? theme.primaryColor.withOpacity(0.07)
              : Colors.transparent,
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          child: Row(
            children: [
              if (item.leading != null) ...[
                item.leading!,
                const SizedBox(width: 10),
              ] else if (item.icon != null) ...[
                Icon(item.icon,
                    size: 18,
                    color:
                        selected ? theme.primaryColor : Colors.black38),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: selected
                            ? theme.primaryColor
                            : const Color(0xFF2D2B5F),
                      ),
                    ),
                    if (item.subtitle != null)
                      Text(item.subtitle!,
                          style: const TextStyle(
                              fontSize: 11, color: Colors.black45)),
                  ],
                ),
              ),
              if (selected)
                Icon(Icons.check_rounded,
                    size: 16, color: theme.primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController ctrl;
  final String hint;
  final Color color;
  final ValueChanged<String> onChanged;

  const _SearchBar(
      {required this.ctrl,
      required this.hint,
      required this.color,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xFFF0EEFF), width: 1)),
      ),
      child: TextField(
        controller: ctrl,
        onChanged: onChanged,
        autofocus: true,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
          prefixIcon: Icon(Icons.search, size: 18, color: color),
          isDense: true,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        ),
      ),
    );
  }
}

class _GroupHeader extends StatelessWidget {
  final String label;
  final Color color;
  const _GroupHeader({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          color: color.withOpacity(0.6),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onRemove;

  const _Chip(
      {required this.label, required this.color, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: color)),
        const SizedBox(width: 4),
        GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, size: 12, color: color)),
      ]),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.search_off_rounded, color: Colors.black26, size: 28),
          SizedBox(height: 6),
          Text('No results found',
              style: TextStyle(fontSize: 13, color: Colors.black38)),
        ]),
      ),
    );
  }
}

class _SkeletonDropdownBox extends StatefulWidget {
  @override
  State<_SkeletonDropdownBox> createState() => _SkeletonDropdownBoxState();
}

class _SkeletonDropdownBoxState extends State<_SkeletonDropdownBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1100))
      ..repeat(reverse: true);
    _a = Tween<double>(begin: 0.4, end: 1.0)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _a,
      builder: (_, __) => Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: [
              Color.lerp(
                  const Color(0xFFE8E6FF), const Color(0xFFD0CCFF), _a.value)!,
              Color.lerp(
                  const Color(0xFFD0CCFF), const Color(0xFFF0EEFF), _a.value)!,
            ],
          ),
        ),
      ),
    );
  }
}

// ── Bottom sheet panels ────────────────────────────────────────

class _BaseBottomSheet extends StatelessWidget {
  final String title;
  final DropdownThemeData theme;
  final Widget child;

  const _BaseBottomSheet(
      {required this.title, required this.theme, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 12),
        Container(
          width: 36,
          height: 4,
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(4)),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D2B5F))),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close, size: 20, color: Colors.black45),
            ),
          ]),
        ),
        const SizedBox(height: 8),
        const Divider(height: 1),
        Flexible(
          child: SingleChildScrollView(child: child),
        ),
      ]),
    );
  }
}

class _BottomSheetPanel<T> extends StatefulWidget {
  final String title;
  final List<DropdownItem<T>> items;
  final T? selectedValue;
  final bool searchable;
  final String searchHint;
  final DropdownThemeData theme;
  final Widget Function(DropdownItem<T>)? itemBuilder;
  final ValueChanged<T> onSelect;

  const _BottomSheetPanel({
    required this.title,
    required this.items,
    required this.onSelect,
    required this.searchHint,
    required this.theme,
    this.selectedValue,
    this.searchable = false,
    this.itemBuilder,
  });

  @override
  State<_BottomSheetPanel<T>> createState() => _BottomSheetPanelState<T>();
}

class _BottomSheetPanelState<T> extends State<_BottomSheetPanel<T>> {
  final _ctrl = TextEditingController();
  List<DropdownItem<T>> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = widget.items;
    _ctrl.addListener(() {
      final q = _ctrl.text.toLowerCase();
      setState(() => _filtered = widget.items
          .where((i) => i.label.toLowerCase().contains(q))
          .toList());
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BaseBottomSheet(
      title: widget.title,
      theme: widget.theme,
      child: Column(children: [
        if (widget.searchable)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              controller: _ctrl,
              decoration: InputDecoration(
                hintText: widget.searchHint,
                prefixIcon: Icon(Icons.search,
                    color: widget.theme.primaryColor),
                filled: true,
                fillColor: const Color(0xFFF5F4FF),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                isDense: true,
              ),
            ),
          ),
        ..._filtered.map((item) => _DropdownTile<T>(
              item: item,
              selected: item.value == widget.selectedValue,
              theme: widget.theme,
              onTap: item.isDisabled
                  ? null
                  : () => widget.onSelect(item.value),
            )),
        if (_filtered.isEmpty) const _EmptyState(),
        const SizedBox(height: 16),
      ]),
    );
  }
}

class _MultiBottomSheetPanel<T> extends StatefulWidget {
  final String title;
  final List<DropdownItem<T>> items;
  final List<T> selectedValues;
  final bool searchable;
  final String searchHint;
  final DropdownThemeData theme;
  final int? maxSelections;
  final ValueChanged<List<T>> onChanged;

  const _MultiBottomSheetPanel({
    required this.title,
    required this.items,
    required this.selectedValues,
    required this.searchHint,
    required this.theme,
    required this.onChanged,
    this.searchable = false,
    this.maxSelections,
  });

  @override
  State<_MultiBottomSheetPanel<T>> createState() =>
      _MultiBottomSheetPanelState<T>();
}

class _MultiBottomSheetPanelState<T>
    extends State<_MultiBottomSheetPanel<T>> {
  final _ctrl = TextEditingController();
  List<DropdownItem<T>> _filtered = [];
  late List<T> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.selectedValues);
    _filtered = widget.items;
    _ctrl.addListener(() {
      final q = _ctrl.text.toLowerCase();
      setState(() => _filtered = widget.items
          .where((i) => i.label.toLowerCase().contains(q))
          .toList());
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle(T val) {
    setState(() {
      if (_selected.contains(val)) {
        _selected.remove(val);
      } else {
        if (widget.maxSelections != null &&
            _selected.length >= widget.maxSelections!) {
          return;
        }
        _selected.add(val);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _BaseBottomSheet(
      title: widget.title,
      theme: widget.theme,
      child: Column(children: [
        if (widget.searchable)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              controller: _ctrl,
              decoration: InputDecoration(
                hintText: widget.searchHint,
                prefixIcon: Icon(Icons.search,
                    color: widget.theme.primaryColor),
                filled: true,
                fillColor: const Color(0xFFF5F4FF),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                isDense: true,
              ),
            ),
          ),
        ..._filtered.map((item) {
          final checked = _selected.contains(item.value);
          return InkWell(
            onTap: () => _toggle(item.value),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 11),
              child: Row(children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: checked
                        ? widget.theme.primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: checked
                          ? widget.theme.primaryColor
                          : Colors.black26,
                      width: 1.5,
                    ),
                  ),
                  child: checked
                      ? const Icon(Icons.check,
                          size: 13, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 12),
                if (item.icon != null) ...[
                  Icon(item.icon, size: 18, color: Colors.black38),
                  const SizedBox(width: 8),
                ],
                Text(item.label,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: checked
                            ? FontWeight.w600
                            : FontWeight.normal)),
              ]),
            ),
          );
        }),
        if (_filtered.isEmpty) const _EmptyState(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => widget.onChanged(_selected),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.theme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Done  (${_selected.length} selected)',
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ]),
    );
  }
}

// ══════════════════════════════════════════════
//  DEMO PAGE  (remove in production)
// ══════════════════════════════════════════════

void main() => runApp(const _DemoApp());

class _DemoApp extends StatelessWidget {
  const _DemoApp();
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const _DemoPage(),
      );
}

class _DemoPage extends StatefulWidget {
  const _DemoPage();
  @override
  State<_DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<_DemoPage> {
  String? _fruit;
  String? _city;
  String? _role;
  String? _country;
  List<String> _skills = [];
  List<String> _tags = [];

  static const _fruitsItems = [
    DropdownItem(value: 'apple',  label: 'Apple',  icon: Icons.apple,           subtitle: 'Sweet & crisp'),
    DropdownItem(value: 'banana', label: 'Banana', icon: Icons.local_grocery_store, subtitle: 'Rich in potassium'),
    DropdownItem(value: 'cherry', label: 'Cherry', icon: Icons.favorite,         subtitle: 'Deep red antioxidant'),
    DropdownItem(value: 'mango',  label: 'Mango',  icon: Icons.wb_sunny_outlined,subtitle: 'King of fruits'),
    DropdownItem(value: 'grape',  label: 'Grape',  icon: Icons.bubble_chart,     subtitle: 'Perfect for juice'),
  ];

  static const _cityItems = [
    DropdownItem(value: 'chennai',   label: 'Chennai'),
    DropdownItem(value: 'mumbai',    label: 'Mumbai'),
    DropdownItem(value: 'delhi',     label: 'Delhi'),
    DropdownItem(value: 'bengaluru', label: 'Bengaluru'),
    DropdownItem(value: 'hyderabad', label: 'Hyderabad'),
    DropdownItem(value: 'pune',      label: 'Pune'),
    DropdownItem(value: 'kolkata',   label: 'Kolkata'),
  ];

  static const _groupedRoles = [
    DropdownItem(value: 'fe_dev', label: 'Frontend Developer', group: 'Engineering', icon: Icons.code),
    DropdownItem(value: 'be_dev', label: 'Backend Developer',  group: 'Engineering', icon: Icons.storage),
    DropdownItem(value: 'mobile', label: 'Mobile Developer',   group: 'Engineering', icon: Icons.phone_android),
    DropdownItem(value: 'ui',     label: 'UI Designer',        group: 'Design',      icon: Icons.palette_outlined),
    DropdownItem(value: 'ux',     label: 'UX Researcher',      group: 'Design',      icon: Icons.psychology_outlined),
    DropdownItem(value: 'pm',     label: 'Product Manager',    group: 'Management',  icon: Icons.analytics_outlined),
    DropdownItem(value: 'scrum',  label: 'Scrum Master',       group: 'Management',  icon: Icons.loop),
  ];

  static const _skillItems = [
    DropdownItem(value: 'flutter', label: 'Flutter', icon: Icons.flutter_dash),
    DropdownItem(value: 'dart',    label: 'Dart',    icon: Icons.code),
    DropdownItem(value: 'figma',   label: 'Figma',   icon: Icons.design_services),
    DropdownItem(value: 'react',   label: 'React',   icon: Icons.web),
    DropdownItem(value: 'node',    label: 'Node.js', icon: Icons.dns_outlined),
    DropdownItem(value: 'python',  label: 'Python',  icon: Icons.terminal),
  ];

  static const _tagItems = [
    DropdownItem(value: 'urgent',   label: 'Urgent'),
    DropdownItem(value: 'bug',      label: 'Bug'),
    DropdownItem(value: 'feature',  label: 'Feature'),
    DropdownItem(value: 'design',   label: 'Design'),
    DropdownItem(value: 'backend',  label: 'Backend'),
    DropdownItem(value: 'frontend', label: 'Frontend'),
  ];

  Future<List<DropdownItem<String>>> _fetchCountries() async {
    await Future.delayed(const Duration(seconds: 2));
    return const [
      DropdownItem(value: 'in',  label: 'India',          icon: Icons.flag),
      DropdownItem(value: 'us',  label: 'United States',  icon: Icons.flag),
      DropdownItem(value: 'uk',  label: 'United Kingdom', icon: Icons.flag),
      DropdownItem(value: 'au',  label: 'Australia',      icon: Icons.flag),
      DropdownItem(value: 'ca',  label: 'Canada',         icon: Icons.flag),
    ];
  }

  Widget _heading(String t) => Padding(
        padding: const EdgeInsets.only(top: 28, bottom: 10),
        child: Text(t,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: Color(0xFF6C63FF))),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        title: const Text('Custom Dropdown Picker',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        children: [
          // 1 ── Single, with icons & subtitle
          _heading('SINGLE SELECT  •  WITH ICON & SUBTITLE'),
          CustomDropdownPicker<String>(
            label: 'Favourite Fruit',
            hint: 'Choose a fruit',
            value: _fruit,
            items: _fruitsItems,
            onChanged: (v) => setState(() => _fruit = v),
            prefixIcon: const Icon(Icons.local_florist_outlined,
                color: Color(0xFF6C63FF)),
            clearable: true,
          ),

          // 2 ── Searchable
          _heading('SINGLE SELECT  •  SEARCHABLE'),
          CustomDropdownPicker<String>(
            label: 'City',
            hint: 'Search and pick a city',
            value: _city,
            items: _cityItems,
            onChanged: (v) => setState(() => _city = v),
            prefixIcon: const Icon(Icons.location_city_outlined,
                color: Color(0xFF6C63FF)),
            searchable: true,
            clearable: true,
          ),

          // 3 ── Grouped
          _heading('GROUPED  •  WITH SECTIONS'),
          GroupedDropdownPicker<String>(
            label: 'Job Role',
            hint: 'Select your role',
            value: _role,
            items: _groupedRoles,
            onChanged: (v) => setState(() => _role = v),
            prefixIcon: const Icon(Icons.work_outline_rounded,
                color: Color(0xFF6C63FF)),
            clearable: true,
            searchable: true,
          ),

          // 4 ── Async
          _heading('ASYNC  •  LOADED FROM FUTURE'),
          AsyncDropdownPicker<String>(
            label: 'Country (loads in 2s)',
            hint: 'Select country',
            value: _country,
            itemsFuture: _fetchCountries,
            onChanged: (v) => setState(() => _country = v),
            prefixIcon:
                const Icon(Icons.public, color: Color(0xFF6C63FF)),
            searchable: true,
            clearable: true,
          ),

          // 5 ── Multi select overlay
          _heading('MULTI SELECT  •  OVERLAY  (max 3)'),
          MultiSelectDropdownPicker<String>(
            label: 'Skills',
            hint: 'Pick your skills',
            values: _skills,
            items: _skillItems,
            onChanged: (v) => setState(() => _skills = v),
            prefixIcon:
                const Icon(Icons.build_outlined, color: Color(0xFF6C63FF)),
            maxSelections: 3,
            clearable: true,
          ),

          // 6 ── Multi bottom sheet
          _heading('MULTI SELECT  •  BOTTOM SHEET'),
          MultiSelectDropdownPicker<String>(
            label: 'Issue Tags',
            hint: 'Select tags',
            values: _tags,
            items: _tagItems,
            onChanged: (v) => setState(() => _tags = v),
            prefixIcon:
                const Icon(Icons.label_outline, color: Color(0xFF6C63FF)),
            mode: DropdownMode.bottomSheet,
            clearable: true,
          ),

          // 7 ── Bottom sheet single
          _heading('SINGLE SELECT  •  BOTTOM SHEET  •  SEARCHABLE'),
          CustomDropdownPicker<String>(
            label: 'City (bottom sheet)',
            hint: 'Tap to open sheet',
            value: _city,
            items: _cityItems,
            onChanged: (v) => setState(() => _city = v),
            mode: DropdownMode.bottomSheet,
            searchable: true,
            clearable: true,
            prefixIcon:
                const Icon(Icons.map_outlined, color: Color(0xFF6C63FF)),
          ),

          // 8 ── Disabled
          _heading('DISABLED STATE'),
          const CustomDropdownPicker<String>(
            hint: 'This picker is disabled',
            label: 'Disabled Picker',
            items: _cityItems,
            onChanged: _noOp,
            disabled: true,
            prefixIcon:
                Icon(Icons.lock_outline, color: Colors.black38),
          ),

          // 9 ── Error state
          _heading('ERROR STATE'),
          CustomDropdownPicker<String>(
            hint: 'Choose an option',
            label: 'With validation error',
            items: _cityItems,
            value: null,
            onChanged: (v) {},
            errorText: 'This field is required',
            prefixIcon:
                const Icon(Icons.error_outline, color: Colors.red),
          ),
        ],
      ),
    );
  }

  static void _noOp(String? _) {}
}