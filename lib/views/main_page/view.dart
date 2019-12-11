import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipe/utils/adapt.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MainPageState state, Dispatch dispatch, ViewService viewService) {
  Adapt.initContext(viewService.context);
  Widget _buildRecipeCell(String url) {
    return Container(
      width: Adapt.px(200),
      height: Adapt.px(200),
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey[350],
                offset: Offset(5, 8),
                //spreadRadius: Adapt.px(10),
                blurRadius: Adapt.px(20))
          ],
          borderRadius: BorderRadius.circular(Adapt.px(15)),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(url))),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(50)),
      height: Adapt.padTopH() + Adapt.px(150),
      child: Row(
        children: <Widget>[
          SizedBox(width: Adapt.px(30)),
          Container(
            height: Adapt.px(90),
            width: Adapt.px(3),
            color: Colors.orange,
          ),
          SizedBox(width: Adapt.px(35)),
          Text(
            'Fine dining',
            style: TextStyle(fontSize: Adapt.px(60)),
          ),
          Expanded(child: SizedBox()),
          Icon(
            Icons.menu,
            size: Adapt.px(60),
          )
        ],
      ),
    );
  }

  Widget _buildLeftPanel() {
    return Container(
      width: Adapt.px(350),
      child: Column(
        children: <Widget>[
          _buildRecipeCell('images/feta_leek_and_chard_pie.jpg'),
          SizedBox(height: Adapt.px(90)),
          _buildRecipeCell('images/cumin_chicken.jpg'),
          SizedBox(height: Adapt.px(90)),
          _buildRecipeCell('images/goat_s_cheese_aubergine.jpg')
        ],
      ),
    );
  }

  Widget _buildRightPanel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: Adapt.px(40)),
          width: Adapt.screenW() - Adapt.px(390),
          height: Adapt.px(500),
          decoration: BoxDecoration(
              //shape: BoxShape.circle,
              image: DecorationImage(
                  alignment: Alignment.topLeft,
                  fit: BoxFit.cover,
                  image: AssetImage('images/rocket_pesto_orzo_dish.png'))),
        ),
        SizedBox(height: Adapt.px(30)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(50)),
          child: Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: 'Rocket',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: ' Pesto Orzo')
              ]),
              style: TextStyle(fontSize: Adapt.px(35))),
        ),
        SizedBox(height: Adapt.px(20)),
        Container(
            width: Adapt.screenW() - Adapt.px(350),
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(50)),
            child: Text(
              'with Charred Courgettes and Tomato Salad',
              style: TextStyle(
                  color: Colors.grey, fontSize: Adapt.px(22), height: 1.5),
            )),
        SizedBox(height: Adapt.px(30)),
        Container(
            width: Adapt.screenW() - Adapt.px(350),
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(50)),
            child: Text('150cl',
                style: TextStyle(
                    color: Color(0xFFD6D5D6),
                    fontSize: Adapt.px(55),
                    fontWeight: FontWeight.w700))),
        SizedBox(height: Adapt.px(30)),
        Container(
          width: Adapt.px(250),
          height: Adapt.px(64),
          margin: EdgeInsets.symmetric(horizontal: Adapt.px(50)),
          decoration: BoxDecoration(
              color: Color(0xFFFFBB00),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFFFFBB00).withAlpha(80),
                    blurRadius: 10,
                    offset: Offset(0, 8))
              ],
              borderRadius: BorderRadius.circular(Adapt.px(32))),
          child: Center(
              child: Text(
            'Ingredients',
            style: TextStyle(color: Colors.white, fontSize: Adapt.px(24)),
          )),
        ),
      ],
    );
  }

  Widget _buildBottomInfo() {
    return Container(
      width: Adapt.screenW() - Adapt.px(250),
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(50), vertical: Adapt.px(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Vallery Farm',
            style: TextStyle(color: Colors.white, fontSize: Adapt.px(65)),
          ),
          Text('Eggs',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Adapt.px(65),
                  fontWeight: FontWeight.bold)),
          SizedBox(height: Adapt.px(20)),
          ClipRRect(
            borderRadius: BorderRadius.circular(Adapt.px(15)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: Adapt.px(320),
                height: Adapt.px(130),
                padding: EdgeInsets.symmetric(
                    horizontal: Adapt.px(30), vertical: Adapt.px(15)),
                color: Colors.white.withOpacity(.3),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'images/venetian_style_veggie_pasta_dish.png',
                      width: Adapt.px(90),
                      height: Adapt.px(90),
                    ),
                    SizedBox(width: Adapt.px(30)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Fruit',
                          style: TextStyle(
                              color: Colors.white, fontSize: Adapt.px(24)),
                        ),
                        SizedBox(height: Adapt.px(8)),
                        Container(
                          width: Adapt.px(50),
                          height: Adapt.px(2),
                          color: Colors.orange,
                        ),
                        SizedBox(height: Adapt.px(8)),
                        SizedBox(
                            width: Adapt.px(140),
                            child: Text(
                              'with Roasted Aubergine, Asparagus and Raisins',
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white, fontSize: Adapt.px(18)),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomDish() {
    return Container(
      width: Adapt.px(250),
      height: Adapt.px(350),
      decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.centerLeft,
              fit: BoxFit.cover,
              image: AssetImage('images/brooke_lark_dish.png'))),
    );
  }

  Widget _buildBottomPanel() {
    return GestureDetector(
        onTap: () => dispatch(MainPageActionCreator.bottomPanelTapped()),
        child: Container(
          height: Adapt.screenH() - Adapt.px(1040) - Adapt.padTopH(),
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                  image: AssetImage('images/brooke_lark_bg.jpeg')),
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(Adapt.px(50)))),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: Adapt.px(35)),
              Container(
                height: Adapt.px(6),
                width: Adapt.px(200),
                color: Colors.white.withOpacity(.7),
              ),
              SizedBox(height: Adapt.px(20)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildBottomInfo(),
                  _buildBottomDish(),
                ],
              )
            ],
          ),
        ));
  }

  return Scaffold(
    backgroundColor: Colors.white,
    body: Container(
        child: Stack(
      children: <Widget>[
        Container(
          width: Adapt.px(350),
          color: Color(0xFFF2F9FC),
        ),
        Column(
          children: <Widget>[
            _buildTitle(),
            SizedBox(
              height: Adapt.px(860),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[_buildLeftPanel(), _buildRightPanel()],
              ),
            ),
            SizedBox(height: Adapt.px(30)),
            _buildBottomPanel()
          ],
        )
      ],
    )),
  );
}
