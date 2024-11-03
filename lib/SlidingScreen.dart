import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SlidingScreen extends StatefulWidget {
  @override
  _SlidingScreenState createState() => _SlidingScreenState();
}

class _SlidingScreenState extends State<SlidingScreen> {
  PageController _pageController = PageController();
  bool isScreen1 = true;

  // Google Map & MQTT Related Fields
  final Map<String, Marker> _markers = {};
  late GoogleMapController _mapController;
  late MqttServerClient _mqttClient;
  bool _isMqttConnected = false;
  final List<Map<String, double>> _locationQueue = [];

  @override
  void initState() {
    super.initState();
    _setupMqttClient();
  }

  @override
  void dispose() {
    _mqttClient.disconnect();
    super.dispose();
  }

  Future<void> _setupMqttClient() async {
    _mqttClient = MqttServerClient('test.mosquitto.org', '');
    _mqttClient.port = 1883;
    _mqttClient.logging(on: true);
    _mqttClient.keepAlivePeriod = 20;
    _mqttClient.onConnected = _onConnected;
    _mqttClient.onDisconnected = _onDisconnected;
    _mqttClient.onSubscribed = _onSubscribed;

    try {
      final connMessage = MqttConnectMessage()
          .withClientIdentifier('flutter_client')
          .startClean()
          .withWillQos(MqttQos.atLeastOnce);
      _mqttClient.connectionMessage = connMessage;
      await _mqttClient.connect();
    } catch (e) {
      print('MQTT connection failed: $e');
      _mqttClient.disconnect();
    }
  }

  void _onConnected() {
    print('MQTT Connected');
    setState(() {
      _isMqttConnected = true;
    });
    _mqttClient.subscribe('live/json', MqttQos.atMostOnce);
    _mqttClient.updates?.listen(_onMessageReceived);
  }

  void _onDisconnected() {
    print('MQTT Disconnected');
    setState(() {
      _isMqttConnected = false;
    });
  }

  void _onSubscribed(String topic) {
    print('Subscribed to $topic');
  }

  void _onMessageReceived(List<MqttReceivedMessage<MqttMessage>> event) {
    final MqttPublishMessage recMess = event[0].payload as MqttPublishMessage;
    final String message =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    try {
      final data = jsonDecode(message);
      final lat = data['lat'] as double;
      final lon = data['lun'] as double;

      print('Received location: lat=$lat, lon=$lon');

      if (_mapController != null) {
        _updateMarker(lat, lon);
      } else {
        _locationQueue.add({'lat': lat, 'lun': lon});
        print('Map controller not initialized, location queued.');
      }
    } catch (e) {
      print('Error processing message: $e');
    }
  }

  void _updateMarker(double lat, double lon) {
    final marker = Marker(
      markerId: const MarkerId('live_location'),
      position: LatLng(lat, lon),
      infoWindow: const InfoWindow(
        title: 'WheelChair 🧑🏼‍🦼',
      ),
    );

    setState(() {
      _markers['live_location'] = marker;
      _mapController.animateCamera(
        CameraUpdate.newLatLng(LatLng(lat, lon)),
      );
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;

    if (_locationQueue.isNotEmpty) {
      for (var location in _locationQueue) {
        _updateMarker(location['lat']!, location['lun']!);
      }
      _locationQueue.clear();
    }

    if (_isMqttConnected) {
      print('MQTT is connected and map is ready.');
    } else {
      print('MQTT is not connected yet.');
    }
  }

  void _togglePage() {
    setState(() {
      isScreen1 = !isScreen1;
    });
    _pageController.animateToPage(isScreen1 ? 0 : 1,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: _togglePage,
            child: Text(isScreen1 ? "AI 🤖" : "Map 📍"),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white70,
            child: PageView(
              controller: _pageController,
              physics:const NeverScrollableScrollPhysics(),
              children: [
                _buildScreen1(),
                _buildScreen2(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScreen1() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: LatLng(20.5937, 78.9629),
        zoom: 3,
      ),
      markers: _markers.values.toSet(),
    );
  }
  Widget _buildScreen2() {
    // WebViewController to manage the webview
    late final WebViewController _controller;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('http://httpforever.com/'))
      ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onHttpError: (HttpResponseError error) {

        print(error);
      },
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  );

    return WebViewWidget(controller: _controller);
  }
}