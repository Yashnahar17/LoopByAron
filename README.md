# 📚 The Loop Trilogy — React Website

A production-ready React application recreating the Loop Trilogy book series website.

## Tech Stack
- ⚡ **Vite** — lightning fast dev server
- ⚛️ **React 18** — functional components throughout
- 🎨 **Tailwind CSS** — utility-first styling
- 🎞️ **Framer Motion** — smooth animations & page transitions
- 🎯 **Lucide React** — crisp icon set

## Project Structure
```
src/
├── components/          # Reusable UI components
│   ├── Navbar.jsx       # Fixed navbar with dropdown & mobile menu
│   ├── Footer.jsx       # 4-column footer
│   ├── FadeIn.jsx       # Scroll-reveal animation wrapper
│   ├── StarRating.jsx   # Interactive/read-only star rating
│   ├── ImageCarousel.jsx# Auto-sliding image carousel with dots
│   ├── SalesStats.jsx   # 3-card stats section (reusable)
│   ├── ReviewForm.jsx   # Validated review submission form
│   └── Newsletter.jsx   # Email subscribe (full banner & card variants)
├── pages/               # Page-level components
│   ├── HomePage.jsx     # Hero + About + Books + Stats + Reviews + Form
│   ├── AboutPage.jsx    # Dr. Jonathan Pierce bio + Writing Philosophy
│   ├── BookPage.jsx     # Dynamic book detail (all 3 books)
│   └── ContactPage.jsx  # Contact form with info cards
├── data/
│   └── content.js       # All site content in one place
├── App.jsx              # Client-side router (state-based)
├── main.jsx             # Entry point
└── index.css            # Tailwind + global component classes
```

## Pages
| Page | Route Key |
|------|-----------|
| Home | `home` |
| About Author | `about` |
| Part I: The Loop | `part-one` |
| Part II: Within The Loop | `part-two` |
| Part III: Beyond The Loop | `part-three` |
| Contact | `contact` |

## Getting Started

```bash
# 1. Install dependencies
npm install

# 2. Start dev server
npm run dev

# 3. Open http://localhost:5173
```

## Build for Production
```bash
npm run build
npm run preview
```

## Design Features
- ✅ Pixel-accurate recreation of the original Emergent AI design
- ✅ Responsive: mobile, tablet, desktop
- ✅ Animated page transitions
- ✅ Scroll-reveal animations on all sections
- ✅ Hover effects on cards and buttons
- ✅ Image carousel with dot navigation
- ✅ Form validation with error states
- ✅ Success states for all forms
- ✅ Sticky navbar with scroll shadow
- ✅ Dropdown nav with mobile hamburger menu

## Improvements Over Original
1. **Page transitions** — smooth fade when navigating between pages
2. **Form validation** — real-time error highlighting
3. **Success states** — confirmation screens after form submission
4. **Accessibility** — semantic HTML, aria-labels, keyboard navigation
5. **Performance** — lazy image loading, optimised animations
6. **Content centralised** — all copy lives in `data/content.js` for easy editing
