Preflight = {
  Components: {},
  Views: {}
};

Preflight.inDevelopment = function() {
  return Preflight.env && $.inArray(Preflight.env, ['test', 'development']);
}
