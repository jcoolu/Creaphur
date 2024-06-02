import 'package:creaphur/models/material.dart' as material_model;
import 'package:creaphur/screens/dashboard/main.dart';
import 'package:creaphur/services/material_service.dart';
import 'package:creaphur/widgets/delete_dialog.dart';
import 'package:creaphur/widgets/forms/material_form.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class MaterialScreen extends StatefulWidget {
  final material_model.Material material;
  const MaterialScreen({super.key, required this.material});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  String name = '';
  late material_model.Material? newMaterial = widget.material;

  void handleBack() {
    Navigator.pop(
      context,
      MaterialPageRoute(builder: (context) => const Dashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isNew = widget.material.id.isEmpty;

    void handleChange(field, value) {
      newMaterial ??=
          widget.material; // set newMaterial to widget.material if null
      Map<String, dynamic> materialMap = newMaterial!.toMap();
      materialMap[field] = value;
      setState(
          () => newMaterial = material_model.Material.fromMap(materialMap));
    }

    void handleSave() async {
      if (newMaterial!.id.isEmpty) {
        handleChange('id', const Uuid().v4());
        await MaterialService.addMaterial(context, newMaterial!);
      } else {
        await MaterialService.updateMaterial(context, newMaterial!);
      }

      // Store the current context
      BuildContext currentContext = context;
      // Check if the widget is still mounted before navigating
      if (!mounted) return;

      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text('Saved Material')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (currentContext) => const Dashboard()),
      );
    }

    void handleDelete() {
      MaterialService.deleteMaterial(context, widget.material);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleted Material')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: const Color(0xff1d874b),
            height: 3.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          onPressed: handleBack,
        ),
        title: Text(isNew ? 'New Material' : 'Edit Material'),
        backgroundColor: const Color(0xff2bca70),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        actions: <Widget>[
          if (!isNew)
            DeleteDialog(
                isDeleteDisabled: false,
                isIconButton: true,
                model: 'material',
                onDelete: handleDelete,
                confirmedWidgetPath: MaterialScreen(material: widget.material),
                buttonText: 'Delete Material')
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: SingleChildScrollView(
            child: MaterialForm(
              onChange: handleChange,
              onSave: handleSave,
              material: newMaterial,
              isNew: isNew,
            ),
          ),
        ),
      ),
    );
  }
}
