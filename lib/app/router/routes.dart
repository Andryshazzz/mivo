enum Routes {
  auth(path: '/', name: 'auth'),
  home(path: '/home', name: 'home'),
  tasks(path: '/tasks', name: 'tasks'),
  plan(path: '/plan', name: 'plan'),
  profile(path: '/profile', name: 'profile'),
  any(path: '/any', name: 'any'),
  settings(path: '/settings', name: 'settings'),
  create(path: '/create', name: 'create');

  final String path;
  final String name;

  const Routes({required this.path, required this.name});
}
