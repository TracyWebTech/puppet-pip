
class pip {
  ensure_resource('pip::install', ['2.6', '2.7', '3.3', '3.4'])
}
