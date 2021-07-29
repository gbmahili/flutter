import "dart:io";
import 'package:expense_planner/models/transactions.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:expense_planner/widgets/user_transaction.dart';
// import 'package:flutter/services.dart';

void main() {
  // Restrict app to Landscape orientation or Portrait orientation.
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Planner',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.amberAccent,
        fontFamily: 'Quicksand', // For the whole app.
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              headline5: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                // headeline6 is for the app bar title.
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // late String titleInput;
  // late String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final titleController = TextEditingController();
  // final amountController = TextEditingController();

  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      // Only return transactions that are 7 days or less old.
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    // PreferredSize is something available in the Material widget and can get the size of the appBar
    dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expense Planner'),
            trailing: Row(
              mainAxisSize: MainAxisSize
                  .min, // take the minimum size it can take, otherwise, it takes the full width and hides the title
              children: [
                GestureDetector(
                  child: Icon(
                    CupertinoIcons.add,
                  ),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Expense Planner'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
    String showHideText = _showChart ? 'Hide Chart' : 'Show Chart';

    final Widget _transactionListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions.toList(), _deleteTransaction),
    );

    final Widget pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape) // this is a shorthand for if isLandscape. No need for else.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  showHideText,
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 10,
                ),
                Switch.adaptive(
                  // adaptive makes the switch look different on IOS and Android
                  value: _showChart,
                  activeColor: Theme.of(context).accentColor,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                )
              ],
            ),
          if (!isLandscape)
            Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.3,
              child: Chart(_recentTransactions),
            ),
          if (!isLandscape) _transactionListWidget,
          if (isLandscape)
            _showChart
                ? Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(_recentTransactions),
                  )
                : _transactionListWidget,
        ],
      ),
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            // Platform is imported from dart:io to tell which platform we are on
            floatingActionButton: Platform.isIOS
                ? null
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
