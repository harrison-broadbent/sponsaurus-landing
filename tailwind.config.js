const colors = require("tailwindcss/colors");
module.exports = {
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
    },
  },
  variants: {
    extend: {},
  },
  plugins: [require("@tailwindcss/forms"), require("@tailwindcss/typography")],
};
