import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gym_bar/ui/shared/dimensions.dart';
import 'package:gym_bar/ui/shared/text_styles.dart';

class CustomCardItem {
  final context;

  CustomCardItem({@required this.context});

  Widget item({
    String statistics,
    @required String title,
    bool bigTitle = false,
    String assetImage,
    String networkImage,
    backGround = Colors.black,
    Function onPress,
    Function onTapUp,
    Function onTapDown,
    Function onTapCancel,
    topSpace,
    betweenSpace,
  }) {
    Dimensions _dimensions = Dimensions(context);
    return GestureDetector(
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        onTap: onPress,
        child: Container(
          width: _dimensions.widthPercent(80),
          height: _dimensions.widthPercent(80),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_dimensions.heightPercent(1))),
            elevation: 5,
            color: networkImage == null ? backGround : Colors.black,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              alignment: AlignmentDirectional.center,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Opacity(
                    opacity: 0.4,
                    child: FittedBox(
                        fit: BoxFit.fill,
                        child: networkImage == null || networkImage == "photo" || networkImage.length < 0
                            ? Image.asset(assetImage)
                            : CachedNetworkImage(
                          imageUrl: networkImage,
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                        ),),
                  ),
                ),
                if (statistics == null)
                  titleOnly(bigTitle: bigTitle, title: title)
                else
                  titleStatistics(
                      bigTitle: bigTitle,
                      title: title,
                      statistics: statistics,
                      topSpace: topSpace,
                      betweenSpace: betweenSpace)
              ],
            ),
          ),
        ));
  }

  titleStatistics({bool bigTitle, title, statistics, topSpace, betweenSpace}) {
    TextStyles _textStyles = TextStyles(context: context);

    return Column(
      children: <Widget>[
        topSpace != null ? topSpace : SizedBox(),
        Text(
          statistics,
          style: _textStyles.itemImageStatistics(),
        ),
        betweenSpace != null ? betweenSpace : SizedBox(),
        Text(
          title,
          style: bigTitle ? _textStyles.itemImageTitle() : _textStyles.itemImageTitleSmall(),
        ),
      ],
    );
  }

  titleOnly({bool bigTitle, title}) {
    TextStyles _textStyles = TextStyles(context: context);

    return Text(
      title,
      style: bigTitle ? _textStyles.itemImageTitle() : _textStyles.itemImageTitleSmall(),
    );
  }
}
