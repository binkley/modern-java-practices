let segmentPageTracker = (function(history){

  let trackPage = function(path, context, properties) {
    if (window.analytics) {

      if (window.trackPage) {
          window.trackPage(path, function(name) {
              window.analytics.page(name, context, properties);
          });
      } else {
        window.analytics.page(path, context, properties);
      }

    }
  };

  let getPath = function() {
    return location.pathname;
  };

  let shouldTrackUrlChange = function(newPath, oldPath) {
    return oldPath !== newPath && !!(newPath && oldPath);
  };

  let path = getPath();
  let defaultPageContext = {};
  let defaultPageProperties = {};

  let handleUrlChange = function(historyDidUpdate) {
    setTimeout(function() {
      const oldPath = path;
      const newPath = getPath();

      if (shouldTrackUrlChange(newPath, oldPath)) {
        path = newPath;

        if (historyDidUpdate) {
          trackPage(path, defaultPageContext, defaultPageProperties);
        }
      }
    }, 0);
  };

  let trackUrlChanges = function(segmentAppName) {
    const originalPushStateMethod = history.pushState;
    const originalReplaceStateMethod = history.replaceState;

    defaultPageContext = {"App name": segmentAppName};
    defaultPageProperties = {"context": {"app": {"name": segmentAppName}}};

    history.pushState = function() {
      originalPushStateMethod.apply(history, arguments);
      handleUrlChange(true);
    };

    history.replaceState = function() {
      originalReplaceStateMethod.apply(history, arguments);
      handleUrlChange(false);
    };

    window.onpopstate = function() {
      handleUrlChange(true);
    };
  };

  return {
    trackUrlChanges: trackUrlChanges
  }

})(window.history);