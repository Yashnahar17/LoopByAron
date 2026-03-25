#!/usr/bin/env bash
set -e

echo "🚀 Setting up The Loop Trilogy — React + Vite + Tailwind + Framer Motion"

# ─── 1. PROJECT ROOT ──────────────────────────────────────────────────────────
mkdir -p loop-trilogy
cd loop-trilogy

# ─── 2. PACKAGE.JSON ─────────────────────────────────────────────────────────
cat > package.json << 'PKGJSON'
{
  "name": "loop-trilogy",
  "private": true,
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "framer-motion": "^11.3.0",
    "lucide-react": "^0.400.0"
  },
  "devDependencies": {
    "@vitejs/plugin-react": "^4.3.1",
    "autoprefixer": "^10.4.19",
    "postcss": "^8.4.40",
    "tailwindcss": "^3.4.7",
    "vite": "^5.3.4"
  }
}
PKGJSON

# ─── 3. CONFIG FILES ──────────────────────────────────────────────────────────
cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
export default defineConfig({ plugins: [react()] })
EOF

cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,jsx}'],
  theme: {
    extend: {
      colors: {
        teal: {
          50: '#f0fdfa', 100: '#ccfbf1', 200: '#99f6e4',
          300: '#5eead4', 400: '#2dd4bf', 500: '#14b8a6',
          600: '#0d9488', 700: '#0f766e', 800: '#115e59', 900: '#134e4a',
        },
      },
      fontFamily: { sans: ['Inter', 'system-ui', 'sans-serif'] },
    },
  },
  plugins: [],
}
EOF

cat > postcss.config.js << 'EOF'
export default { plugins: { tailwindcss: {}, autoprefixer: {} } }
EOF

# ─── 4. INDEX.HTML ────────────────────────────────────────────────────────────
cat > index.html << 'EOF'
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="The Loop Trilogy — A psychological thriller by Aron Goves." />
    <title>The Loop Trilogy</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
EOF

# ─── 5. SRC FOLDER ────────────────────────────────────────────────────────────
mkdir -p src/components src/pages src/data

# ── index.css ──
cat > src/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
  html { scroll-behavior: smooth; }
  body {
    font-family: 'Inter', system-ui, sans-serif;
    background: #ffffff;
    color: #111827;
    -webkit-font-smoothing: antialiased;
  }
  ::selection { background: rgba(13,148,136,0.2); }
}

@layer components {
  .btn-primary {
    @apply inline-flex items-center justify-center gap-2 bg-teal-600 hover:bg-teal-700
           text-white font-semibold rounded-lg transition-all duration-200 cursor-pointer select-none;
  }
  .btn-secondary {
    @apply inline-flex items-center justify-center gap-2 bg-teal-500 hover:bg-teal-600
           text-white font-semibold rounded-lg transition-all duration-200 cursor-pointer select-none;
  }
  .btn-outline {
    @apply inline-flex items-center justify-center gap-2 border-2 border-teal-600
           text-teal-600 hover:bg-teal-600 hover:text-white font-semibold rounded-lg
           transition-all duration-200 cursor-pointer select-none;
  }
  .card {
    @apply bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden;
  }
  .input-base {
    @apply w-full border border-gray-200 rounded-lg px-4 py-3 text-gray-800
           placeholder-gray-400 text-sm focus:outline-none focus:ring-2
           focus:ring-teal-500 focus:border-transparent transition-all duration-200 bg-white;
  }
  .section-title { @apply text-3xl md:text-4xl lg:text-5xl font-bold text-gray-900; }
  .section-sub   { @apply text-gray-500 text-base md:text-lg mt-3; }
  .badge         { @apply inline-flex px-3 py-1 rounded-full text-xs font-semibold bg-teal-100 text-teal-700; }
}
EOF

# ── main.jsx ──
cat > src/main.jsx << 'EOF'
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.jsx'
createRoot(document.getElementById('root')).render(<StrictMode><App /></StrictMode>)
EOF

# ─── 6. DATA ──────────────────────────────────────────────────────────────────
cat > src/data/content.js << 'DATAEOF'
export const books = [
  {
    id: 'part-one', slug: 'part-one',
    badge: 'Book One',
    title: 'Part I: The Loop',
    tagline: 'Where Everything Begins... Again',
    shortDesc: "In a world where déjà vu is more than just a feeling, Dr. Advait discovers that his life—and possibly all of existence—is caught in an infinite loop...",
    synopsis: `The Loop is the opening instalment of The Loop Trilogy, followed by Within the Loop and Beyond the Loop.

The novel is organised into five chapters - referred to as seasons - each consisting of four parts.

Across each season, Advait - the protagonist experiences a profound and distinct transformation in character and personality, while the fundamental essence and aura of his soul remain unchanged.

The narrative is drawn entirely from the protagonist's point of view, chronicling the catastrophes he faces and the decisions he makes in their wake. These events ultimately drive him to confront the forces behind the chaos and emotional turmoil that shape his journey.`,
    coverImage: 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=800&q=80',
    carouselImages: [
      'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=800&q=80',
      'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=800&q=80',
      'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=800&q=80',
      'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800&q=80',
    ],
    sales: { total: '45,821', lastMonth: '3,214', thisMonth: '4,523' },
    readerReviews: [
      { name: 'Rachel M.', date: 'December 2025', stars: 5, text: "Absolutely mind-bending! The Loop grabbed me from page one and didn't let go. A fascinating and deeply human exploration." },
      { name: 'David K.',  date: 'November 2025', stars: 5, text: 'A philosophical masterpiece disguised as a thriller. Every chapter raises profound questions about free will and determinism.' },
      { name: 'Jennifer L.', date: 'October 2025', stars: 5, text: "Brilliant concept and execution. The characters feel real, and the mystery kept me reading late into the night. Can't wait for Part II!" },
    ],
    authorExperience: `The Loop is the opening instalment of The Loop Trilogy, followed by Within the Loop and Beyond the Loop.

This trilogy represents more than a decade of dedicated research and effort, all invested in building a world that feels authentic and relatable. While some of the ideas explored in these books may seem strikingly possible, the story remains entirely fictional, and none of the events is drawn from my personal experiences.

I hope you enjoy the book and connect with the series as a whole, immersing yourself in the world of possibilities it brings to life. If my work resonates with you, please consider sharing it—your support is the greatest appreciation an artist can receive.`,
    otherParts: ['part-two', 'part-three'],
  },
  {
    id: 'part-two', slug: 'part-two',
    badge: 'Book Two',
    title: 'Part II: Within The Loop',
    tagline: 'Understanding the Prison We Cannot See',
    shortDesc: 'Stay tuned.',
    synopsis: null,
    coverImage: 'https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=800&q=80',
    carouselImages: [
      'https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=800&q=80',
      'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?w=800&q=80',
      'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=800&q=80',
      'https://images.unsplash.com/photo-1516979187457-637abb4f9353?w=800&q=80',
    ],
    sales: null,
    readerReviews: [],
    authorExperience: null,
    otherParts: ['part-one', 'part-three'],
  },
  {
    id: 'part-three', slug: 'part-three',
    badge: 'Book Three',
    title: 'Part III: Beyond The Loop',
    tagline: 'Breaking Free or Breaking Everything',
    shortDesc: 'Stay tuned.',
    synopsis: null,
    coverImage: 'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?w=800&q=80',
    carouselImages: [
      'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?w=800&q=80',
      'https://images.unsplash.com/photo-1550399105-c4db5fb85c18?w=800&q=80',
      'https://images.unsplash.com/photo-1509266272358-7701da638078?w=800&q=80',
      'https://images.unsplash.com/photo-1519682577862-22b62b24e493?w=800&q=80',
    ],
    sales: null,
    readerReviews: [],
    authorExperience: null,
    otherParts: ['part-one', 'part-two'],
  },
]

export const getBookBySlug = (slug) => books.find((b) => b.slug === slug)

export const expertReviews = [
  { id: 1, stars: 5, text: "A masterful exploration of time and consciousness that rivals the best of Philip K. Dick. Goves' debut is nothing short of extraordinary.", author: 'Dr. Emma Richardson', source: 'The New York Times Book Review' },
  { id: 2, stars: 5, text: "The Loop Trilogy challenges everything we think we know about free will and determinism. A philosophical thriller that's impossible to put down.", author: 'James Mitchell', source: 'Scientific American' },
  { id: 3, stars: 5, text: "Goves weaves complex philosophical concepts into a gripping narrative. This is fiction at its finest—thought-provoking and utterly captivating.", author: 'Dr. Sarah Chen', source: 'Philosophy Today Magazine' },
  { id: 4, stars: 5, text: 'A triumph of imagination and intellect. The Loop Trilogy will be studied in literature courses for decades to come.', author: 'Prof. Michael Torres', source: 'The Atlantic' },
]

export const trilogySalesStats = [
  { icon: 'Award',      value: '127,543', label: 'TOTAL SALES' },
  { icon: 'Calendar',   value: '8,965',   label: 'LAST MONTH', featured: true },
  { icon: 'TrendingUp', value: '12,847',  label: 'THIS MONTH' },
]

export const reviewSummary = [
  { value: '4.9/5',   label: 'Average Rating' },
  { value: '15,000+', label: 'Reader Reviews' },
  { value: '12',      label: 'Literary Awards' },
]

export const countries = [
  'United States','United Kingdom','Canada','Australia','India',
  'Germany','France','Japan','Brazil','South Africa','China','Mexico',
  'Spain','Italy','Netherlands','Pakistan','UAE','Singapore','Other',
]

export const phoneCodes = [
  '+1 (US/CA)','+44 (UK)','+91 (IN)','+61 (AU)','+49 (DE)',
  '+33 (FR)','+81 (JP)','+55 (BR)','+27 (ZA)','+86 (CN)','+971 (UAE)',
]

export const howFoundOptions = [
  'Social Media','Friend / Family','Book Store','Online Search',
  'Book Club','Podcast','News Article','I know the artist','Other',
]

export const subjectOptions = [
  'General Enquiry','Book Purchase','Press / Media',
  'Author Appearance','Rights & Licensing','Other',
]
DATAEOF

# ─── 7. COMPONENTS ────────────────────────────────────────────────────────────

# FadeIn.jsx
cat > src/components/FadeIn.jsx << 'EOF'
import { motion } from 'framer-motion'
export default function FadeIn({ children, delay=0, duration=0.6, y=24, x=0, className='' }) {
  return (
    <motion.div
      initial={{ opacity:0, y, x }}
      whileInView={{ opacity:1, y:0, x:0 }}
      viewport={{ once:true, margin:'-60px' }}
      transition={{ duration, delay, ease:[0.22,1,0.36,1] }}
      className={className}
    >
      {children}
    </motion.div>
  )
}
EOF

# StarRating.jsx
cat > src/components/StarRating.jsx << 'EOF'
import { useState } from 'react'
import { Star } from 'lucide-react'
export default function StarRating({ value=0, onChange, readOnly=false, size=20 }) {
  const [hovered, setHovered] = useState(0)
  const display = hovered || value
  return (
    <div className="flex gap-1">
      {[1,2,3,4,5].map(s => (
        <button key={s} type="button" disabled={readOnly}
          onClick={() => !readOnly && onChange?.(s)}
          onMouseEnter={() => !readOnly && setHovered(s)}
          onMouseLeave={() => !readOnly && setHovered(0)}
          className={`transition-transform duration-100 ${!readOnly?'hover:scale-110 cursor-pointer':'cursor-default'}`}>
          <Star size={size} className={s<=display?'text-yellow-400 fill-yellow-400':'text-gray-300 fill-gray-100'} />
        </button>
      ))}
    </div>
  )
}
EOF

# ImageCarousel.jsx
cat > src/components/ImageCarousel.jsx << 'EOF'
import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
export default function ImageCarousel({ images=[] }) {
  const [current, setCurrent] = useState(0)
  if (!images.length) return null
  return (
    <div className="rounded-2xl overflow-hidden shadow-xl bg-gray-100">
      <div className="relative overflow-hidden" style={{aspectRatio:'4/3'}}>
        <AnimatePresence mode="wait">
          <motion.img key={current} src={images[current]} alt={`Slide ${current+1}`}
            initial={{opacity:0,x:30}} animate={{opacity:1,x:0}} exit={{opacity:0,x:-30}}
            transition={{duration:0.4,ease:'easeInOut'}} className="w-full h-full object-cover" />
        </AnimatePresence>
      </div>
      <div className="flex items-center gap-2 px-4 py-3 bg-white">
        {images.map((_,i) => (
          <button key={i} onClick={() => setCurrent(i)}
            className={`transition-all duration-300 rounded-full ${i===current?'w-6 h-2.5 bg-teal-600':'w-2.5 h-2.5 bg-gray-300 hover:bg-gray-400'}`}
            aria-label={`Slide ${i+1}`} />
        ))}
      </div>
    </div>
  )
}
EOF

# SalesStats.jsx
cat > src/components/SalesStats.jsx << 'EOF'
import { Award, Calendar, TrendingUp } from 'lucide-react'
import { motion } from 'framer-motion'
import FadeIn from './FadeIn'
const iconMap = { Award, Calendar, TrendingUp }
function StatCard({ icon, value, label, featured, index }) {
  const Icon = iconMap[icon] || Award
  return (
    <motion.div
      initial={{opacity:0,y:24}} whileInView={{opacity:1,y:0}}
      viewport={{once:true,margin:'-40px'}}
      transition={{duration:0.55,delay:index*0.12}}
      whileHover={{y:-2,transition:{duration:0.2}}}
      className={`p-8 rounded-2xl border transition-shadow duration-300 ${featured?'bg-white border-teal-100 shadow-xl shadow-teal-100/60 z-10 scale-[1.03]':'bg-white border-gray-100 shadow-sm hover:shadow-md'}`}>
      <div className="w-12 h-12 rounded-xl bg-teal-100 flex items-center justify-center text-teal-600 mb-4">
        <Icon size={22} />
      </div>
      <div className="text-5xl font-bold text-gray-900 tabular-nums mb-1">{value}</div>
      <div className="text-xs font-semibold text-gray-400 tracking-widest uppercase">{label}</div>
    </motion.div>
  )
}
export default function SalesStats({ title, subtitle, stats }) {
  return (
    <section className="py-20 bg-white">
      <div className="max-w-6xl mx-auto px-6">
        <FadeIn className="text-center mb-14">
          <h2 className="section-title">{title}</h2>
          {subtitle && <p className="section-sub">{subtitle}</p>}
        </FadeIn>
        <div className="grid md:grid-cols-3 gap-6 items-center">
          {stats.map((s,i) => <StatCard key={s.label} {...s} index={i} />)}
        </div>
      </div>
    </section>
  )
}
EOF

# ReviewForm.jsx
cat > src/components/ReviewForm.jsx << 'EOF'
import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { Send, CheckCircle } from 'lucide-react'
import StarRating from './StarRating'
import { countries } from '../data/content'

export default function ReviewForm({ bookTitle='the loop trilogy' }) {
  const [form, setForm] = useState({ name:'', email:'', country:'', profession:'', rating:0, review:'' })
  const [errors, setErrors] = useState({})
  const [submitted, setSubmitted] = useState(false)
  const set = key => e => setForm(f => ({ ...f, [key]: e.target ? e.target.value : e }))
  const validate = () => {
    const e = {}
    if (!form.name.trim()) e.name='Name is required'
    if (!form.email.includes('@')) e.email='Valid email required'
    if (!form.country) e.country='Please select a country'
    if (!form.rating) e.rating='Please give a rating'
    if (!form.review.trim()) e.review='Please write a review'
    return e
  }
  const handleSubmit = () => {
    const errs = validate()
    if (Object.keys(errs).length) { setErrors(errs); return }
    setErrors({}); setSubmitted(true)
  }
  return (
    <section className="py-20 bg-white">
      <div className="max-w-3xl mx-auto px-6">
        <div className="text-center mb-12">
          <h2 className="section-title">Share Your Review</h2>
          <p className="section-sub">Help others discover {bookTitle} by sharing your experience</p>
        </div>
        <AnimatePresence mode="wait">
          {submitted ? (
            <motion.div key="ok" initial={{opacity:0,scale:0.95}} animate={{opacity:1,scale:1}} className="text-center py-16">
              <div className="w-20 h-20 rounded-full bg-teal-100 flex items-center justify-center mx-auto mb-6">
                <CheckCircle size={36} className="text-teal-600" />
              </div>
              <h3 className="text-2xl font-bold text-gray-900 mb-2">Thank you!</h3>
              <p className="text-gray-500 text-lg">Your review has been submitted successfully.</p>
              <button onClick={() => { setSubmitted(false); setForm({name:'',email:'',country:'',profession:'',rating:0,review:''}) }} className="mt-8 btn-outline px-6 py-2.5">Write Another Review</button>
            </motion.div>
          ) : (
            <motion.div key="form" initial={{opacity:0}} animate={{opacity:1}}>
              <div className="card p-8 space-y-6">
                <div className="grid md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-semibold text-gray-700 mb-1.5">Your Name <span className="text-red-400">*</span></label>
                    <input type="text" placeholder="John Doe" value={form.name} onChange={set('name')} className={`input-base ${errors.name?'border-red-300 ring-1 ring-red-200':''}`} />
                    {errors.name && <p className="text-red-400 text-xs mt-1">{errors.name}</p>}
                  </div>
                  <div>
                    <label className="block text-sm font-semibold text-gray-700 mb-1.5">Email Address <span className="text-red-400">*</span></label>
                    <input type="email" placeholder="john@example.com" value={form.email} onChange={set('email')} className={`input-base ${errors.email?'border-red-300 ring-1 ring-red-200':''}`} />
                    {errors.email && <p className="text-red-400 text-xs mt-1">{errors.email}</p>}
                  </div>
                </div>
                <div className="grid md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-semibold text-gray-700 mb-1.5">Country <span className="text-red-400">*</span></label>
                    <select value={form.country} onChange={set('country')} className={`input-base appearance-none cursor-pointer ${errors.country?'border-red-300':''}`}>
                      <option value="">Select your country</option>
                      {countries.map(c => <option key={c}>{c}</option>)}
                    </select>
                    {errors.country && <p className="text-red-400 text-xs mt-1">{errors.country}</p>}
                  </div>
                  <div>
                    <label className="block text-sm font-semibold text-gray-700 mb-1.5">Profession</label>
                    <input type="text" placeholder="e.g. Teacher, Designer, Engineer" value={form.profession} onChange={set('profession')} className="input-base" />
                  </div>
                </div>
                <div>
                  <label className="block text-sm font-semibold text-gray-700 mb-2">Your Rating <span className="text-red-400">*</span></label>
                  <StarRating value={form.rating} onChange={v => setForm(f => ({...f, rating:v}))} size={28} />
                  {errors.rating && <p className="text-red-400 text-xs mt-1">{errors.rating}</p>}
                </div>
                <div>
                  <label className="block text-sm font-semibold text-gray-700 mb-1.5">Your Review <span className="text-red-400">*</span></label>
                  <textarea rows={5} placeholder="Share your thoughts about the loop trilogy..." value={form.review} onChange={set('review')} className={`input-base resize-none ${errors.review?'border-red-300':''}`} />
                  {errors.review && <p className="text-red-400 text-xs mt-1">{errors.review}</p>}
                </div>
                <button type="button" onClick={handleSubmit} className="w-full btn-primary py-4 text-base rounded-xl hover:-translate-y-0.5 hover:shadow-lg hover:shadow-teal-200/60 transition-all">
                  Submit Review <Send size={16} />
                </button>
              </div>
            </motion.div>
          )}
        </AnimatePresence>
      </div>
    </section>
  )
}
EOF

# Newsletter.jsx
cat > src/components/Newsletter.jsx << 'EOF'
import { useState } from 'react'
import { Send, Mail, CheckCircle } from 'lucide-react'
import FadeIn from './FadeIn'

export default function Newsletter({ variant='full' }) {
  const [email, setEmail] = useState('')
  const [done, setDone] = useState(false)
  const handle = () => { if (email.includes('@')) setDone(true) }

  if (variant === 'card') return (
    <section className="py-12 px-6">
      <div className="max-w-3xl mx-auto">
        <FadeIn>
          <div className="rounded-2xl p-10 text-center" style={{background:'linear-gradient(135deg,#0f766e 0%,#0d9488 100%)'}}>
            <div className="w-12 h-12 rounded-full bg-white/20 flex items-center justify-center mx-auto mb-5">
              <Mail size={22} className="text-white" />
            </div>
            <h3 className="text-2xl font-bold text-white mb-2">Stay Updated</h3>
            <p className="text-teal-100/80 text-sm mb-6">Subscribe to receive exclusive updates, excerpts, and release announcements.</p>
            {done ? (
              <div className="flex items-center justify-center gap-2 text-white font-medium"><CheckCircle size={18}/> Subscribed!</div>
            ) : (
              <div className="flex flex-col sm:flex-row gap-3 max-w-md mx-auto">
                <input type="email" placeholder="Enter your email" value={email} onChange={e=>setEmail(e.target.value)} onKeyDown={e=>e.key==='Enter'&&handle()}
                  className="flex-1 px-4 py-3 rounded-xl bg-white/15 border border-white/30 text-white placeholder-white/60 focus:outline-none focus:ring-2 focus:ring-white/50 text-sm" />
                <button onClick={handle} className="inline-flex items-center justify-center gap-2 bg-white text-teal-700 font-semibold px-5 py-3 rounded-xl text-sm hover:bg-teal-50 transition-all">
                  Subscribe <Send size={14} />
                </button>
              </div>
            )}
          </div>
        </FadeIn>
      </div>
    </section>
  )

  return (
    <section className="relative py-24 overflow-hidden" style={{background:'linear-gradient(135deg,#0f2744 0%,#0f766e 60%,#0d9488 100%)'}}>
      <div className="absolute inset-0 opacity-[0.04]" style={{backgroundImage:'radial-gradient(circle at 1px 1px,rgba(255,255,255,0.6) 1px,transparent 0)',backgroundSize:'28px 28px'}} />
      <div className="relative z-10 max-w-2xl mx-auto px-6 text-center">
        <FadeIn>
          <div className="w-14 h-14 rounded-2xl bg-teal-500/40 border border-teal-400/30 flex items-center justify-center mx-auto mb-8">
            <Mail size={24} className="text-teal-200" />
          </div>
          <h2 className="text-4xl md:text-5xl font-bold text-white mb-4">Join Our Reader Community</h2>
          <p className="text-teal-200/80 text-lg mb-10">Be the first to know about new releases, exclusive content, and special offers.</p>
          {done ? (
            <div className="flex items-center justify-center gap-2 text-white text-lg font-medium"><CheckCircle size={24} className="text-teal-300"/> You're subscribed!</div>
          ) : (
            <div className="flex flex-col sm:flex-row gap-3 max-w-md mx-auto">
              <input type="email" placeholder="Enter your email address" value={email} onChange={e=>setEmail(e.target.value)} onKeyDown={e=>e.key==='Enter'&&handle()}
                className="flex-1 px-5 py-3.5 rounded-xl bg-white/10 border border-white/25 text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-teal-400 text-sm" />
              <button onClick={handle} className="inline-flex items-center justify-center gap-2 bg-teal-500 hover:bg-teal-400 text-white font-semibold px-6 py-3.5 rounded-xl text-sm whitespace-nowrap transition-all">
                Subscribe <Send size={14} />
              </button>
            </div>
          )}
          <p className="text-teal-300/60 text-xs mt-4">We respect your privacy. Unsubscribe at any time.</p>
        </FadeIn>
      </div>
    </section>
  )
}
EOF

# Footer.jsx
cat > src/components/Footer.jsx << 'EOF'
import { BookOpen, Facebook, Twitter, Instagram, Mail } from 'lucide-react'
const quickLinks   = [{ label:'Home', page:'home' },{ label:'About Author', page:'about' },{ label:'Contact Us', page:'contact' }]
const trilogyLinks = [{ label:'Part I: The Loop', page:'part-one' },{ label:'Part II: Within The Loop', page:'part-two' },{ label:'Part III: Beyond The Loop', page:'part-three' }]
const socials      = [{ Icon:Facebook, label:'Facebook' },{ Icon:Twitter, label:'Twitter' },{ Icon:Instagram, label:'Instagram' },{ Icon:Mail, label:'Email' }]
export default function Footer({ onNavigate }) {
  const go = (page) => { onNavigate(page); window.scrollTo({top:0,behavior:'smooth'}) }
  return (
    <footer className="bg-gray-900 text-gray-400">
      <div className="max-w-7xl mx-auto px-6 pt-16 pb-8">
        <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-10 mb-12">
          <div>
            <button onClick={()=>go('home')} className="flex items-center gap-2 mb-4 group">
              <BookOpen size={20} className="text-teal-500"/>
              <span className="font-bold text-white text-base group-hover:text-teal-400 transition-colors">The Loop Trilogy</span>
            </button>
            <p className="text-sm leading-relaxed">A journey through time, consciousness, and reality. Coming Summer 2026.</p>
          </div>
          <div>
            <h4 className="font-semibold text-teal-500 text-sm tracking-wider uppercase mb-5">Quick Links</h4>
            <ul className="space-y-3">{quickLinks.map(({label,page})=>(
              <li key={label}><button onClick={()=>go(page)} className="text-sm text-gray-400 hover:text-white transition-colors text-left">{label}</button></li>
            ))}</ul>
          </div>
          <div>
            <h4 className="font-semibold text-teal-500 text-sm tracking-wider uppercase mb-5">The Trilogy</h4>
            <ul className="space-y-3">{trilogyLinks.map(({label,page})=>(
              <li key={label}><button onClick={()=>go(page)} className="text-sm text-gray-400 hover:text-white transition-colors text-left">{label}</button></li>
            ))}</ul>
          </div>
          <div>
            <h4 className="font-semibold text-teal-500 text-sm tracking-wider uppercase mb-5">Connect</h4>
            <div className="flex gap-3">{socials.map(({Icon,label})=>(
              <button key={label} aria-label={label} className="w-10 h-10 rounded-xl bg-gray-800 hover:bg-teal-600 flex items-center justify-center text-gray-400 hover:text-white transition-all duration-200 hover:scale-110">
                <Icon size={16}/>
              </button>
            ))}</div>
          </div>
        </div>
        <div className="border-t border-gray-800 pt-6 flex flex-col sm:flex-row items-center justify-between gap-4">
          <p className="text-xs text-gray-600">© 2026 The Loop Trilogy. All rights reserved.</p>
          <div className="flex gap-6">
            <button className="text-xs text-gray-600 hover:text-gray-400 transition-colors">Privacy Policy</button>
            <button className="text-xs text-gray-600 hover:text-gray-400 transition-colors">Terms of Service</button>
          </div>
        </div>
      </div>
    </footer>
  )
}
EOF

# Navbar.jsx
cat > src/components/Navbar.jsx << 'EOF'
import { useState, useEffect, useRef } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { ChevronDown, Menu, X, BookOpen } from 'lucide-react'
const dropdown = [
  { label:'Part I: The Loop', page:'part-one' },
  { label:'Part II: Within The Loop', page:'part-two' },
  { label:'Part III: Beyond The Loop', page:'part-three' },
]
export default function Navbar({ currentPage, onNavigate }) {
  const [scrolled, setScrolled]       = useState(false)
  const [mobileOpen, setMobileOpen]   = useState(false)
  const [ddOpen, setDdOpen]           = useState(false)
  const ddRef = useRef(null)
  useEffect(() => {
    const s = () => setScrolled(window.scrollY > 8)
    window.addEventListener('scroll', s, { passive:true })
    return () => window.removeEventListener('scroll', s)
  }, [])
  useEffect(() => {
    const h = e => { if (ddRef.current && !ddRef.current.contains(e.target)) setDdOpen(false) }
    document.addEventListener('mousedown', h)
    return () => document.removeEventListener('mousedown', h)
  }, [])
  const go = page => { onNavigate(page); setMobileOpen(false); setDdOpen(false); window.scrollTo({top:0,behavior:'smooth'}) }
  const active = p => Array.isArray(p) ? p.includes(currentPage) : currentPage===p
  const bookPages = ['part-one','part-two','part-three']
  const navItems = [{ label:'Home', page:'home' },{ label:'About Author', page:'about' },{ label:'Contact', page:'contact' }]
  return (
    <header className={`fixed top-0 left-0 right-0 z-50 bg-white transition-shadow duration-300 ${scrolled?'shadow-md':'shadow-sm border-b border-gray-100'}`}>
      <nav className="max-w-7xl mx-auto px-6 h-[70px] flex items-center justify-between">
        <button onClick={()=>go('home')} className="flex items-center gap-2 group">
          <BookOpen size={22} className="text-teal-600"/>
          <span className="font-bold text-lg text-teal-600 group-hover:text-teal-700 transition-colors">The Loop Trilogy</span>
        </button>
        <ul className="hidden md:flex items-center gap-1">
          {navItems.map(({label,page})=>(
            <li key={page}><button onClick={()=>go(page)} className={`px-4 py-2 rounded-lg text-sm font-medium transition-all duration-200 ${active(page)?'bg-teal-600 text-white':'text-gray-700 hover:text-teal-600 hover:bg-teal-50'}`}>{label}</button></li>
          ))}
          <li className="relative" ref={ddRef}>
            <button onClick={()=>setDdOpen(v=>!v)} className={`flex items-center gap-1 px-4 py-2 rounded-lg text-sm font-medium transition-all duration-200 ${active(bookPages)?'bg-teal-600 text-white':'text-gray-700 hover:text-teal-600 hover:bg-teal-50'}`}>
              The Loop Trilogy
              <motion.span animate={{rotate:ddOpen?180:0}} transition={{duration:0.2}}><ChevronDown size={14}/></motion.span>
            </button>
            <AnimatePresence>
              {ddOpen && (
                <motion.div initial={{opacity:0,y:-8,scale:0.97}} animate={{opacity:1,y:0,scale:1}} exit={{opacity:0,y:-8,scale:0.97}} transition={{duration:0.15}}
                  className="absolute top-full right-0 mt-1 w-60 bg-white rounded-xl shadow-lg border border-gray-100 py-2 z-50">
                  {dropdown.map(({label,page})=>(
                    <button key={page} onClick={()=>go(page)} className="w-full text-left px-4 py-2.5 text-sm text-gray-700 hover:bg-teal-50 hover:text-teal-600 transition-colors">{label}</button>
                  ))}
                </motion.div>
              )}
            </AnimatePresence>
          </li>
        </ul>
        <button className="md:hidden p-2 text-gray-600 hover:text-teal-600 transition-colors" onClick={()=>setMobileOpen(v=>!v)} aria-label="Toggle menu">
          {mobileOpen ? <X size={22}/> : <Menu size={22}/>}
        </button>
      </nav>
      <AnimatePresence>
        {mobileOpen && (
          <motion.div initial={{opacity:0,height:0}} animate={{opacity:1,height:'auto'}} exit={{opacity:0,height:0}} transition={{duration:0.25}} className="md:hidden bg-white border-t border-gray-100 overflow-hidden">
            <div className="px-6 py-4 space-y-1">
              {navItems.map(({label,page})=>(
                <button key={page} onClick={()=>go(page)} className={`w-full text-left px-3 py-2.5 rounded-lg text-sm font-medium transition-colors ${active(page)?'bg-teal-600 text-white':'text-gray-700 hover:bg-teal-50 hover:text-teal-600'}`}>{label}</button>
              ))}
              <div className="pt-1">
                <p className="text-xs font-semibold text-gray-400 uppercase tracking-wider px-3 py-2">The Trilogy</p>
                {dropdown.map(({label,page})=>(
                  <button key={page} onClick={()=>go(page)} className={`w-full text-left px-3 py-2.5 rounded-lg text-sm font-medium transition-colors ${active(page)?'bg-teal-50 text-teal-600':'text-gray-600 hover:bg-teal-50 hover:text-teal-600'}`}>{label}</button>
                ))}
              </div>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </header>
  )
}
EOF

# ─── 8. PAGES ─────────────────────────────────────────────────────────────────

# HomePage.jsx
cat > src/pages/HomePage.jsx << 'HOMEEOF'
import { motion } from 'framer-motion'
import { ArrowRight, Clock, Infinity, ShoppingCart, MessageSquareQuote } from 'lucide-react'
import FadeIn from '../components/FadeIn'
import StarRating from '../components/StarRating'
import SalesStats from '../components/SalesStats'
import ReviewForm from '../components/ReviewForm'
import Newsletter from '../components/Newsletter'
import { books, expertReviews, trilogySalesStats, reviewSummary } from '../data/content'

function Hero({ onNavigate }) {
  return (
    <section className="relative min-h-screen flex items-center justify-center overflow-hidden"
      style={{ backgroundImage:"url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=1600&q=80')", backgroundSize:'cover', backgroundPosition:'center' }}>
      <div className="absolute inset-0" style={{background:'linear-gradient(135deg,rgba(10,40,70,0.80) 0%,rgba(13,100,90,0.75) 100%)'}} />
      <div className="relative z-10 text-center px-6 max-w-3xl mx-auto">
        <motion.div initial={{opacity:0,y:-16}} animate={{opacity:1,y:0}} transition={{duration:0.5,delay:0.2}}
          className="inline-flex items-center gap-2 bg-white/10 backdrop-blur-sm border border-white/20 text-white/90 px-4 py-2 rounded-full text-sm font-medium mb-8">
          <Clock size={14} className="text-teal-300"/> Coming Summer 2026
        </motion.div>
        <motion.h1 initial={{opacity:0,y:32}} animate={{opacity:1,y:0}} transition={{duration:0.8,delay:0.35,ease:[0.22,1,0.36,1]}}
          className="text-6xl md:text-7xl lg:text-8xl font-extrabold text-white leading-tight mb-12">
          The Loop Trilogy
        </motion.h1>
        <motion.div initial={{opacity:0,y:20}} animate={{opacity:1,y:0}} transition={{duration:0.5,delay:0.6}}
          className="flex flex-col sm:flex-row gap-4 justify-center">
          <button onClick={()=>onNavigate('about')}
            className="inline-flex items-center justify-center gap-2 bg-teal-600/80 hover:bg-teal-600 backdrop-blur-sm border border-teal-500/40 text-white font-semibold px-8 py-4 rounded-xl text-base transition-all duration-200 hover:shadow-lg hover:-translate-y-0.5">
            Discover the Author <ArrowRight size={18}/>
          </button>
          <button onClick={()=>onNavigate('part-one')}
            className="inline-flex items-center justify-center gap-2 bg-teal-500 hover:bg-teal-400 text-white font-semibold px-8 py-4 rounded-xl text-base transition-all duration-200 hover:shadow-lg hover:-translate-y-0.5">
            The Loop <ArrowRight size={18}/>
          </button>
        </motion.div>
      </div>
      <motion.div initial={{opacity:0}} animate={{opacity:1}} transition={{delay:1.4}} className="absolute bottom-8 left-1/2 -translate-x-1/2">
        <motion.div animate={{y:[0,8,0]}} transition={{duration:1.5,repeat:Infinity,ease:'easeInOut'}}
          className="w-7 h-11 border-2 border-white/30 rounded-full flex items-start justify-center pt-2">
          <div className="w-1.5 h-2.5 bg-white/50 rounded-full"/>
        </motion.div>
      </motion.div>
    </section>
  )
}

function AboutSection() {
  return (
    <section className="py-24 bg-white">
      <div className="max-w-3xl mx-auto px-6 text-center">
        <FadeIn>
          <div className="w-16 h-16 rounded-2xl bg-teal-100 flex items-center justify-center mx-auto mb-8">
            <Infinity size={28} className="text-teal-600"/>
          </div>
          <h2 className="text-4xl md:text-5xl font-bold text-gray-900 mb-8">The Loop Trilogy</h2>
          <div className="space-y-5 text-gray-600 text-lg leading-relaxed">
            <p>The untold reality behind fictional characters. The Loop Trilogy is a psychological thriller trilogy consisting of 3 standalone series, each written to explore the true nature of the human psyche and the extent to which it can unravel when left unrestrained and without boundaries.</p>
            <p>Corruption in the world, along with addiction to substances, greed, and power, serve as the primary driving forces of the narrative. Through these themes, the evolution of morals and values challenges the traditional distinction between good and evil.</p>
            <p>The story is not about balance, but about contrast - revealing both good and evil in their purest, most authentic forms, free from manipulation.</p>
            <p>Although the series is based on fictional situations and scenarios, its themes are strikingly relevant to the world we live in today.</p>
            <p>Each book from this trilogy stands complete on its own, but when all three are experienced together, they offer a multidimensional view of the world created, allowing for a deeper understanding of human psychology as a whole.</p>
            <p>The narrative is intentionally open-ended, with cliffhangers in each instalment. While the audience is guided towards the core ideas, they are given complete freedom to interpret outcomes and predict what lies ahead, creating a strong potential for engagement and immersion.</p>
            <p>None of the events depicted in these books is drawn from personal experience; however, there is a strong likelihood that these realities exist within contemporary society.</p>
          </div>
        </FadeIn>
      </div>
    </section>
  )
}

function BookCard({ book, index, onNavigate }) {
  const isPartOne = book.slug === 'part-one'
  return (
    <motion.div initial={{opacity:0,y:30}} whileInView={{opacity:1,y:0}} viewport={{once:true,margin:'-40px'}}
      transition={{duration:0.55,delay:index*0.12}} whileHover={{y:-4,transition:{duration:0.2}}}
      className="card flex flex-col group">
      <div className="relative h-52 overflow-hidden flex-shrink-0">
        <img src={book.coverImage} alt={book.title} className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"/>
        <div className="absolute inset-0 bg-teal-800/45 group-hover:bg-teal-800/35 transition-colors duration-300"/>
        <div className="absolute inset-0 flex items-center justify-center px-4">
          <h3 className="text-white font-bold text-xl text-center drop-shadow-lg">{book.title}</h3>
        </div>
      </div>
      <div className="p-5 flex flex-col flex-1">
        <p className="text-gray-500 text-sm leading-relaxed flex-1 mb-5">{book.shortDesc}</p>
        <div className="flex gap-3">
          {isPartOne ? (
            <>
              <button onClick={()=>onNavigate(book.slug)} className="flex-1 btn-primary text-sm py-2.5">
                Read More <ArrowRight size={14}/>
              </button>
              <button className="flex-1 btn-secondary text-sm py-2.5">
                <ShoppingCart size={14}/> Buy Now
              </button>
            </>
          ) : (
            <button onClick={()=>onNavigate('contact')} className="flex-1 btn-primary text-sm py-2.5">
              Get Updates <ArrowRight size={14}/>
            </button>
          )}
        </div>
      </div>
    </motion.div>
  )
}

function ReviewCard({ review, index }) {
  return (
    <motion.div initial={{opacity:0,y:24}} whileInView={{opacity:1,y:0}} viewport={{once:true,margin:'-40px'}}
      transition={{duration:0.55,delay:index*0.1}} className="card p-6 flex flex-col gap-4">
      <StarRating value={review.stars} readOnly size={18}/>
      <div className="relative pl-1">
        <span className="absolute -top-2 -left-1 text-5xl leading-none text-teal-100 font-serif select-none">"</span>
        <p className="italic text-gray-700 text-base leading-relaxed pt-4">{review.text}</p>
      </div>
      <div className="pt-3 border-t border-gray-100">
        <p className="font-semibold text-gray-900 text-sm">{review.author}</p>
        <p className="text-teal-600 text-sm mt-0.5">{review.source}</p>
      </div>
    </motion.div>
  )
}

export default function HomePage({ onNavigate }) {
  return (
    <>
      <Hero onNavigate={onNavigate}/>
      <AboutSection/>
      <section className="py-16 bg-gray-50">
        <div className="max-w-6xl mx-auto px-6">
          <div className="grid md:grid-cols-3 gap-6 lg:gap-8">
            {books.map((book,i) => <BookCard key={book.id} book={book} index={i} onNavigate={onNavigate}/>)}
          </div>
        </div>
      </section>
      <SalesStats title="Trilogy Sales Performance" subtitle="Join thousands of readers on this journey" stats={trilogySalesStats}/>
      <section className="py-24 bg-gray-50">
        <div className="max-w-5xl mx-auto px-6">
          <FadeIn className="text-center mb-14">
            <div className="w-16 h-16 rounded-2xl bg-teal-100 flex items-center justify-center mx-auto mb-8">
              <MessageSquareQuote size={26} className="text-teal-600"/>
            </div>
            <h2 className="section-title">Expert Reviews</h2>
            <p className="section-sub">Acclaimed by critics, philosophers, and readers worldwide</p>
          </FadeIn>
          <div className="grid md:grid-cols-2 gap-6 mb-16">
            {expertReviews.map((r,i) => <ReviewCard key={r.id} review={r} index={i}/>)}
          </div>
          <FadeIn>
            <div className="grid grid-cols-3 gap-6 text-center">
              {reviewSummary.map(s => (
                <div key={s.label}>
                  <div className="text-4xl md:text-5xl font-bold text-teal-600 mb-2">{s.value}</div>
                  <div className="text-gray-500 text-sm font-medium">{s.label}</div>
                </div>
              ))}
            </div>
          </FadeIn>
        </div>
      </section>
      <ReviewForm bookTitle="The Loop Trilogy"/>
      <Newsletter variant="full"/>
    </>
  )
}
HOMEEOF

# AboutPage.jsx
cat > src/pages/AboutPage.jsx << 'ABOUTEOF'
import { motion } from 'framer-motion'
import FadeIn from '../components/FadeIn'
import Footer from '../components/Footer'

const credentials = [
  'CEO & Founder of ShutterBeat Media',
  'Marketing Specialist & Writer',
  'Photographer & Filmmaker',
  'VFX Artist & Visual Storyteller',
]

export default function AboutPage({ onNavigate }) {
  return (
    <>
      <section className="pt-28 pb-16 bg-white">
        <div className="max-w-6xl mx-auto px-6">
          <div className="grid lg:grid-cols-2 gap-12 items-start">
            <FadeIn x={-30} y={0}>
              <div className="rounded-2xl overflow-hidden shadow-xl">
                <img
                  src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&q=80"
                  alt="Aron Goves"
                  className="w-full h-[520px] object-cover object-top"
                />
              </div>
            </FadeIn>
            <FadeIn delay={0.15}>
              <div className="pt-4">
                <span className="badge mb-4 inline-block">Author &amp; Philosopher</span>
                <h1 className="text-4xl md:text-5xl font-bold text-gray-900 mb-6">Aron Goves</h1>
                <p className="text-gray-600 text-lg leading-relaxed mb-8">
                  Aron Goves is a marketing specialist, writer, photographer, filmmaker, and VFX artist, as well as the CEO and Founder of ShutterBeat Media. With a career rooted in visual storytelling and human psychology, Aron brings a unique multidimensional perspective to his writing.
                </p>
                <p className="text-gray-600 text-base leading-relaxed mb-8">
                  In The Loop Trilogy, he blends introspective narrative with thought-provoking themes designed to challenge readers to confront the patterns, distractions, and overlooked truths of everyday life. His work reflects a deep curiosity about human behaviour and perception, encouraging readers not just to observe the story but to question their own reality within it. Through this trilogy, Aron seeks to reach those willing to pause, reflect, and explore the unseen loops that shape their lives.
                </p>
                <div className="flex flex-wrap gap-3 mb-6">
                  {credentials.map(c => (
                    <motion.span key={c} initial={{opacity:0,scale:0.95}} whileInView={{opacity:1,scale:1}} viewport={{once:true}}
                      className="inline-flex items-center px-4 py-2 rounded-lg border border-teal-200 text-teal-700 text-sm font-medium bg-teal-50 hover:bg-teal-100 transition-colors">
                      {c}
                    </motion.span>
                  ))}
                </div>
              </div>
            </FadeIn>
          </div>
        </div>
      </section>

      {/* Writer's Quote */}
      <section className="py-16 bg-gray-50">
        <div className="max-w-4xl mx-auto px-6">
          <FadeIn>
            <div className="card p-10 border-l-4 border-teal-500">
              <h3 className="text-xl font-bold text-teal-600 mb-4">Writer's Quote</h3>
              <blockquote className="text-gray-700 text-lg leading-relaxed italic">
                "The Loop Trilogy is not just a work of fiction—it reflects the everyday experiences we often overlook. It explores the possibility that such events could happen to any of us, reminding us to stay aware of our choices and the consequences they carry. Every action has the power to shape our past, influence our present, and define our future. Through this story, I want to make you pause, reflect, and truly ponder."
              </blockquote>
              <p className="mt-4 font-semibold text-gray-900">— Aron Goves</p>
            </div>
          </FadeIn>
        </div>
      </section>

      {/* Writing Philosophy */}
      <section className="py-16 bg-white">
        <div className="max-w-4xl mx-auto px-6">
          <FadeIn className="text-center mb-10">
            <h2 className="text-4xl font-bold text-gray-900">Writing Philosophy</h2>
          </FadeIn>
          <FadeIn delay={0.1}>
            <div className="card p-10">
              <div className="space-y-5 text-gray-600 text-lg leading-relaxed">
                <p>My writing is inspired by the everyday moments we experience but often ignore. I believe that even the smallest shift in thought or action can change the course of an entire world. Through The Loop Trilogy, I aim to make readers aware of these subtle yet powerful possibilities and encourage them to recognise the weight of their choices and the responsibility that comes with them.</p>
                <p>To me, storytelling is inseparable from reality. A story should not just be read—it should be felt. My goal is to create experiences that immerse readers emotionally and make them question the boundaries between fiction and their own lives, prompting them to reflect on what they would do if faced with the same circumstances.</p>
                <p>My background in marketing and filmmaking has shaped my understanding of human emotion and perception, allowing me to craft stories that are not only engaging but deeply connective. I believe art should move people, challenge their thinking, and leave a lasting impact—whether it brings clarity or chaos. If my work makes readers pause, reflect, and see their reality differently, then it has served its purpose.</p>
              </div>
            </div>
          </FadeIn>
        </div>
      </section>

      <Footer onNavigate={onNavigate}/>
    </>
  )
}
ABOUTEOF

# BookPage.jsx
cat > src/pages/BookPage.jsx << 'BOOKEOF'
import { motion } from 'framer-motion'
import { ShoppingCart, ArrowRight, ChevronLeft, ChevronRight, Calendar, User } from 'lucide-react'
import FadeIn from '../components/FadeIn'
import StarRating from '../components/StarRating'
import ImageCarousel from '../components/ImageCarousel'
import SalesStats from '../components/SalesStats'
import ReviewForm from '../components/ReviewForm'
import Newsletter from '../components/Newsletter'
import Footer from '../components/Footer'
import { books, getBookBySlug } from '../data/content'

function AuthorExperience({ bookTitle, authorExperience }) {
  return (
    <section className="py-20 bg-gray-50">
      <div className="max-w-5xl mx-auto px-6">
        <FadeIn className="text-center mb-12">
          <h2 className="section-title">Author &amp; Illustrator Experience</h2>
          <p className="section-sub">Insights into the creation of {bookTitle}</p>
        </FadeIn>
        <FadeIn delay={0.1}>
          <div className="relative card p-10">
            <button className="absolute left-4 top-1/2 -translate-y-1/2 w-9 h-9 rounded-full border border-gray-200 flex items-center justify-center text-gray-400 hover:text-teal-600 hover:border-teal-300 transition-colors">
              <ChevronLeft size={16}/>
            </button>
            <button className="absolute right-4 top-1/2 -translate-y-1/2 w-9 h-9 rounded-full border border-gray-200 flex items-center justify-center text-gray-400 hover:text-teal-600 hover:border-teal-300 transition-colors">
              <ChevronRight size={16}/>
            </button>
            <div className="px-8">
              <div className="flex items-center gap-3 mb-6">
                <div className="w-12 h-12 rounded-full bg-teal-100 flex items-center justify-center">
                  <User size={20} className="text-teal-600"/>
                </div>
                <div>
                  <p className="font-bold text-gray-900 text-base">Aron Goves</p>
                  <p className="text-teal-600 text-sm">Author &amp; Filmmaker</p>
                </div>
              </div>
              <div className="text-gray-600 text-lg leading-relaxed space-y-4">
                {authorExperience.split('\n\n').map((para, i) => <p key={i}>{para}</p>)}
              </div>
            </div>
          </div>
        </FadeIn>
      </div>
    </section>
  )
}

function ReaderReviews({ reviews, bookTitle }) {
  return (
    <section className="py-20 bg-white">
      <div className="max-w-6xl mx-auto px-6">
        <FadeIn className="text-center mb-12">
          <h2 className="section-title">Reader Reviews</h2>
          <p className="section-sub">What readers are saying about {bookTitle}</p>
        </FadeIn>
        <div className="grid md:grid-cols-3 gap-6">
          {reviews.map((review, i) => (
            <motion.div key={review.name} initial={{opacity:0,y:24}} whileInView={{opacity:1,y:0}}
              viewport={{once:true,margin:'-40px'}} transition={{duration:0.55,delay:i*0.1}}
              className="card p-6 flex flex-col gap-4">
              <StarRating value={review.stars} readOnly size={18}/>
              <p className="text-gray-600 text-sm leading-relaxed flex-1">{review.text}</p>
              <div className="pt-3 border-t border-gray-100">
                <p className="font-semibold text-gray-900 text-sm">{review.name}</p>
                <div className="flex items-center gap-1 mt-1 text-gray-400 text-xs">
                  <Calendar size={11}/><span>{review.date}</span>
                </div>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  )
}

function ExploreOtherParts({ currentBook, onNavigate }) {
  const otherBooks = books.filter(b => currentBook.otherParts.includes(b.slug))
  return (
    <section className="py-20 bg-white">
      <div className="max-w-6xl mx-auto px-6">
        <FadeIn className="text-center mb-12">
          <h2 className="section-title">Explore Other Parts</h2>
          <p className="section-sub">Continue your journey through The Loop Trilogy</p>
        </FadeIn>
        <div className="grid md:grid-cols-2 gap-6">
          {otherBooks.map((book, i) => {
            const isPartOne = book.slug === 'part-one'
            return (
              <motion.div key={book.id} initial={{opacity:0,y:24}} whileInView={{opacity:1,y:0}}
                viewport={{once:true}} transition={{duration:0.55,delay:i*0.12}} className="card group overflow-hidden">
                <div className="relative h-52 overflow-hidden">
                  <img src={book.coverImage} alt={book.title} className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"/>
                  <div className="absolute inset-0 bg-teal-800/45"/>
                  <div className="absolute inset-0 flex flex-col items-center justify-center px-6 text-center">
                    <h3 className="text-white font-bold text-xl drop-shadow-lg mb-1">{book.title}</h3>
                    <p className="text-white/70 text-sm">{book.tagline}</p>
                  </div>
                </div>
                <div className="p-4 flex gap-3">
                  {isPartOne ? (
                    <>
                      <button onClick={()=>{ onNavigate(book.slug); window.scrollTo({top:0,behavior:'smooth'}) }} className="flex-1 btn-primary text-sm py-2.5">
                        Read More <ArrowRight size={14}/>
                      </button>
                      <button className="flex-1 btn-secondary text-sm py-2.5">
                        <ShoppingCart size={14}/> Buy Now
                      </button>
                    </>
                  ) : (
                    <button onClick={()=>{ onNavigate('contact'); window.scrollTo({top:0,behavior:'smooth'}) }} className="flex-1 btn-primary text-sm py-2.5">
                      Get Updates <ArrowRight size={14}/>
                    </button>
                  )}
                </div>
              </motion.div>
            )
          })}
        </div>
      </div>
    </section>
  )
}

export default function BookPage({ slug, onNavigate }) {
  const book = getBookBySlug(slug)
  if (!book) return <div className="pt-28 text-center py-20 text-gray-500">Book not found.</div>

  const isPartOne = book.slug === 'part-one'
  const bookStats = book.sales ? [
    { icon:'Award',      value:book.sales.total,      label:'TOTAL SALES' },
    { icon:'Calendar',   value:book.sales.lastMonth,  label:'LAST MONTH', featured:true },
    { icon:'TrendingUp', value:book.sales.thisMonth,  label:'THIS MONTH' },
  ] : []

  return (
    <>
      {/* Book hero */}
      <section className="pt-28 pb-16 bg-white">
        <div className="max-w-6xl mx-auto px-6">
          <div className="grid lg:grid-cols-2 gap-12 items-start">
            <FadeIn x={-30} y={0}>
              <ImageCarousel images={book.carouselImages}/>
            </FadeIn>
            <FadeIn delay={0.15}>
              <span className="badge mb-4 inline-block">{book.badge}</span>
              <h1 className="text-4xl md:text-5xl font-bold text-gray-900 mb-3">{book.title}</h1>
              <p className="text-teal-600 text-lg font-medium mb-6">{book.tagline}</p>
              {isPartOne && book.synopsis && (
                <>
                  <h2 className="text-lg font-bold text-gray-900 mb-3">Synopsis</h2>
                  <div className="text-gray-600 leading-relaxed text-base mb-8 space-y-3">
                    {book.synopsis.split('\n\n').map((p, i) => <p key={i}>{p}</p>)}
                  </div>
                  <button className="w-full btn-primary py-4 text-base rounded-xl">
                    <ShoppingCart size={18}/> Buy Now
                  </button>
                </>
              )}
              {!isPartOne && (
                <div className="mt-4">
                  <p className="text-gray-500 text-lg mb-8">This book is coming soon. Stay tuned for updates!</p>
                  <button onClick={()=>{ onNavigate('contact'); window.scrollTo({top:0,behavior:'smooth'}) }}
                    className="w-full btn-primary py-4 text-base rounded-xl">
                    Get Updates <ArrowRight size={18}/>
                  </button>
                </div>
              )}
            </FadeIn>
          </div>
        </div>
      </section>

      {/* Sales stats — Part I only */}
      {isPartOne && bookStats.length > 0 && (
        <SalesStats title={`${book.title} - Sales Performance`} subtitle="Join thousands of readers on this journey" stats={bookStats}/>
      )}

      {/* Author experience — Part I only */}
      {isPartOne && book.authorExperience && (
        <AuthorExperience bookTitle={book.title} authorExperience={book.authorExperience}/>
      )}

      {/* Reader reviews — Part I only */}
      {isPartOne && book.readerReviews.length > 0 && (
        <ReaderReviews reviews={book.readerReviews} bookTitle={book.title}/>
      )}

      {/* Share review — Part I only */}
      {isPartOne && <ReviewForm bookTitle={book.title}/>}

      {/* Stay updated card */}
      <Newsletter variant="card"/>

      {/* Explore other parts */}
      <ExploreOtherParts currentBook={book} onNavigate={onNavigate}/>

      <Footer onNavigate={onNavigate}/>
    </>
  )
}
BOOKEOF

# ContactPage.jsx
cat > src/pages/ContactPage.jsx << 'CONTACTEOF'
import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { Mail, MapPin, Send, CheckCircle } from 'lucide-react'
import FadeIn from '../components/FadeIn'
import Footer from '../components/Footer'
import { countries, phoneCodes, howFoundOptions, subjectOptions } from '../data/content'

export default function ContactPage({ onNavigate }) {
  const [form, setForm] = useState({ name:'', email:'', code:'+1 (US/CA)', phone:'', country:'', howFound:'', subject:'', message:'' })
  const [errors, setErrors] = useState({})
  const [submitted, setSubmitted] = useState(false)
  const set = key => e => setForm(f => ({ ...f, [key]: e.target.value }))
  const validate = () => {
    const e = {}
    if (!form.name.trim()) e.name='Name is required'
    if (!form.email.includes('@')) e.email='Valid email required'
    if (!form.country) e.country='Please select a country'
    if (!form.howFound) e.howFound='Please select an option'
    if (!form.subject) e.subject='Please select a subject'
    if (!form.message.trim()) e.message='Message is required'
    return e
  }
  const handleSubmit = () => {
    const errs = validate()
    if (Object.keys(errs).length) { setErrors(errs); return }
    setErrors({}); setSubmitted(true)
  }

  return (
    <>
      <section className="pt-28 pb-20 bg-white min-h-screen">
        <div className="max-w-6xl mx-auto px-6">
          <FadeIn className="text-center mb-14">
            <h1 className="text-5xl md:text-6xl font-bold text-gray-900 mb-4">Get in Touch</h1>
            <p className="text-gray-500 text-lg max-w-xl mx-auto">Have questions about the trilogy? Want to connect with the author? We'd love to hear from you.</p>
          </FadeIn>

          <div className="grid lg:grid-cols-[320px_1fr] gap-8 items-start">
            {/* Left info cards */}
            <div className="space-y-4">
              <FadeIn delay={0.1}>
                <div className="card p-6 flex items-start gap-4">
                  <div className="w-12 h-12 rounded-xl bg-teal-100 flex items-center justify-center text-teal-600 flex-shrink-0">
                    <Mail size={20}/>
                  </div>
                  <div>
                    <h3 className="font-bold text-gray-900 text-base mb-1">Email</h3>
                    <p className="text-gray-500 text-sm">contact@looptrilogy.com</p>
                  </div>
                </div>
              </FadeIn>
              <FadeIn delay={0.15}>
                <div className="card p-6 flex items-start gap-4">
                  <div className="w-12 h-12 rounded-xl bg-teal-100 flex items-center justify-center text-teal-600 flex-shrink-0">
                    <MapPin size={20}/>
                  </div>
                  <div>
                    <h3 className="font-bold text-gray-900 text-base mb-1">Location</h3>
                    <p className="text-gray-500 text-sm">New York, NY</p>
                  </div>
                </div>
              </FadeIn>
            </div>

            {/* Right form */}
            <FadeIn delay={0.2}>
              <AnimatePresence mode="wait">
                {submitted ? (
                  <motion.div key="ok" initial={{opacity:0,scale:0.95}} animate={{opacity:1,scale:1}}
                    className="card p-12 text-center">
                    <div className="w-20 h-20 rounded-full bg-teal-100 flex items-center justify-center mx-auto mb-6">
                      <CheckCircle size={36} className="text-teal-600"/>
                    </div>
                    <h3 className="text-2xl font-bold text-gray-900 mb-2">Message Sent!</h3>
                    <p className="text-gray-500 text-lg mb-6">Thank you for reaching out. We'll get back to you shortly.</p>
                    <button onClick={()=>{ setSubmitted(false); setForm({name:'',email:'',code:'+1 (US/CA)',phone:'',country:'',howFound:'',subject:'',message:''}) }}
                      className="btn-outline px-6 py-2.5">Send Another Message</button>
                  </motion.div>
                ) : (
                  <motion.div key="form" initial={{opacity:0}} animate={{opacity:1}}>
                    <div className="card p-8 space-y-5">
                      {/* Name + Email */}
                      <div className="grid md:grid-cols-2 gap-4">
                        <div>
                          <label className="block text-sm font-semibold text-gray-700 mb-1.5">Name <span className="text-red-400">*</span></label>
                          <input type="text" placeholder="John Doe" value={form.name} onChange={set('name')} className={`input-base ${errors.name?'border-red-300 ring-1 ring-red-200':''}`}/>
                          {errors.name && <p className="text-red-400 text-xs mt-1">{errors.name}</p>}
                        </div>
                        <div>
                          <label className="block text-sm font-semibold text-gray-700 mb-1.5">Email <span className="text-red-400">*</span></label>
                          <input type="email" placeholder="john@example.com" value={form.email} onChange={set('email')} className={`input-base ${errors.email?'border-red-300 ring-1 ring-red-200':''}`}/>
                          {errors.email && <p className="text-red-400 text-xs mt-1">{errors.email}</p>}
                        </div>
                      </div>

                      {/* Code + Phone */}
                      <div className="grid grid-cols-[160px_1fr] gap-4">
                        <div>
                          <label className="block text-sm font-semibold text-gray-700 mb-1.5">Code</label>
                          <select value={form.code} onChange={set('code')} className="input-base appearance-none cursor-pointer">
                            {phoneCodes.map(c => <option key={c}>{c}</option>)}
                          </select>
                        </div>
                        <div>
                          <label className="block text-sm font-semibold text-gray-700 mb-1.5">Phone Number</label>
                          <input type="tel" placeholder="1234567890" value={form.phone} onChange={set('phone')} className="input-base"/>
                        </div>
                      </div>

                      {/* Country */}
                      <div>
                        <label className="block text-sm font-semibold text-gray-700 mb-1.5">Country <span className="text-red-400">*</span></label>
                        <select value={form.country} onChange={set('country')} className={`input-base appearance-none cursor-pointer ${errors.country?'border-red-300':''}`}>
                          <option value="">Select your country</option>
                          {countries.map(c => <option key={c}>{c}</option>)}
                        </select>
                        {errors.country && <p className="text-red-400 text-xs mt-1">{errors.country}</p>}
                      </div>

                      {/* How did you find us */}
                      <div>
                        <label className="block text-sm font-semibold text-gray-700 mb-1.5">How did you find us? <span className="text-red-400">*</span></label>
                        <select value={form.howFound} onChange={set('howFound')} className={`input-base appearance-none cursor-pointer ${errors.howFound?'border-red-300':''}`}>
                          <option value="">Select an option</option>
                          {howFoundOptions.map(o => <option key={o}>{o}</option>)}
                        </select>
                        {errors.howFound && <p className="text-red-400 text-xs mt-1">{errors.howFound}</p>}
                      </div>

                      {/* Subject */}
                      <div>
                        <label className="block text-sm font-semibold text-gray-700 mb-1.5">Subject <span className="text-red-400">*</span></label>
                        <select value={form.subject} onChange={set('subject')} className={`input-base appearance-none cursor-pointer ${errors.subject?'border-red-300':''}`}>
                          <option value="">Select a subject</option>
                          {subjectOptions.map(o => <option key={o}>{o}</option>)}
                        </select>
                        {errors.subject && <p className="text-red-400 text-xs mt-1">{errors.subject}</p>}
                      </div>

                      {/* Message */}
                      <div>
                        <label className="block text-sm font-semibold text-gray-700 mb-1.5">Message <span className="text-red-400">*</span></label>
                        <textarea rows={5} placeholder="Tell us what's on your mind..." value={form.message} onChange={set('message')}
                          className={`input-base resize-none ${errors.message?'border-red-300':''}`}/>
                        {errors.message && <p className="text-red-400 text-xs mt-1">{errors.message}</p>}
                      </div>

                      <button type="button" onClick={handleSubmit}
                        className="w-full btn-primary py-4 text-base rounded-xl hover:-translate-y-0.5 hover:shadow-lg hover:shadow-teal-200/60 transition-all">
                        Send Message <Send size={16}/>
                      </button>
                    </div>
                  </motion.div>
                )}
              </AnimatePresence>
            </FadeIn>
          </div>
        </div>
      </section>
      <Footer onNavigate={onNavigate}/>
    </>
  )
}
CONTACTEOF

# ─── 9. APP.JSX ───────────────────────────────────────────────────────────────
cat > src/App.jsx << 'APPEOF'
import { useState } from 'react'
import Navbar from './components/Navbar'
import Footer from './components/Footer'
import HomePage from './pages/HomePage'
import AboutPage from './pages/AboutPage'
import BookPage from './pages/BookPage'
import ContactPage from './pages/ContactPage'

export default function App() {
  const [page, setPage] = useState('home')

  const navigate = (p) => setPage(p)

  const renderPage = () => {
    if (page === 'home')    return <HomePage    onNavigate={navigate}/>
    if (page === 'about')   return <AboutPage   onNavigate={navigate}/>
    if (page === 'contact') return <ContactPage onNavigate={navigate}/>
    if (['part-one','part-two','part-three'].includes(page))
      return <BookPage slug={page} onNavigate={navigate}/>
    return <HomePage onNavigate={navigate}/>
  }

  // Pages that already include their own Footer
  const selfContained = page !== 'home'

  return (
    <div className="min-h-screen flex flex-col">
      <Navbar currentPage={page} onNavigate={navigate}/>
      <main className="flex-1">
        {renderPage()}
      </main>
      {/* Home page footer rendered here; other pages render their own */}
      {page === 'home' && <Footer onNavigate={navigate}/>}
    </div>
  )
}
APPEOF

# ─── 10. INSTALL & START ─────────────────────────────────────────────────────
echo ""
echo "📦 Installing dependencies..."
npm install

echo ""
echo "✅ Setup complete!"
echo ""
echo "─────────────────────────────────────────"
echo "  To start the dev server, run:"
echo "  cd loop-trilogy && npm run dev"
echo "─────────────────────────────────────────"
