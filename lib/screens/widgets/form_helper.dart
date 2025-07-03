import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

import '../../utils/languages/constants.dart';

InputDecoration fieldDecoration(
    {required IconData prefixIcon,
      required String labelText,
      String? hintText}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    prefixIcon: Icon(
      prefixIcon,
    ),
    labelText: labelText,
    hintText: hintText,
  );
}

myTextField(
    BuildContext context, {
      required TextEditingController controller,
      required String label,
      required IconData icon,
      required Function onValidate,
      String? hintText,
    }) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.text,
    decoration:
    fieldDecoration(prefixIcon: icon, labelText: label, hintText: hintText),
    validator: (value) {
      return onValidate(value);
    },
  );
}

myPasswordField(
    BuildContext context, {
      required TextEditingController controller,
      required String label,
      required bool isChecked,
      Function? isCheck,
      required Function onValidate,
    }) {
  return TextFormField(
    controller: controller,
    obscureText: isChecked,
    decoration: InputDecoration(
      errorMaxLines: 10,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      prefixIcon: const Icon(
        Icons.password,
      ),
      labelText: label,
      suffixIcon: isCheck == null
          ? null
          : IconButton(
        onPressed: isCheck as void Function()?,
        icon: isChecked
            ? const Icon(
          Icons.visibility_off,
        )
            : const Icon(
          Icons.visibility,
        ),
      ),
    ),
    validator: (value) {
      return onValidate(value);
    },
  );
}

myEmailField(BuildContext context,
    {required TextEditingController controller, required String label}) {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    controller: controller,
    decoration:
    fieldDecoration(prefixIcon: Icons.alternate_email, labelText: label),
    validator: (value) {
      bool emailValid =
      RegExp(r"^[a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
          .hasMatch(value!);
      if (!emailValid) {
        return "${getTranslated(context, 'invalid_email')}";
      }
      return null;
    },
  );
}

myDescriptionField(
    BuildContext context, {
      required TextEditingController controller,
      required Function onValidate,
      required String hint,
    }) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.text,
    maxLines: null,
    minLines: 2,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      prefixIcon: const Icon(
        Icons.edit_note,
      ),
      hintText: hint,
    ),
    validator: (value) {
      return onValidate(value);
    },
  );
}
searchOriginField(
    BuildContext context, {
      required TextEditingController controller,
      required FocusNode focusNode,
      required Function onMap,
      required Function onClean,
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 5),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withAlpha(30),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Ionicons.pin,
              color: Theme.of(context).primaryColor,
            ),
            hintText: "${getTranslated(context, 'choose_origin')}",
            contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                style: BorderStyle.none,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 0.8,
                color: Theme.of(context).primaryColor,
              ),
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => onMap(),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary.withAlpha(30),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Ionicons.map_outline,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (controller.text.length >= 3)
                  GestureDetector(
                    onTap: () => onClean(),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary.withAlpha(30),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.close),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

searchDestinationField(
    BuildContext context, {
      required TextEditingController controller,
      required FocusNode focusNode,
      required Function onMap,
      required Function onClean,
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withAlpha(30),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          autofocus: true,
          controller: controller,
          focusNode: focusNode,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            hintText: "${getTranslated(context, 'choose_destination')}",
            contentPadding: EdgeInsets.zero,
            prefixIcon:  Icon(
              Ionicons.location,
              color: Theme.of(context).primaryColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                style: BorderStyle.none,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 0.8,
                color: Theme.of(context).primaryColor,
              ),
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => onMap(),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary.withAlpha(30),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Ionicons.map_outline,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (controller.text.length >= 3)
                  GestureDetector(
                    onTap: () => onClean(),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary.withAlpha(30),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.close),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget searchStopField(
    BuildContext context, {
      required TextEditingController controller,
      required FocusNode focusNode,
      required Function onMap,
      required Function onClean,
      required Function onAdd,
      required Function onRemove,
      required bool isAdd,
    }) {
  if (isAdd) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onRemove(),
            child: Container(
              padding: const EdgeInsets.all(3),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary.withAlpha(30),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0.8,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => onMap(),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Ionicons.map_outline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  } else {
    return GestureDetector(
      onTap: () => onAdd(),
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 3, 10, 3),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add),
            Text(
              "${getTranslated(context, 'add_stop')}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}