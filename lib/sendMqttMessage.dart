import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

Future<void> sendMqttMessage(String server, String topic, String message) async {
  final client = MqttServerClient(server, 'flutter_client');
  client.logging(on: true);
  client.setProtocolV311();
  client.port = 1883; // Default MQTT port
  client.keepAlivePeriod = 20;

  final connMessage = MqttConnectMessage()
      .withClientIdentifier('MqttFlutterClient')
      .keepAliveFor(20)
      .withWillQos(MqttQos.atLeastOnce);
  client.connectionMessage = connMessage;

  try {
    await client.connect();
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
      print('Message "$message" sent to topic "$topic"');
    } else {
      print('Failed to connect to MQTT broker');
    }
  } on Exception catch (e) {
    print('MQTT connection failed: $e');
  } finally {
    client.disconnect();
  }
}
