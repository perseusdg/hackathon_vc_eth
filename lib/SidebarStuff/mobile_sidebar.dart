import 'dart:math';

//edited package.

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TabChild {
  final String title;
  final Icon icon;
  final WidgetBuilder builder;

  TabChild({
    @required this.title,
    @required this.icon,
    this.builder,
  });
}

class MobileSidebar extends StatelessWidget {
  final WidgetBuilder titleBuilder;
  final WidgetBuilder accountBuilder;
  final Widget Function(BuildContext context, ValueChanged<String> onChanged)
      searchBarBuilder;
  final WidgetBuilder ctaBuilder;
  final WidgetBuilder menuButtonBuilder;
  final WidgetBuilder searchIconBuilder;
  final int currentIndex;
  final Widget Function(
          BuildContext context, List<String> titles, ValueChanged<int> onTap)
      drawerBuilder;
  final bool showSearchButton;
  final List<TabChild> tabs;
  final bool isSearching;
  final ValueChanged<bool> isSearchChanged;
  final ValueChanged<int> onTabChanged;
  final ValueChanged<String> searchChanged;
  final double tabWidth;

  MobileSidebar({
    Key key,
    @required this.titleBuilder,
    @required this.tabs,
    @required this.onTabChanged,
    @required this.currentIndex,
    this.ctaBuilder,
    this.tabWidth = 30.0,
    this.accountBuilder,
    this.searchBarBuilder,
    this.searchChanged,
    this.searchIconBuilder,
    this.menuButtonBuilder,
    this.drawerBuilder,
    this.showSearchButton = false,
    this.isSearching = false,
    this.isSearchChanged,
  }) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    const kMobileBreakpoint = 720.0;
    final theme = Theme.of(context) ??
        (Theme.of(context).brightness == Brightness.light
            ? ThemeData.light()
            : ThemeData.dark());
    return LayoutBuilder(
      builder: (context, dimens) {
        final _titles = tabs.map((t) => t.title).toList();
        final _iconsss = tabs.map((t) => t.icon).toList();
        final _showDrawer = dimens.maxWidth <= kMobileBreakpoint;
        return Scaffold(
          key: _scaffoldKey,
          drawer: _showDrawer
              ? drawerBuilder != null
                  ? drawerBuilder(context, _titles, onTabChanged)
                  : _buildDrawer(context, _titles, _iconsss)
              : null,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Material(
              color: theme.appBarTheme.color,
              elevation: theme.appBarTheme?.elevation ?? 4.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (isSearching) ...[
                    if (_showDrawer) ...[
                      _menuIconBuilder(context)
                    ] else ...[
                      Container(width: 8.0),
                      titleBuilder(context)
                    ],
                    Expanded(
                      child: _buildSearchBar(),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => isSearchChanged(false),
                    ),
                  ] else ...[
                    Row(
                      children: <Widget>[
                        if (_showDrawer) ...[_menuIconBuilder(context)],
                        if (!_showDrawer) Container(width: 8.0),
                        titleBuilder(context),
                      ],
                    ),
                    if (!_showDrawer) ...[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: LayoutBuilder(
                            builder: (context, subDimens) {
                              final _titleCountToRemove = (subDimens.maxWidth /
                                      (_titles.length * tabWidth))
                                  .ceil();
                              List<String> _subTitles =
                                  _titles.take(_titleCountToRemove).toList();
                              List<String> _extraTitles =
                                  _titles.skip(_subTitles.length).toList();
                              final _selected = _titles[currentIndex];
                              if (_subTitles.indexOf(_selected) == -1) {
                                _subTitles = [_selected];
                                _extraTitles = _titles
                                    .where((t) => t != _selected)
                                    .toList();
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  for (var tab in _subTitles) ...[
                                    _buildSubTab(_titles, tab, theme),
                                  ],
                                  if (_subTitles.length != _titles.length) ...[
                                    if (_extraTitles.length == 1) ...[
                                      _buildSubTab(
                                        _titles,
                                        _extraTitles.first,
                                        theme,
                                      ),
                                    ] else ...[
                                      Container(width: 10.0),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: kBarHeight),
                                            child: PopupMenuButton<String>(
                                              child: Row(
                                                children: <Widget>[
                                                  Text('More'),
                                                  Container(width: 4.0),
                                                  Icon(Icons.arrow_drop_down),
                                                ],
                                              ),
                                              onSelected: (val) {
                                                final _index =
                                                    _titles.indexOf(val);
                                                onTabChanged(_index);
                                              },
                                              itemBuilder: (context) =>
                                                  _extraTitles
                                                      .map(
                                                        (t) => PopupMenuItem(
                                                          value: t,
                                                          child: Text(t),
                                                        ),
                                                      )
                                                      .toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                  ],
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    ],
                    Row(
                      children: <Widget>[
                        if (showSearchButton) ...[
                          _searchBuilder(context, _showDrawer),
                        ],
                        if (ctaBuilder != null) ctaBuilder(context),
                        if (accountBuilder != null) accountBuilder(context),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          body: tabs[currentIndex].builder(context),
        );
      },
    );
  }

  Widget _buildSubTab(List<String> _titles, String tab, ThemeData theme) {
    return InkWell(
      onTap: () {
        final _index = _titles.indexOf(tab);
        onTabChanged(_index);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: AutoSizeText(
                  tab,
                  style: theme.textTheme.body2.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 50),
              height: kBarHeight,
              width: tabWidth * 2,
              color: tab == _titles[currentIndex]
                  ? theme.accentColor
                  : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  final kBarHeight = 3.0;

  Widget _menuIconBuilder(BuildContext context) {
    if (menuButtonBuilder != null) {
      return menuButtonBuilder(context);
    }
    return IconButton(
      icon: Icon(Icons.menu),
      onPressed: () => _scaffoldKey.currentState.openDrawer(),
    );
  }

  Widget _searchBuilder(BuildContext context, bool showDrawer) {
    if (showDrawer) {
      if (searchIconBuilder != null) {
        return searchIconBuilder(context);
      }
      return IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          if (isSearchChanged != null) {
            isSearchChanged(!isSearching);
          }
        },
      );
    }
    if (searchBarBuilder != null) {
      return searchBarBuilder(context, searchChanged);
    }
    const kSearchBarWidth = 225.0;

    return Container(
      width: kSearchBarWidth,
      child: _buildSearchBar(),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: isSearching ? 2.0 : 0.0,
        child: TextField(
          autofocus: isSearching,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            filled: true,
            hintText: "Search",
          ),
          onTap: isSearching
              ? null
              : () {
                  if (isSearchChanged != null) {
                    isSearchChanged(!isSearching);
                  }
                },
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context, List<String> _titles, List<Icon> _iconsss) {
    final _divider = Container(
      height: 0.5,
      color: Colors.grey[300],
    );
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  Container(width: 8.0),
                  titleBuilder(context),
                ],
              ),
              _divider,
              Row(
                children: <Widget>[
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _titles.length,
                      separatorBuilder: (context, index) {
                        return _divider;
                      },
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: _iconsss[index],
                          selected: index == currentIndex,
                          title: Text(_titles[index]),
                          onTap: () {
                            Navigator.of(context).maybePop();
                            onTabChanged(index);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              _divider,
              if (ctaBuilder != null) ...[
                ctaBuilder(context),
                _divider,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
