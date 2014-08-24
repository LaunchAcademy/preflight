Preflight = {
  Components: {},
  Models: {},
  Views: {}
};

Preflight.inDevelopment = function() {
  return Preflight.env && $.inArray(Preflight.env, ['test', 'development']);
}
