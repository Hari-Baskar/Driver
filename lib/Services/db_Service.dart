import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Commons/constant_strings.dart';
import 'package:driver/Pojo/vechileDetails_Pojo.dart';
import 'package:intl/intl.dart';

class DBService {


  createUserWithDetails({
    required Map vechileDetails,
  }) async {
    return await firestore
        .collection("driver")
        .doc(vechileDetails["uid"])
        .set({
      "driverName":vechileDetails["driverName"],
      "vechileID":vechileDetails["vechileID"],
      "uid":vechileDetails["uid"],
      "email":vechileDetails["email"],
      "droplocationArranged":false,
      "droplocations":[],
      "petrolAllowanceAmount":0,
      "vechileServiceAmount":0,
      "route":null,
      "arrangedDroplocations":[],
    });
  }

  Stream getVechileDetails({required String uid}) {
    return firestore.collection("driver").doc(uid).snapshots();
  }

  Stream totalPassengers({required String uid}) {
    return firestore
        .collection("driver")
        .doc(uid)
        .collection("students")
        .snapshots();
  }

  Stream todaysPassengers({
    required String uid,
    required String collectionName,
  }) {
    DocumentReference documentRef =
        firestore.collection("driver").doc(uid).collection("history").doc(date);

    return documentRef.snapshots().map((snapshot) {
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        return {};
      }
    });
  }

  Future<void> addPassengersInTodaysDate({
    required String uid,
    required Map uploadPassengerDetails,
    required String uploadTripType,
  }) async {
    DocumentReference docRef =
        firestore.collection("driver").doc(uid).collection("history").doc(date);

    DocumentSnapshot docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      await docRef.set({"passengersList": []});
    }

    await docRef.update({
      "${uploadTripType.toLowerCase()}PassengersList":
          FieldValue.arrayUnion([uploadPassengerDetails])
    });
  }

  deletePassengerFromList({
    required String uid,
    required Map passengerDetails,
    required String uploadTripType,
  }) async {
    return await firestore
        .collection('driver')
        .doc(uid)
        .collection("history")
        .doc(date)
        .update({
      '${uploadTripType.toLowerCase()}PassengersList':
          FieldValue.arrayRemove([passengerDetails])
    });
  }

  addTicketToHistory({
    required String ticketName,
    required String Amount,
    required String uid,
  }) async {
    DocumentReference documentReference =
        firestore.collection("driver").doc(uid).collection("history").doc(date);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    if (!documentSnapshot.exists) {
      await documentReference.set({
        "ticket": [
          {
            "ticketName": ticketName,
            "amount": Amount,
            "uid": uid,
            "date": date,
            "time": DateFormat("hh-mm  a").format(currentDateTime),
            "status": "Pending"
          }
        ]
      });
    } else {
      await documentReference.update({
        "ticket": FieldValue.arrayUnion([
          {
            "ticketName": ticketName,
            "amount": Amount,
            "uid": uid,
            "date": date,
            "time": DateFormat("hh-mm a").format(currentDateTime),
            "status": "Pending"
          }
        ])
      });
    }
  }

  Stream todayTicketStream({required String uid}) {
    DocumentReference documentRef =
        firestore.collection("driver").doc(uid).collection("history").doc(date);

    return documentRef.snapshots().map((snapshot) {
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        return {};
      }
    });
  }

  deleteTicket({required String uid, required Map ticketDetails}) async {
    return await firestore
        .collection("driver")
        .doc(uid)
        .collection("history")
        .doc(date)
        .update({
      "ticket": FieldValue.arrayRemove([ticketDetails])
    });
  }

  Stream showHistory({
    required String uid,
    String? historyType,
    String? fromDateStream,
    String? toDateStream,
  }) {

    if (historyType != null) {
      return firestore
          .collection("driver")
          .doc(uid)
          .collection("history")
          .snapshots();
    }


    else {
      return firestore
          .collection("driver")
          .doc(uid)
          .collection("history")
          .where(FieldPath.documentId, isGreaterThanOrEqualTo: fromDateStream)
          .where(FieldPath.documentId, isLessThanOrEqualTo: toDateStream)
          .snapshots();
    }
  }

  Stream<Map<String, dynamic>> showHistoryOnlyGivenDate({
    required String uid,
    required String givenDate,
  }) {
    DocumentReference documentReference = firestore
        .collection("driver")
        .doc(uid)
        .collection("history")
        .doc(givenDate);


    return documentReference.snapshots().map((documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      } else {
        return {}; // Return an empty map if the document doesn't exist
      }
    });
  }

  getDocumentDetails({
    required String uid,
    required String docId,
  }) async {
    return await firestore
        .collection("driver")
        .doc(uid)
        .collection("history")
        .doc(docId)
        .get();
  }

  Stream getRoutes(){
    return firestore.collection("route").snapshots();
  }

  selectedRoute({
    required String routeName,
  }) {
    return firestore.collection("route").doc(routeName).get();
  }

  confirmDroplocation({
    required String uid,
    required String droplocation,
    required String route,
}){
    return firestore.collection("students").doc(uid).update({
      "route":route,
      "droplocation":droplocation
    });
}

Stream showDroplocations({required String route}){
    return firestore.collection("route").doc(route).snapshots();
}
updateDroplocation({
    required String droplocation,
  required String uid,
}){
    return firestore.collection("driver").doc(uid).update({
      "arrangedDroplocations":FieldValue.arrayUnion([
        droplocation
      ])
    });
}
deleteDroplocation({
  required String droplocation,
  required String uid,
}){
  return firestore.collection("driver").doc(uid).update({
    "arrangedDroplocations":FieldValue.arrayRemove([
      droplocation
    ])
  });
}

  setArrangeDropLocationsToTrue({
    required String uid
})async{
    return await firestore.collection("driver").doc(uid).update({
      'droplocationArranged':true,
    });
  }


}
