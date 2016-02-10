part of swirl.network;

class Payload404 extends Payload<String> {

  @override
  String get contentType => 'text/plain';

  @override
  String get content => 'Error 404. Could not access the requested address.';
}