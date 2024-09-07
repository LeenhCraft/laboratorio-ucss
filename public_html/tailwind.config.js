/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["../app/resources/views/**/*.php", "js/**/*.js"],
  theme: {
    extend: {
      fontFamily: {
        montserrat: ["Montserrat", "sans-serif"],
      },
      colors: {
        claro: "#f8f9fd",
        primary: {
          DEFAULT: "#00bd56",
          50: "#eefff4",
          100: "#d7ffe8",
          200: "#b2ffd4",
          300: "#76ffb3",
          400: "#33f58b",
          500: "#09de69",
          600: "#00bd56",
          700: "#049145",
          800: "#0a713a",
          900: "#0a5d32",
          950: "#003419",
        },
        secondary: {
          DEFAULT: "#0093ff",
          50: "#ecfbff",
          100: "#d4f4ff",
          200: "#b2edff",
          300: "#7de4ff",
          400: "#40d1ff",
          500: "#14b3ff",
          600: "#0093ff",
          700: "#007bff",
          800: "#0062cc",
          900: "#0854a0",
          950: "#0a3361",
        },
      },
      // max-w-screen-2lg: "1440px",
      fontSize: {
        "15px": "15px",
      },
      width: {
        "custom-nav": "1140px",
        "screen-2lg": "1440px",
      },
      maxWidth: {
        "custom-nav": "1140px",
        "screen-2lg": "1440px",
      },
    },
    plugins: [],
  },
  important: true,
};
