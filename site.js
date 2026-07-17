(function () {
  const games = Array.isArray(window.GAME_DATA) ? window.GAME_DATA.slice() : [];
  const siteName = "DriveMads";
  const siteUrl = "https://drivemads.online/";
  const analyticsId = "G-ZME7DCP4MK";
  const adsClient = "ca-pub-3376278485410551";
  const consentStorageKey = "drivemads-consent-v1";
  const indexableSlugs = new Set([
    "drive-mad",
    "escape-road-city-2",
    "slope-rider",
    "slope-rider-3d",
    "snow-road",
    "2048",
    "tetris",
    "trap-the-cat",
    "sugar-sugar",
    "stickman-hook",
    "stickman-war",
    "dude-theft-auto",
    "astro-tycoon",
    "wacky-nursery"
  ]);
  const isFileProtocol = window.location.protocol === "file:";
  let analyticsLoaded = false;
  let adsLoaded = false;

  function byId(id) {
    return document.getElementById(id);
  }

  function escapeHtml(value) {
    return String(value)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#39;");
  }

  function hrefFor(slug) {
    return (
      "games/" +
      encodeURIComponent(slug) +
      (isFileProtocol ? "/index.html" : "/")
    );
  }

  function sameHostLabel(url) {
    try {
      return new URL(url).hostname.replace(/^www\./, "");
    } catch (error) {
      return "external source";
    }
  }

  function tipsFor(category) {
    const map = {
      Puzzle: [
        "Read the full board before your first move, especially if the game punishes one bad merge or draw.",
        "Reset quickly when the layout collapses instead of trying to rescue a dead position for too long.",
        "Treat repeat runs as pattern practice, not as a single all-or-nothing attempt."
      ],
      Arcade: [
        "Use the first minute to learn speed changes and spacing instead of chasing a perfect score instantly.",
        "Smaller corrections usually last longer than hard left-right panic moves.",
        "If the game looks random at first, slow down and find the rhythm before you force riskier runs."
      ],
      Driving: [
        "Most driving pages here reward balance and landing control more than raw speed.",
        "Use short throttle inputs before ramps or sudden terrain shifts so the vehicle stays level.",
        "If a section keeps failing, replay it with less speed first and rebuild confidence from there."
      ],
      Action: [
        "Look for the first safe opening before you rush into enemies, traffic, or hazards.",
        "Most failed runs come from overcommitting after a good moment instead of resetting position.",
        "Use each retry to memorize where pressure starts rather than repeating the same blind route."
      ],
      Strategy: [
        "Do not spend your first big resource too early if the game still hides key information.",
        "An efficient slow start is usually better than a flashy opener that leaves no recovery path.",
        "When a run fails, identify the one decision that caused it and change that first."
      ],
      Adventure: [
        "Use the opening route to learn layout and pacing before trying to speed through it.",
        "Watch where the game transitions from exploration into timing-heavy sections.",
        "Repeat attempts are most useful when you clean up one navigation mistake at a time."
      ]
    };

    return map[category] || map.Arcade;
  }

  function renderGameCard(game) {
    return (
      '<a class="game-card" href="' +
      hrefFor(game.slug) +
      '">' +
      '<img src="' +
      escapeHtml(game.thumbnail) +
      '" alt="' +
      escapeHtml(game.title) +
      ' thumbnail" loading="lazy" decoding="async" />' +
      '<div class="card-body">' +
      '<div class="card-copy">' +
      "<h3>" +
      escapeHtml(game.title) +
      "</h3>" +
      "<p>" +
      escapeHtml(game.category) +
      "</p>" +
      "</div>" +
      '<span class="card-tag">' +
      escapeHtml(game.tag) +
      "</span>" +
      "</div>" +
      "</a>"
    );
  }

  function renderShowcaseCard(game, large) {
    if (large) {
      return (
        '<a class="showcase-card showcase-card-large" href="' +
        hrefFor(game.slug) +
        '">' +
        '<img src="' +
        escapeHtml(game.thumbnail) +
        '" alt="' +
        escapeHtml(game.title) +
        ' cover" loading="eager" decoding="async" />' +
        '<div class="showcase-overlay">' +
        '<span class="showcase-kicker">Featured game</span>' +
        "<h2>" +
        escapeHtml(game.title) +
        "</h2>" +
        "<p>" +
        escapeHtml(game.summary) +
        "</p>" +
        "</div>" +
        "</a>"
      );
    }

    return (
      '<a class="showcase-card" href="' +
      hrefFor(game.slug) +
      '">' +
      '<img src="' +
      escapeHtml(game.thumbnail) +
      '" alt="' +
      escapeHtml(game.title) +
      ' cover" loading="lazy" decoding="async" />' +
      '<div class="showcase-mini-title">' +
      "<h3>" +
      escapeHtml(game.title) +
      "</h3>" +
      "<span>" +
      escapeHtml(game.tag) +
      "</span>" +
      "</div>" +
      "</a>"
    );
  }

  function renderMetaPanel(game, buttonHref, buttonText) {
    return (
      "<h2>" +
      escapeHtml(game.title) +
      " overview" +
      "</h2>" +
      "<p>" +
      escapeHtml(game.summary) +
      "</p>" +
      '<div class="meta-list">' +
      '<div class="meta-item"><span>Category</span><strong>' +
      escapeHtml(game.category) +
      "</strong></div>" +
      '<div class="meta-item"><span>Tag</span><strong>' +
      escapeHtml(game.tag) +
      "</strong></div>" +
      '<div class="meta-item"><span>Source</span><strong>' +
      escapeHtml(sameHostLabel(game.embedUrl)) +
      "</strong></div>" +
      '<div class="meta-item"><span>Play Mode</span><strong>Browser / Mobile</strong></div>' +
      "</div>" +
      '<div class="list-card">' +
      "<h3>Quick play notes</h3>" +
      "<ul>" +
      tipsFor(game.category)
        .map(function (tip) {
          return "<li>" + escapeHtml(tip) + "</li>";
        })
        .join("") +
      "</ul>" +
      "</div>" +
      '<div class="hero-actions">' +
      '<a class="button" href="' +
      escapeHtml(buttonHref) +
      '">' +
      escapeHtml(buttonText) +
      "</a>" +
      '<a class="button-secondary" href="index.html#all-games">Browse library</a>' +
      "</div>"
    );
  }

  function renderHome() {
    if (!games.length) {
      return;
    }

    const featured = games.find(function (game) {
      return game.featured;
    }) || games[0];
    const curatedGames = games.filter(function (game) {
      return game.slug === featured.slug || indexableSlugs.has(game.slug);
    });
    const homeSupportGames = curatedGames.filter(function (game) {
      return game.slug !== featured.slug;
    });
    const wall = byId("showcase-wall");
    const grid = byId("all-games-grid");
    const iframe = byId("featured-iframe");
    const side = byId("featured-side");
    const heroFeatureCard = byId("showcase-feature-card");
    const heroButton = byId("hero-featured-button");
    const catalogStats = byId("catalog-stats");
    const showcaseGames = [featured].concat(homeSupportGames.slice(0, 12));

    if (wall) {
      wall.innerHTML = showcaseGames
        .map(function (game, index) {
          return renderShowcaseCard(game, index === 0);
        })
        .join("");
    }

    if (grid) {
      grid.innerHTML = homeSupportGames.map(renderGameCard).join("");
    }

    if (iframe) {
      iframe.src = featured.embedUrl;
      iframe.title = "Play " + featured.title + " on " + siteName;
    }

    if (heroButton) {
      heroButton.href = hrefFor(featured.slug);
      heroButton.textContent = featured.slug === "drive-mad"
        ? "Play Drive Mad"
        : "Open " + featured.title;
    }

    if (catalogStats) {
      catalogStats.textContent =
        siteName +
        " keeps " +
        homeSupportGames.length +
        " hand-picked follow-up game pages live in the main catalog instead of trying to index every embed we can find.";
    }

    if (side) {
      side.innerHTML = renderMetaPanel(
        featured,
        hrefFor(featured.slug),
        "Open game page"
      );
    }

    if (heroFeatureCard) {
      heroFeatureCard.innerHTML =
        '<div class="showcase-feature-media" style="background-image: linear-gradient(180deg, rgba(10, 132, 255, 0.08), rgba(5, 15, 32, 0.56)), url(\'' +
        escapeHtml(featured.thumbnail) +
        "')\"></div>" +
        '<div class="showcase-feature-body">' +
        '<span class="showcase-feature-label">Featured game</span>' +
        "<h2>" +
        escapeHtml(featured.title) +
        "</h2>" +
        "<p>" +
        escapeHtml(featured.summary) +
        "</p>" +
        '<div class="showcase-feature-meta">' +
        "<span>" +
        escapeHtml(featured.category) +
        "</span>" +
        "<span>" +
        escapeHtml(featured.tag) +
        "</span>" +
        "</div>" +
        '<div class="showcase-feature-actions">' +
        '<a class="button" href="' +
        hrefFor(featured.slug) +
        '">Open game</a>' +
        '<a class="button-secondary" href="#play-online">View embed</a>' +
        "</div>" +
        "</div>";
    }
  }

  function loadScriptOnce(id, src, onLoad) {
    if (document.getElementById(id)) {
      if (typeof onLoad === "function") {
        onLoad();
      }
      return;
    }

    const script = document.createElement("script");
    script.id = id;
    script.async = true;
    script.src = src;
    if (typeof onLoad === "function") {
      script.addEventListener("load", onLoad, { once: true });
    }
    document.head.appendChild(script);
  }

  function ensureGtagStub() {
    window.dataLayer = window.dataLayer || [];
    window.gtag = window.gtag || function () {
      window.dataLayer.push(arguments);
    };

    window.gtag("consent", "default", {
      ad_storage: "denied",
      ad_user_data: "denied",
      ad_personalization: "denied",
      analytics_storage: "denied",
      functionality_storage: "granted",
      personalization_storage: "denied",
      security_storage: "granted",
      wait_for_update: 500
    });
  }

  function loadAnalytics() {
    if (analyticsLoaded) {
      return;
    }

    analyticsLoaded = true;
    loadScriptOnce(
      "ga-script",
      "https://www.googletagmanager.com/gtag/js?id=" + encodeURIComponent(analyticsId),
      function () {
        window.gtag("js", new Date());
        window.gtag("config", analyticsId, {
          anonymize_ip: true,
          transport_type: "beacon"
        });
      }
    );
  }

  function loadAds() {
    if (adsLoaded) {
      return;
    }

    adsLoaded = true;
    loadScriptOnce(
      "adsense-script",
      "https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=" + encodeURIComponent(adsClient)
    );
  }

  function readConsent() {
    try {
      const raw = window.localStorage.getItem(consentStorageKey);
      if (!raw) {
        return null;
      }

      const parsed = JSON.parse(raw);
      if (
        typeof parsed !== "object" ||
        parsed === null ||
        typeof parsed.analytics !== "boolean" ||
        typeof parsed.ads !== "boolean"
      ) {
        return null;
      }

      return parsed;
    } catch (error) {
      return null;
    }
  }

  function saveConsent(consent) {
    try {
      window.localStorage.setItem(consentStorageKey, JSON.stringify(consent));
    } catch (error) {
      return;
    }
  }

  function applyConsent(consent) {
    ensureGtagStub();

    window.gtag("consent", "update", {
      ad_storage: consent.ads ? "granted" : "denied",
      ad_user_data: consent.ads ? "granted" : "denied",
      ad_personalization: consent.ads ? "granted" : "denied",
      analytics_storage: consent.analytics ? "granted" : "denied",
      functionality_storage: "granted",
      personalization_storage: consent.ads ? "granted" : "denied",
      security_storage: "granted"
    });

    if (consent.analytics) {
      loadAnalytics();
    }

    if (consent.ads) {
      loadAds();
    }
  }

  function buildConsentBanner() {
    if (!document.body) {
      return null;
    }

    const wrapper = document.createElement("div");
    wrapper.className = "consent-banner";
    wrapper.hidden = true;
    wrapper.innerHTML =
      '<div class="consent-card" role="dialog" aria-modal="true" aria-labelledby="consent-title">' +
      '<p class="consent-eyebrow">Privacy controls</p>' +
      '<h2 id="consent-title">Choose how DriveMads uses cookies</h2>' +
      '<p class="consent-copy">Optional cookies on this site power Google Analytics, Google AdSense, and third-party game embeds. Rejecting optional storage keeps the site playable, but ads and measurement stay off until you change that choice.</p>' +
      '<div class="consent-actions">' +
      '<button class="button" type="button" data-consent-accept>Accept ads and analytics</button>' +
      '<button class="button-secondary" type="button" data-consent-reject>Reject optional cookies</button>' +
      '<button class="button-secondary" type="button" data-consent-manage>Manage choices</button>' +
      "</div>" +
      '<div class="consent-prefs" data-consent-prefs hidden>' +
      '<label class="consent-toggle">' +
      '<span>Analytics storage</span>' +
      '<input type="checkbox" data-consent-analytics />' +
      "</label>" +
      '<p class="consent-note">Enables Google Analytics for page views, engagement trends, and catalog maintenance decisions.</p>' +
      '<label class="consent-toggle">' +
      '<span>Advertising storage</span>' +
      '<input type="checkbox" data-consent-ads />' +
      "</label>" +
      '<p class="consent-note">Enables Google AdSense and related ad-measurement or ad-personalization signals.</p>' +
      '<div class="consent-actions">' +
      '<button class="button" type="button" data-consent-save>Save choices</button>' +
      '<button class="button-secondary" type="button" data-consent-cancel>Close</button>' +
      "</div>" +
      "</div>" +
      '<p class="consent-footnote">Your selection is stored in this browser. You can reopen these settings anytime from the footer or the privacy policy page.</p>' +
      "</div>";
    document.body.appendChild(wrapper);
    return wrapper;
  }

  function setupConsentManager() {
    ensureGtagStub();

    const banner = buildConsentBanner();
    if (!banner) {
      return;
    }

    const prefsPanel = banner.querySelector("[data-consent-prefs]");
    const analyticsInput = banner.querySelector("[data-consent-analytics]");
    const adsInput = banner.querySelector("[data-consent-ads]");
    const acceptButton = banner.querySelector("[data-consent-accept]");
    const rejectButton = banner.querySelector("[data-consent-reject]");
    const manageButton = banner.querySelector("[data-consent-manage]");
    const saveButton = banner.querySelector("[data-consent-save]");
    const cancelButton = banner.querySelector("[data-consent-cancel]");
    const openers = document.querySelectorAll("[data-open-consent]");
    let savedConsent = readConsent();

    function showBanner(showPreferences) {
      banner.hidden = false;
      prefsPanel.hidden = !showPreferences;
      if (savedConsent) {
        analyticsInput.checked = savedConsent.analytics;
        adsInput.checked = savedConsent.ads;
      }
    }

    function hideBanner() {
      banner.hidden = true;
      prefsPanel.hidden = true;
    }

    function commit(consent) {
      savedConsent = {
        analytics: Boolean(consent.analytics),
        ads: Boolean(consent.ads),
        updatedAt: new Date().toISOString()
      };
      saveConsent(savedConsent);
      applyConsent(savedConsent);
      hideBanner();
    }

    if (savedConsent) {
      applyConsent(savedConsent);
    } else {
      showBanner(false);
    }

    acceptButton.addEventListener("click", function () {
      commit({ analytics: true, ads: true });
    });

    rejectButton.addEventListener("click", function () {
      commit({ analytics: false, ads: false });
    });

    manageButton.addEventListener("click", function () {
      analyticsInput.checked = savedConsent ? savedConsent.analytics : false;
      adsInput.checked = savedConsent ? savedConsent.ads : false;
      showBanner(true);
    });

    saveButton.addEventListener("click", function () {
      commit({
        analytics: analyticsInput.checked,
        ads: adsInput.checked
      });
    });

    cancelButton.addEventListener("click", function () {
      if (savedConsent) {
        hideBanner();
        return;
      }

      showBanner(false);
    });

    openers.forEach(function (opener) {
      opener.addEventListener("click", function () {
        analyticsInput.checked = savedConsent ? savedConsent.analytics : false;
        adsInput.checked = savedConsent ? savedConsent.ads : false;
        showBanner(true);
      });
    });
  }

  function bindCopyButtons() {
    const copyButtons = document.querySelectorAll("[data-copy-target]");

    copyButtons.forEach(function (button) {
      button.addEventListener("click", async function () {
        const value = button.getAttribute("data-copy-target") || "";
        const original = button.textContent;

        try {
          if (navigator.clipboard && navigator.clipboard.writeText) {
            await navigator.clipboard.writeText(value);
          } else {
            const temp = document.createElement("textarea");
            temp.value = value;
            temp.setAttribute("readonly", "");
            temp.style.position = "absolute";
            temp.style.left = "-9999px";
            document.body.appendChild(temp);
            temp.select();
            document.execCommand("copy");
            temp.remove();
          }

          button.textContent = "Copied";
        } catch (error) {
          button.textContent = "Copy failed";
        }

        window.setTimeout(function () {
          button.textContent = original;
        }, 1400);
      });
    });
  }

  bindCopyButtons();
  setupConsentManager();

  if (document.body && document.body.dataset.page === "home") {
    renderHome();
  }

  if (document.title && games.length && document.body && document.body.dataset.page === "home") {
    const featured = games.find(function (game) {
      return game.featured;
    }) || games[0];
    const imageMeta = document.querySelector('meta[property="og:image"]');
    const urlMeta = document.querySelector('meta[property="og:url"]');
    const siteMeta = document.querySelector('meta[name="twitter:title"]');

    if (imageMeta) {
      imageMeta.setAttribute("content", siteUrl + featured.thumbnail);
    }

    if (urlMeta) {
      urlMeta.setAttribute("content", siteUrl);
    }

    if (siteMeta) {
      siteMeta.setAttribute("content", document.title);
    }
  }
})();
