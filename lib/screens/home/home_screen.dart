import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '/blocs/blocs.dart';
import '/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.authUser != current.authUser,
      listener: (context, state) {
        print('Home screen Auth Listener');
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Color(0xffFCFCB8),
          appBar: CustomAppBar(
            title: 'Home',
            automaticallyImplyLeading: false,
          ),
          bottomNavigationBar: CustomNavBar(screen: routeName),
          body: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is CategoryLoaded) {
                      return CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 1.5,
                          viewportFraction: 0.9,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                        ),
                        items: state.categories
                            .map((category) => HeroCarouselCard(category: category))
                            .toList(),
                      );
                    } else {
                      return Text('Something went wrong.');
                    }
                  },
                ),
                SectionTitle(title: 'RECOMMENDED'),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ProductLoaded) {
                      return ProductCarousel(
                        products: state.products
                            .where((product) => product.isRecommended)
                            .toList(),
                      );
                    } else {
                      return Text('Something went wrong.');
                    }
                  },
                ),
                SectionTitle(title: 'MOST POPULAR'),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ProductLoaded) {
                      return ProductCarousel(
                        products: state.products
                            .where((product) => product.isPopular)
                            .toList(),
                      );
                    } else {
                      return Text('Something went wrong.');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
