import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribebright/constants.dart';
import 'package:tribebright/model/journal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tribebright/utils/helper.dart';
import 'package:tribebright/utils/sharedpref.dart';

class JournalItem extends StatelessWidget {
  const JournalItem({
    Key? key,
    required this.journal,
  }) : super(key: key);

  final Journal journal;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPurple.withOpacity(0.3),
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              'assets/images/diary_color_ic.png',
              height: 35.h,
            ),
            title: Text(
              journal.message,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            subtitle: Text(journal.category),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: const Icon(
                        CupertinoIcons.pencil,
                        size: 22,
                        color: Colors.black45,
                        // color: Colors.grey.shade600.withRed(150).withOpacity(0.8),
                      ),
                      onPressed: () {
                        var _editMsgController = TextEditingController();
                        _editMsgController.text = journal.message;
                        Get.defaultDialog(
                          backgroundColor: kPurple.withOpacity(0.4),
                          title: 'Update record',
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Material(
                                child: Form(
                                  child: TextFormField(
                                    controller: _editMsgController,
                                    cursorColor: kDarkPurple,
                                    style: const TextStyle(color: kDarkPurple),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 8,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(6),
                                      border: InputBorder.none,
                                    ),
                                    validator: (input) {
                                      if (input!.isEmpty) {
                                        return 'This field cannot be empty';
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          confirm: ElevatedButton(
                            child: const Text('Cancel'),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kPurple)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          cancel: ElevatedButton(
                            child: const Text('Update'),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kPurple)),
                            onPressed: () async {
                              if (!await Helper.isConnected()) {
                                Helper.showToast(kMsgInternetDown);
                                return;
                              }
                              FirebaseDatabase.instance
                                  .ref()
                                  .child('Parents')
                                  .child(FirebaseAuth.instance.currentUser!.uid)
                                  .child('children')
                                  .child(sharedPrefs.currentUserKey)
                                  .child('journal')
                                  .child(journal.key)
                                  .update({
                                'message': _editMsgController.text.trim(),
                              }).then((_) {
                                Helper.showToast(
                                    'Record was updated successfully');
                                Navigator.pop(context);
                              }).catchError((e) {
                                print(
                                    'error happened while updating record $e');
                                Helper.showToast(kMsgSomethingWrong);
                                Navigator.pop(context);
                              });
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        CupertinoIcons.delete_solid,
                        size: 22,
                        color: Colors.black45,
                        // color: Colors.grey.shade600.withRed(150).withOpacity(0.8),
                      ),
                      onPressed: () {
                        Get.defaultDialog(
                          backgroundColor: kPurple.withOpacity(0.4),
                          title: 'Delete Record',
                          middleText:
                              'Are you sure you want to delete this record?',
                          confirm: ElevatedButton(
                            child: const Text('No'),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kPurple)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          cancel: ElevatedButton(
                            child: const Text('Yes'),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kPurple)),
                            onPressed: () async {
                              if (!await Helper.isConnected()) {
                                Helper.showToast(kMsgInternetDown);
                                return;
                              }
                              FirebaseDatabase.instance
                                  .ref()
                                  .child('Parents')
                                  .child(FirebaseAuth.instance.currentUser!.uid)
                                  .child('children')
                                  .child(sharedPrefs.currentUserKey)
                                  .child('journal')
                                  .child(journal.key)
                                  .remove()
                                  .then((_) {
                                Helper.showToast(
                                    'Record was deleted successfully');
                                Navigator.pop(context);
                              }).catchError((e) {
                                print(
                                    'error happened while deleting record $e');
                                Helper.showToast(kMsgSomethingWrong);
                                Navigator.pop(context);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Text(journal.getFormattedDate()),
              ],
            ),
            onTap: () => Get.defaultDialog(
              backgroundColor: kPurple.withOpacity(0.4),
              title: journal.category + ' | ' + journal.getFormattedDate(),
              // middleText: journal.message,
              content: Text(journal.message),
              confirm: ElevatedButton(
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: 14.sp),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPurple)),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          const Divider(color: kDarkPurple, height: 0),
        ],
      ),
    );
  }
}
