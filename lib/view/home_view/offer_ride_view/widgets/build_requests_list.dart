import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:smride_app/model/fetch_request_model.dart";
import "package:smride_app/view/home_view/offer_ride_view/widgets/request_card.dart";
import "package:smride_app/view_model/home_view_model.dart";

final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();

Widget buildRequestList(
    List<FetchRequestModel> requests, BuildContext context) {
  return RefreshIndicator(
    onRefresh: context.read<HomeViewModel>().fetchRequests,
    key: _refreshIndicatorKey,
    child: requests.isNotEmpty
        ? ListView.builder(
            itemCount: requests.length,
            itemBuilder: (BuildContext context, int index) {
              return requestCard(context, requests[index]);
            },
          )
        : Center(
            child: Text(
              "No Requests",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),
  );
}
