import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_test_task/features/transactions/domain/entities/transaction_entity.dart';
import 'package:transactions_test_task/features/transactions/presentation/bloc/transactions_list_cubit/transactions_list_cubit.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({Key? key}) : super(key: key);

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  static final _formKey = GlobalKey<FormState>();
  static final amountController = TextEditingController();
  static final feeController = TextEditingController();

  String dropdownValue = typeOperationDict[TypeOperation.add.name.toString()]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создание транзакции'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Введите сумму транзакции',
                labelText: 'Amount *',
              ),
              validator: (String? value) {
                return (value != null && value.isEmpty)
                    ? 'Обязательное поле'
                    : null;
              },
            ),
            TextFormField(
              controller: feeController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Введите комиссию транзакции',
                labelText: 'Fee *',
              ),
              validator: (String? value) {
                return (value != null && value.isEmpty)
                    ? 'Обязательное поле'
                    : null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Тип операции:'),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.white),
                  underline: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>[
                    typeOperationDict[TypeOperation.add.name.toString()]!,
                    typeOperationDict[
                        TypeOperation.transaction.name.toString()]!,
                    typeOperationDict[
                        TypeOperation.withdrawal.name.toString()]!,
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<TransactionsListCubit>().transactionAdd(
                        double.parse(amountController.text),
                        double.parse(feeController.text),
                        dropdownValue);
                    amountController.clear();
                    feeController.clear();
                    dropdownValue =
                        typeOperationDict[TypeOperation.add.name.toString()]!;

                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Submit'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
