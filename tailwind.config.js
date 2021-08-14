const colors = require("tailwindcss/colors");
module.exports = {
  purge: [],
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
