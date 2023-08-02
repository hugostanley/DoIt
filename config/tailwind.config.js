const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'gpt-background-gray': '#F7FAFC',
        'gpt-blue-dark': '#2D3748',
        'gpt-secondary-orange': '#FFA500',
        'gpt-accent-green': '#48BB78',
        'gpt-accent-gray': '#4A5568',
        'primaryDark': "#131d25",
        'secondaryDark': "#555373",
        'primaryLight': "#030027",
        'secondaryLight': "#555373",
        'primaryGreen': "#c8fcea",
        'primaryGray': "#1E293B",
        'primary-gray': '#EAE9E6',
        'primary-blue': '#455d7a',
        'secondary-white': '#f2f2f2',
        'accent-orange': '#f08a4b'
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};
