import 'package:creaphur/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseSummaryCard extends StatelessWidget {
  final Expense expense;
  final void Function()? onTap;

  const ExpenseSummaryCard({
    super.key,
    required this.expense,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xff6c47ff), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              tileColor: const Color(0xffad99ff),
              textColor: Colors.white,
              splashColor: const Color(0xff2900cc),
              title: Text(expense.name,
                  softWrap: false,
                  style: const TextStyle(overflow: TextOverflow.ellipsis)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Material: ${expense.getMaterialName(context)}'),
                  Text('Cost: \$${expense.getMaterialCost(context)}')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
