enum Endpoint {
  countries,
}

class API {
  API();

  factory API.sandbox() => API();

  static final String host = 'corona.lmao.ninja';

  Uri endpointUri(Endpoint endpoint) => Uri(
        scheme: 'https',
        host: host,
        path: '${_paths[endpoint]}',
        queryParameters: {
          'country': 'spain',
        },
      );

  static Map<Endpoint, String> _paths = {
    Endpoint.countries: 'countries',
  };
}
