'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "afb1b477aae0aed603b0742e57fad8bb",
"assets/AssetManifest.bin.json": "5a973a40fe39ead2d221a195f98031bb",
"assets/AssetManifest.json": "29108d738ebfb4766840cbb411725a4c",
"assets/assets/1.mp3": "3c51e02ef27d744fd4048246dadf9d4c",
"assets/assets/about_us.pdf": "4a90dc79a068732b13b664addc3b42f3",
"assets/assets/images/about_us.png": "ea155b4b5b54d77395701efbdebce713",
"assets/assets/images/app_logo.png": "aa9de0988eb86109bc4275ac344d32d3",
"assets/assets/images/avatar.png": "991908fd248402849428758c1760fb93",
"assets/assets/images/bank.webp": "f9ed144af82f74354ff4c943bdb1b63e",
"assets/assets/images/bg-dark.png": "d03ec45fe1bed7e84a71e169608aa464",
"assets/assets/images/bg-light.png": "9fe455d16a6d2aec483a4c09ff3c331d",
"assets/assets/images/bg.png": "047cbb5c14a7ee8bd2a9ef457e3876c8",
"assets/assets/images/card_bg.png": "2c4252905bf68cbcaccf8adaff09a455",
"assets/assets/images/easy_paisa.png": "77ba22efd49989ffe7d9e11afdc101e8",
"assets/assets/images/fb.png": "6bb00e5a28629fea6ee789629340e406",
"assets/assets/images/indicator.png": "53e6e728cb1eb3d6e5496f712f7a4f05",
"assets/assets/images/indicator_2.png": "94c1896c7d1a40644474e0fb7a29e9e3",
"assets/assets/images/jazz_cash.png": "16ee49088798cdaca71af63d829215cc",
"assets/assets/images/logo.png": "7d85c74ce6a9052e87e2e73c5ebaea03",
"assets/assets/images/mastercard.png": "7e386dc6c169e7164bd6f88bffb733c7",
"assets/assets/images/prize_no.png": "e2b2d0f377623bdd2688050fd70dafc3",
"assets/assets/images/splash.png": "9e5d04137d5280fb367aa50ea77240be",
"assets/assets/images/splash_1.png": "19dfb7ad2712973d8d7d0a81550683bf",
"assets/assets/images/status.png": "14e7de0929fe2e97d0a1d3c01c663930",
"assets/assets/images/status_paid.png": "adfd9f367ddb295a231aa74001396f2e",
"assets/assets/images/task_placeholder.png": "a65899e9065e794af3141e2e679946b8",
"assets/assets/images/telegram.png": "4047572f6986c175753c0ee593e0b7b7",
"assets/assets/images/tt.png": "e45d4b12d9dc063defb17837ab27484d",
"assets/assets/images/WhatsApp.svg.webp": "368b8210dba1fbac15b7d1a9f66ef42d",
"assets/assets/images/whats_app.png": "4f40219d02f74096afa74c13c2ba60e9",
"assets/assets/images/wheel.png": "3f836c023d54fcabf1fff6cb929f74dd",
"assets/assets/images/wheel1.png": "753440377f5d923c08f50e3dce7f8e4d",
"assets/assets/images/wheel_bg.png": "dc4314ea0fd1bbc9162cd6a08bf216b6",
"assets/assets/images/wheel_bg_o.png": "cfe044e88960b66a1a5c4e036572173b",
"assets/assets/images/wheel_o.png": "794788bc26359e9f21e857e3d1e8ef1e",
"assets/assets/images/winnerDrawPdfPng.JPG": "773dce859d2b17e0a1ae9074c9dba34b",
"assets/assets/images/yt.png": "51774971eea15cd042d9a3000a06f70e",
"assets/assets/sound_celebration.mp3": "c5e1a1e2c2a5aa71dcdb3c767a45a753",
"assets/assets/wheel_spin.mp3": "87958e2047bb95361b0a364c36041203",
"assets/assets/winnerDrawPdf.pdf": "52d983d2c4c1a6af611995e9c6aa3627",
"assets/FontManifest.json": "5425b4ba42b391289cfd067e91db8f7c",
"assets/fonts/MaterialIcons-Regular.otf": "a49a03f730b2d5fcd8342a1872d513af",
"assets/NOTICES": "f89fa1360de90a73cc1470e4a0fb59b3",
"assets/packages/awesome_snackbar_content/assets/back.svg": "ba1c3aebba280f23f5509bd42dab958d",
"assets/packages/awesome_snackbar_content/assets/bubbles.svg": "1df6817bf509ee4e615fe821bc6dabd9",
"assets/packages/awesome_snackbar_content/assets/types/failure.svg": "cb9e759ee55687836e9c1f20480dd9c8",
"assets/packages/awesome_snackbar_content/assets/types/help.svg": "7fb350b5c30bde7deeb3160f591461ff",
"assets/packages/awesome_snackbar_content/assets/types/success.svg": "6e273a8f41cd45839b2e3a36747189ac",
"assets/packages/awesome_snackbar_content/assets/types/warning.svg": "cfcc5fcb570129febe890f2e117615e0",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/flutter_credit_card/font/halter.ttf": "4e081134892cd40793ffe67fdc3bed4e",
"assets/packages/flutter_credit_card/icons/amex.png": "f75cabd609ccde52dfc6eef7b515c547",
"assets/packages/flutter_credit_card/icons/chip.png": "5728d5ac34dbb1feac78ebfded493d69",
"assets/packages/flutter_credit_card/icons/discover.png": "62ea19837dd4902e0ae26249afe36f94",
"assets/packages/flutter_credit_card/icons/elo.png": "ffd639816704b9f20b73815590c67791",
"assets/packages/flutter_credit_card/icons/hipercard.png": "921660ec64a89da50a7c82e89d56bac9",
"assets/packages/flutter_credit_card/icons/mastercard.png": "7e386dc6c169e7164bd6f88bffb733c7",
"assets/packages/flutter_credit_card/icons/rupay.png": "a10fbeeae8d386ee3623e6160133b8a8",
"assets/packages/flutter_credit_card/icons/unionpay.png": "87176915b4abdb3fcc138d23e4c8a58a",
"assets/packages/flutter_credit_card/icons/visa.png": "f6301ad368219611958eff9bb815abfe",
"assets/packages/im_stepper/assets/me.jpg": "487511e754834bdf2e6771376d59707e",
"assets/packages/neumorphic_ui/fonts/NeumorphicIcons.ttf": "32be0c4c86773ba5c9f7791e69964585",
"assets/packages/wheel_spin/assets/screenshot.jpg": "3add16ab904756ff59a6ab173dc074da",
"assets/packages/wheel_spin/assets/wheel.png": "f7070ab6547184ac9bf43d4a7a088b7f",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "aaadf04d346e6dc6260591e851c96650",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "03b4b7f0f8c713aabf334b39df4b4255",
"/": "03b4b7f0f8c713aabf334b39df4b4255",
"main.dart.js": "0122d74952792db3bf2c7da6e6a09798",
"manifest.json": "dcffe82492f5b076544b007526aa25ce",
"version.json": "81936a38d03fa338f487279e398b0c03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
