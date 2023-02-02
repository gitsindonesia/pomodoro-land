'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "flutter.js": "1cfe996e845b3a8a33f57607e8b09ee4",
"index.html": "13995e2ece2f146f4812bcdf7853fb2e",
"/": "13995e2ece2f146f4812bcdf7853fb2e",
"main.dart.js": "ab9259829c030c1314831de6bdeefdae",
"manifest.json": "b01308cb2bd92ac45afe53da3931cc4b",
"favicon.png": "245902ad1e5ce2ecab85784b16bf3a6b",
"icons/Icon-512.png": "96eee214578dd7224ae7bc31bd9522f3",
"icons/Icon-maskable-512.png": "96eee214578dd7224ae7bc31bd9522f3",
"icons/Icon-maskable-192.png": "8154e63d50bb3ba9cf9434cf433b98a7",
"icons/Icon-192.png": "8154e63d50bb3ba9cf9434cf433b98a7",
"splash/splash.js": "123c400b58bea74c1305ca3ac966748d",
"splash/img/dark-2x.png": "d770b122ddfbcefcf168626f8ccc36ed",
"splash/img/light-1x.png": "9c2b2817b055e2bf4cddd9ccad3c643f",
"splash/img/light-4x.png": "4caff1f9bfd32d50ec50654bb1fe906f",
"splash/img/light-3x.png": "c6aaee8ea3a35aa89ae62b10e3adb096",
"splash/img/light-2x.png": "d770b122ddfbcefcf168626f8ccc36ed",
"splash/img/dark-3x.png": "c6aaee8ea3a35aa89ae62b10e3adb096",
"splash/img/dark-4x.png": "4caff1f9bfd32d50ec50654bb1fe906f",
"splash/img/dark-1x.png": "9c2b2817b055e2bf4cddd9ccad3c643f",
"splash/style.css": "3e8699dd65a865ff991ec5b47a93643d",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/NOTICES": "362787dd6aa42009c661e58669b95678",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/line-short.png": "df504d9ccb261665295baafddb81caad",
"assets/assets/images/toggle-on.png": "6e2bb8bde90fe8901a58348ea1ff7b31",
"assets/assets/images/dropdown.png": "f63b7a0989304172a14f1571a443c967",
"assets/assets/images/refresh.png": "3b119389a15e92c8c225f5b153e5b0be",
"assets/assets/images/edit.png": "19f83112a7c76c624a9db784c5cf8156",
"assets/assets/images/taiga.png": "9ad5af05a2174feec0d754ed4270dabf",
"assets/assets/images/toggle-off.png": "47d2dca3c29aa11457630dbb2004c983",
"assets/assets/images/button.png": "e43089b752b74a6f8c741c667519a22e",
"assets/assets/images/plus.png": "7cf09cbbb3b90b2002e5b727947e27a5",
"assets/assets/images/line-long.png": "8ac1e4e35dcd49ee8042051f95883342",
"assets/assets/images/button-inactive.png": "fb3bd16d832c7d02c721012e1ec2608e",
"assets/assets/images/check-active.png": "e8944e4bec8b3b4ecdb1eabdc4962bea",
"assets/assets/images/button-white.png": "2cc88c5ea46b646af4b401955bda1533",
"assets/assets/images/close.png": "b3f23ac92d7d305e67e94587e61f7cdd",
"assets/assets/images/empty-state.png": "c45e049b814b729cd6f96eada462755a",
"assets/assets/images/setting.png": "0e537945dde75c0fa1066b45fdb211cc",
"assets/assets/images/clockify.png": "d36c9ab156d5e399a11342ef8c6a857b",
"assets/assets/images/check-inactive.png": "e0726dbdf798416456749481b0ab4da3",
"assets/assets/images/next.png": "1f0e55b3ee1eb5fbf03225148390a84f",
"assets/assets/images/delete.png": "326b7923e349fa2c9a1a1e5235bf2cac",
"assets/assets/images/focus-line.png": "dbb1e4764d27455807dc09a7dc2d7034",
"assets/assets/images/pomodoro-tomato.png": "fdef13521d52d7dd9765be8a90c14dae",
"assets/assets/sounds/digital.wav": "7d6103aed26a7bfec087edeac2de1d55",
"assets/assets/sounds/button.wav": "3d0d98a022b9f26d27a483d2cd740605",
"assets/assets/sounds/bird.wav": "5cfc28f4c75f82a7c077bc0cfedf4ea7",
"assets/assets/sounds/waker.wav": "10299ca5a4495c9f75783e54d1fee482",
"assets/assets/sounds/kitchen.wav": "d754778fe1761b0ce0baf8a5c6e394b4",
"assets/AssetManifest.json": "2a2278b184cc5197c58e36b368a5c744",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"version.json": "564f75ce2732b1e6de2751f5abc8e160"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
