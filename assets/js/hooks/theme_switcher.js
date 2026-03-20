/**
 * ThemeSwitcher hook — manages color preset, border-radius, and dark/light mode.
 *
 * Pure client-side. Reads/writes localStorage, applies CSS vars on <html>.
 * Mounted on a container element; uses click delegation for buttons and
 * input events for the radius slider.
 */

const STORAGE_KEY = "phx-shadcn-theme-config"
const COMPAT_KEY = "phx-shadcn-theme" // backward compat with root.html.heex

// Color presets — each defines light + dark CSS variable overrides.
// Start with zinc only (current app.css values). Add more incrementally.
const PRESETS = {
  zinc: {
    label: "Zinc",
    swatch: { light: "oklch(0.145 0 0)", dark: "oklch(0.985 0 0)" },
    light: {},  // zinc is the default in app.css, no overrides needed
    dark: {},
  },
  slate: {
    label: "Slate",
    swatch: { light: "oklch(0.129 0.042 264.695)", dark: "oklch(0.929 0.013 255.508)" },
    light: {
      "--primary": "oklch(0.208 0.042 265.755)",
      "--primary-foreground": "oklch(0.984 0.003 247.858)",
      "--secondary": "oklch(0.968 0.007 247.896)",
      "--secondary-foreground": "oklch(0.208 0.042 265.755)",
      "--muted": "oklch(0.968 0.007 247.896)",
      "--muted-foreground": "oklch(0.554 0.023 257.417)",
      "--accent": "oklch(0.968 0.007 247.896)",
      "--accent-foreground": "oklch(0.208 0.042 265.755)",
      "--ring": "oklch(0.708 0.02 261.325)",
    },
    dark: {
      "--primary": "oklch(0.929 0.013 255.508)",
      "--primary-foreground": "oklch(0.208 0.042 265.755)",
      "--secondary": "oklch(0.279 0.041 260.031)",
      "--secondary-foreground": "oklch(0.984 0.003 247.858)",
      "--muted": "oklch(0.279 0.041 260.031)",
      "--muted-foreground": "oklch(0.708 0.02 261.325)",
      "--accent": "oklch(0.371 0.044 257.281)",
      "--accent-foreground": "oklch(0.984 0.003 247.858)",
      "--ring": "oklch(0.554 0.023 257.417)",
    },
  },
  rose: {
    label: "Rose",
    swatch: { light: "oklch(0.586 0.254 17.585)", dark: "oklch(0.586 0.254 17.585)" },
    light: {
      "--primary": "oklch(0.586 0.254 17.585)",
      "--primary-foreground": "oklch(0.98 0.02 17)",
      "--ring": "oklch(0.586 0.254 17.585)",
    },
    dark: {
      "--primary": "oklch(0.586 0.254 17.585)",
      "--primary-foreground": "oklch(0.98 0.02 17)",
      "--ring": "oklch(0.586 0.254 17.585)",
    },
  },
  blue: {
    label: "Blue",
    swatch: { light: "oklch(0.546 0.245 262.881)", dark: "oklch(0.546 0.245 262.881)" },
    light: {
      "--primary": "oklch(0.546 0.245 262.881)",
      "--primary-foreground": "oklch(0.98 0.01 260)",
      "--ring": "oklch(0.546 0.245 262.881)",
    },
    dark: {
      "--primary": "oklch(0.546 0.245 262.881)",
      "--primary-foreground": "oklch(0.98 0.01 260)",
      "--ring": "oklch(0.546 0.245 262.881)",
    },
  },
  green: {
    label: "Green",
    swatch: { light: "oklch(0.596 0.145 163.225)", dark: "oklch(0.596 0.145 163.225)" },
    light: {
      "--primary": "oklch(0.596 0.145 163.225)",
      "--primary-foreground": "oklch(0.98 0.02 163)",
      "--ring": "oklch(0.596 0.145 163.225)",
    },
    dark: {
      "--primary": "oklch(0.596 0.145 163.225)",
      "--primary-foreground": "oklch(0.98 0.02 163)",
      "--ring": "oklch(0.596 0.145 163.225)",
    },
  },
  violet: {
    label: "Violet",
    swatch: { light: "oklch(0.541 0.281 293.009)", dark: "oklch(0.541 0.281 293.009)" },
    light: {
      "--primary": "oklch(0.541 0.281 293.009)",
      "--primary-foreground": "oklch(0.98 0.02 293)",
      "--ring": "oklch(0.541 0.281 293.009)",
    },
    dark: {
      "--primary": "oklch(0.541 0.281 293.009)",
      "--primary-foreground": "oklch(0.98 0.02 293)",
      "--ring": "oklch(0.541 0.281 293.009)",
    },
  },
}

const DEFAULT_CONFIG = { preset: "zinc", mode: "light", radius: 0.625 }

function loadConfig() {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) return { ...DEFAULT_CONFIG, ...JSON.parse(raw) }
  } catch (_) {}
  return { ...DEFAULT_CONFIG }
}

function saveConfig(config) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(config))
  // backward compat key used by root.html.heex inline script
  localStorage.setItem(COMPAT_KEY, config.mode)
}

function applyConfig(config) {
  const html = document.documentElement

  // Mode
  if (config.mode === "dark") {
    html.classList.add("dark")
  } else {
    html.classList.remove("dark")
  }

  // Radius
  html.style.setProperty("--radius", `${config.radius}rem`)

  // Color preset — clear previous inline overrides, then apply new ones
  const preset = PRESETS[config.preset]
  if (!preset) return

  // Collect all var names from all presets to clear
  const allVarNames = new Set()
  for (const p of Object.values(PRESETS)) {
    for (const key of Object.keys(p.light)) allVarNames.add(key)
    for (const key of Object.keys(p.dark)) allVarNames.add(key)
  }
  for (const name of allVarNames) {
    html.style.removeProperty(name)
  }

  // Apply current preset's vars for the active mode
  const vars = config.mode === "dark" ? preset.dark : preset.light
  for (const [name, value] of Object.entries(vars)) {
    html.style.setProperty(name, value)
  }
}

const ThemeSwitcher = {
  mounted() {
    this._config = loadConfig()
    applyConfig(this._config)
    this._syncUI()

    // Click delegation for preset and mode buttons
    this.el.addEventListener("click", (e) => {
      const presetBtn = e.target.closest("[data-preset]")
      if (presetBtn) {
        this._config.preset = presetBtn.dataset.preset
        saveConfig(this._config)
        applyConfig(this._config)
        this._syncUI()
        return
      }

      const modeBtn = e.target.closest("[data-mode]")
      if (modeBtn) {
        this._config.mode = modeBtn.dataset.mode
        saveConfig(this._config)
        applyConfig(this._config)
        this._syncUI()
        return
      }
    })

    // Range input for radius
    const radiusInput = this.el.querySelector("[data-radius-input]")
    if (radiusInput) {
      radiusInput.value = this._config.radius
      radiusInput.addEventListener("input", (e) => {
        this._config.radius = parseFloat(e.target.value)
        saveConfig(this._config)
        applyConfig(this._config)
        this._syncRadiusLabel()
      })
    }
  },

  _syncUI() {
    // Highlight active preset
    this.el.querySelectorAll("[data-preset]").forEach((btn) => {
      const isActive = btn.dataset.preset === this._config.preset
      btn.setAttribute("data-active", isActive ? "true" : "false")
    })

    // Highlight active mode
    this.el.querySelectorAll("[data-mode]").forEach((btn) => {
      const isActive = btn.dataset.mode === this._config.mode
      btn.setAttribute("data-active", isActive ? "true" : "false")
    })

    // Sync radius slider + label
    const radiusInput = this.el.querySelector("[data-radius-input]")
    if (radiusInput) radiusInput.value = this._config.radius

    this._syncRadiusLabel()
  },

  _syncRadiusLabel() {
    const label = this.el.querySelector("[data-radius-label]")
    if (label) label.textContent = `${this._config.radius.toFixed(2)}rem`
  },
}

export { ThemeSwitcher, PRESETS }
