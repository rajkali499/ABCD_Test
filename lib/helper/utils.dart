import 'package:flutter/material.dart';
import 'package:newapp/model/navigation_model.dart';
import 'package:newapp/ui/screen/base_screen.dart';

List<NavigationModel> navItems = [
  NavigationModel(
      tabWidget: const BaseScreen('Home', isGridEnabled: true,),
      icon: const Icon(Icons.home),
      topBodyWidget: const Text("Home", style: TextStyle(fontSize: 8))),
  NavigationModel(
      icon: const Icon(Icons.business),
      tabWidget: const BaseScreen('Insure',isGridEnabled: false,),
      topBodyWidget: const Text("Insure", style: TextStyle(fontSize: 8))),
  NavigationModel(
      icon: const Icon(Icons.school),
      tabWidget: const BaseScreen('Invest',isGridEnabled: true,),
      topBodyWidget: const Text("Invest", style: TextStyle(fontSize: 8))),
  NavigationModel(
      icon: const Icon(Icons.currency_exchange),
      tabWidget: const BaseScreen('Loans', isGridEnabled: false,),
      topBodyWidget: const Text("Loans", style: TextStyle(fontSize: 8))),
  NavigationModel(
      icon: const Icon(Icons.person),
      tabWidget: const BaseScreen('About', isGridEnabled: true,),
      topBodyWidget: const Text("About", style: TextStyle(fontSize: 8))),
];


final Map<String, String> descriptions = {
  "Stock": "This is the description for Stock.",
  "Mutual Funds": "This is the description for Mutual Funds.",
  "Gold": "This is the description for Gold.",
  "Deposits": "This is the description for Deposits.",
};

List<String> listContents = ["Scan & Pay", "Pay to Mobile No.", "Receive Money", "Transaction History"];

