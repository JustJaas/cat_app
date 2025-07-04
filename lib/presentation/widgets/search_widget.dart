import 'dart:async';
import 'package:cats_app/presentation/providers/blocs/cat_bloc/cat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Timer debounce = Timer(const Duration(milliseconds: 500), () {});

    return BlocBuilder<CatBloc, CatState>(
      builder: (context, state) {
        return Container(
            margin: const EdgeInsets.only(left: 15, bottom: 5, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                        bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5)),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: 'Buscar',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (debounce.isActive) debounce.cancel();
                        debounce = Timer(const Duration(milliseconds: 500), () {
                          context.read<CatBloc>().add(SearchData(text: value));
                        });
                      },
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
