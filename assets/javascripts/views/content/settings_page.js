// TODO: This file was created by bulk-decaffeinate.
// Sanity-check the conversion and remove this comment.
/*
 * decaffeinate suggestions:
 * DS002: Fix invalid constructor
 * DS101: Remove unnecessary use of Array.from
 * DS102: Remove unnecessary code created because of implicit returns
 * DS205: Consider reworking code to avoid use of IIFEs
 * DS206: Consider reworking classes to avoid initClass
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/main/docs/suggestions.md
 */
app.views.SettingsPage = class SettingsPage extends app.View {
  constructor(...args) {
    this.onChange = this.onChange.bind(this);
    this.onClick = this.onClick.bind(this);
    super(...args);
  }

  static initClass() {
    this.className = "_static";

    this.events = {
      click: "onClick",
      change: "onChange",
    };
  }

  render() {
    this.html(this.tmpl("settingsPage", this.currentSettings()));
  }

  currentSettings() {
    const settings = {};
    settings.theme = app.settings.get("theme");
    settings.smoothScroll = !app.settings.get("fastScroll");
    settings.arrowScroll = app.settings.get("arrowScroll");
    settings.noAutofocus = app.settings.get("noAutofocus");
    settings.autoInstall = app.settings.get("autoInstall");
    settings.analyticsConsent = app.settings.get("analyticsConsent");
    settings.spaceScroll = app.settings.get("spaceScroll");
    settings.spaceTimeout = app.settings.get("spaceTimeout");
    settings.autoSupported = app.settings.autoSupported;
    for (var layout of Array.from(app.settings.LAYOUTS)) {
      settings[layout] = app.settings.hasLayout(layout);
    }
    return settings;
  }

  getTitle() {
    return "Preferences";
  }

  setTheme(value) {
    app.settings.set("theme", value);
  }

  toggleLayout(layout, enable) {
    app.settings.setLayout(layout, enable);
  }

  toggleSmoothScroll(enable) {
    app.settings.set("fastScroll", !enable);
  }

  toggleAnalyticsConsent(enable) {
    app.settings.set("analyticsConsent", enable ? "1" : "0");
    if (!enable) {
      resetAnalytics();
    }
  }

  toggleSpaceScroll(enable) {
    app.settings.set("spaceScroll", enable ? 1 : 0);
  }

  setScrollTimeout(value) {
    return app.settings.set("spaceTimeout", value);
  }

  toggle(name, enable) {
    app.settings.set(name, enable);
  }

  export() {
    const data = new Blob([JSON.stringify(app.settings.export())], {
      type: "application/json",
    });
    const link = document.createElement("a");
    link.href = URL.createObjectURL(data);
    link.download = "devdocs.json";
    link.style.display = "none";
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  }

  import(file, input) {
    if (!file || file.type !== "application/json") {
      new app.views.Notif("ImportInvalid", { autoHide: false });
      return;
    }

    const reader = new FileReader();
    reader.onloadend = function () {
      const data = (() => {
        try {
          return JSON.parse(reader.result);
        } catch (error) {}
      })();
      if (!data || data.constructor !== Object) {
        new app.views.Notif("ImportInvalid", { autoHide: false });
        return;
      }
      app.settings.import(data);
      $.trigger(input.form, "import");
    };
    reader.readAsText(file);
  }

  onChange(event) {
    const input = event.target;
    switch (input.name) {
      case "theme":
        this.setTheme(input.value);
        break;
      case "layout":
        this.toggleLayout(input.value, input.checked);
        break;
      case "smoothScroll":
        this.toggleSmoothScroll(input.checked);
        break;
      case "import":
        this.import(input.files[0], input);
        break;
      case "analyticsConsent":
        this.toggleAnalyticsConsent(input.checked);
        break;
      case "spaceScroll":
        this.toggleSpaceScroll(input.checked);
        break;
      case "spaceTimeout":
        this.setScrollTimeout(input.value);
        break;
      default:
        this.toggle(input.name, input.checked);
    }
  }

  onClick(event) {
    const target = $.eventTarget(event);
    switch (target.getAttribute("data-action")) {
      case "export":
        $.stopEvent(event);
        this.export();
        break;
    }
  }

  onRoute(context) {
    this.render();
  }
};
app.views.SettingsPage.initClass();
