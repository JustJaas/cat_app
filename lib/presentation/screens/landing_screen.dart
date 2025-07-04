import 'package:cats_app/presentation/providers/blocs/cat_bloc/cat_bloc.dart';
import 'package:cats_app/presentation/widgets/cat_appbar.dart';
import 'package:cats_app/presentation/widgets/cat_card.dart';
import 'package:cats_app/presentation/widgets/search_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  CatBloc? catBloc;

  @override
  void initState() {
    catBloc = BlocProvider.of<CatBloc>(context);
    catBloc!.add(LoadData());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CatAppBar(text: 'Cat Breeds'),
      body: BlocBuilder<CatBloc, CatState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading.json',
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
            );
          }
          if (state.isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Hubo un problema, intente más tarde.'),
                backgroundColor: Colors.red,
              ),
            );
            catBloc!.add(ClearError());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.07,
                  width: double.infinity,
                  child: const SearchWidget(),
                ),
                SizedBox(
                  height: size.height,
                  child: state.cats.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/error.png',
                                height: 350,
                                width: 350,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                'No hay gatos para mostrar',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: size.height * 0.25),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(bottom: size.height * 0.25),
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.cats.length,
                          itemBuilder: (BuildContext context, index) {
                            return CatCard(cat: state.cats[index]);
                          }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
