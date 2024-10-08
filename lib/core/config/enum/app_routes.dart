/// Represents the app routes and their paths.
enum AppRouterName {
  // routs Views
  //routs(name: 'routs', path: '/'),

  home(name: 'home', path: '/'),
  //=> Note Views
  //Note Add
  add(name: 'note', path: 'note/new'),
  //Note Detail
  note(name: 'note', path: 'note/:noteId'),

  imagePreview(name: 'Image preview', path: 'image'),
  //=>
  archive(name: 'Archive', path: '/Archive'),
  trash(name: 'Trash', path: '/Trash'),

  setting(name: 'Settings', path: 'setting');

  const AppRouterName({required this.name, required this.path});

  final String name;
  final String path;
}
