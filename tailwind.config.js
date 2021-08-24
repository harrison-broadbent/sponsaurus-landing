const colors = require("tailwindcss/colors");
module.exports = {
  mode: "jit",
  purge: [
    "./source/*.html.erb",
    "./source/*.html",
    "./source/partials/*.html.erb",
    "./source/partials/*.html",
    "./source/partials/**/*.html.erb",
    "./source/partials/**/*.html",
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        "app-yellow": colors.yellow["400"],
        // "blueGray": colors.blueGray,
        // "warmGray": colors.warmGray
      },
      fontFamily: {
        sans: ["Inter var"],
      },
      animation: {
        "pulse-slow": "pulse 15s cubic-bezier(0.4, 0, 0.6, 1) infinite",
        "spin-slow": "spin 3s linear infinite",
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [require("@tailwindcss/forms"), require("@tailwindcss/typography")],
};
