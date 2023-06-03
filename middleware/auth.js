export default function ({ app, redirect }) {
  const isAuthenticated = app.$auth.loggedIn;

  if (!isAuthenticated) {
    return redirect("/auth");
  }
}
