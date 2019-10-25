library chat;

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

part 'app.dart';
part 'blocs/chat.dart';
part 'blocs/login.dart';
part 'models/base.dart';
part 'models/message.dart';
part 'models/user.dart';
part 'pages/chat.dart';
part 'pages/home.dart';
part 'pages/login.dart';
part 'utils/datetime.dart';
part 'widgets/dialog.dart';
