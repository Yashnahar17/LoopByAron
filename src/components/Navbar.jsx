import { useState, useEffect, useRef } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { ChevronDown, Menu, X, BookOpen } from 'lucide-react'

const trilogyItems = [
  { label: 'Part I: The Loop',          page: 'part-one' },
  { label: 'Part II: Within The Loop',  page: 'part-two' },
  { label: 'Part III: Beyond The Loop', page: 'part-three' },
]

export default function Navbar({ currentPage, onNavigate }) {
  const [scrolled, setScrolled]     = useState(false)
  const [mobileOpen, setMobileOpen] = useState(false)
  const [ddOpen, setDdOpen]         = useState(false)
  const ddRef = useRef(null)

  useEffect(() => {
    const h = () => setScrolled(window.scrollY > 8)
    window.addEventListener('scroll', h, { passive: true })
    return () => window.removeEventListener('scroll', h)
  }, [])

  useEffect(() => {
    const h = (e) => { if (ddRef.current && !ddRef.current.contains(e.target)) setDdOpen(false) }
    document.addEventListener('mousedown', h)
    return () => document.removeEventListener('mousedown', h)
  }, [])

  useEffect(() => {
    const h = (e) => {
      if (e.key === 'Escape') {
        setDdOpen(false)
        setMobileOpen(false)
      }
    }
    document.addEventListener('keydown', h)
    return () => document.removeEventListener('keydown', h)
  }, [])

  useEffect(() => {
    document.body.style.overflow = mobileOpen ? 'hidden' : ''
    return () => { document.body.style.overflow = '' }
  }, [mobileOpen])

  const go = (page) => {
    onNavigate(page)
    setMobileOpen(false)
    setDdOpen(false)
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }

  const isActive = (p) => (Array.isArray(p) ? p.includes(currentPage) : currentPage === p)
  const bookPages = ['part-one', 'part-two', 'part-three']
  const navItems  = [
    { label: 'Home',         page: 'home' },
    { label: 'About Author', page: 'about' },
  ]

  const linkCls = (active) =>
    `px-4 py-2 rounded-lg text-sm font-medium transition-all duration-200 ${active ? 'bg-teal-600 text-white' : 'text-gray-700 hover:text-teal-600 hover:bg-teal-50'}`

  return (
    <header className={`fixed top-0 left-0 right-0 z-50 bg-white transition-shadow duration-300 ${scrolled ? 'shadow-md' : 'shadow-sm border-b border-gray-100'}`}>
      <nav aria-label="Primary" className="max-w-7xl mx-auto px-4 sm:px-5 lg:px-6 h-[70px] flex items-center justify-between gap-4">
        {/* Logo */}
        <button onClick={() => go('home')} className="flex min-w-0 items-center gap-2 group rounded-lg px-1 py-2 text-left">
          <BookOpen size={22} className="shrink-0 text-teal-600" />
          <span className="truncate font-bold text-base text-teal-600 transition-colors group-hover:text-teal-700 sm:text-lg">The Loop Trilogy</span>
        </button>

        {/* Desktop */}
        <ul className="hidden md:flex items-center gap-1">
          {navItems.map(({ label, page }) => (
            <li key={page}>
              <button onClick={() => go(page)} className={linkCls(isActive(page))}>{label}</button>
            </li>
          ))}
          <li className="relative" ref={ddRef}>
            <button
              onClick={() => setDdOpen((v) => !v)}
              aria-expanded={ddOpen}
              aria-haspopup="menu"
              className={`${linkCls(isActive(bookPages))} flex items-center gap-1`}
            >
              The Loop Trilogy
              <motion.span animate={{ rotate: ddOpen ? 180 : 0 }} transition={{ duration: 0.2 }}>
                <ChevronDown size={14} />
              </motion.span>
            </button>
            <AnimatePresence>
              {ddOpen && (
                <motion.div
                  initial={{ opacity: 0, y: -8, scale: 0.97 }}
                  animate={{ opacity: 1, y: 0, scale: 1 }}
                  exit={{ opacity: 0, y: -8, scale: 0.97 }}
                  transition={{ duration: 0.15 }}
                  role="menu"
                  className="absolute top-full right-0 mt-1 w-60 bg-white rounded-xl shadow-lg border border-gray-100 py-2 z-50"
                >
                  {trilogyItems.map(({ label, page }) => (
                    <button key={page} onClick={() => go(page)} role="menuitem"
                      className="w-full text-left px-4 py-2.5 text-sm text-gray-700 hover:bg-teal-50 hover:text-teal-600 transition-colors">
                      {label}
                    </button>
                  ))}
                </motion.div>
              )}
            </AnimatePresence>
          </li>
          <li>
            <button onClick={() => go('contact')} className={linkCls(isActive('contact'))}>Contact</button>
          </li>
        </ul>

        {/* Mobile toggle */}
        <button
          className="md:hidden rounded-lg p-2.5 text-gray-600 transition-colors hover:text-teal-600"
          onClick={() => setMobileOpen((v) => !v)}
          aria-label="Toggle menu"
          aria-expanded={mobileOpen}
          aria-controls="mobile-menu"
        >
          {mobileOpen ? <X size={22} /> : <Menu size={22} />}
        </button>
      </nav>

      {/* Mobile menu */}
      <AnimatePresence>
        {mobileOpen && (
          <motion.div initial={{ opacity: 0, height: 0 }} animate={{ opacity: 1, height: 'auto' }} exit={{ opacity: 0, height: 0 }} transition={{ duration: 0.25 }}
            id="mobile-menu"
            className="md:hidden max-h-[calc(100vh-70px)] overflow-y-auto bg-white border-t border-gray-100">
            <div className="px-4 py-4 sm:px-5 space-y-1">
              {navItems.map(({ label, page }) => (
                <button key={page} onClick={() => go(page)}
                  className={`w-full text-left px-3 py-3 rounded-lg text-sm font-medium transition-colors ${isActive(page) ? 'bg-teal-600 text-white' : 'text-gray-700 hover:bg-teal-50 hover:text-teal-600'}`}>
                  {label}
                </button>
              ))}
              <div className="pt-1">
                <p className="text-xs font-semibold text-gray-400 uppercase tracking-wider px-3 py-2">The Trilogy</p>
                {trilogyItems.map(({ label, page }) => (
                  <button key={page} onClick={() => go(page)}
                    className={`w-full text-left px-3 py-3 rounded-lg text-sm font-medium transition-colors ${isActive(page) ? 'bg-teal-50 text-teal-600' : 'text-gray-600 hover:bg-teal-50 hover:text-teal-600'}`}>
                    {label}
                  </button>
                ))}
              </div>
              <button onClick={() => go('contact')}
                className={`w-full text-left px-3 py-3 rounded-lg text-sm font-medium transition-colors ${isActive('contact') ? 'bg-teal-600 text-white' : 'text-gray-700 hover:bg-teal-50 hover:text-teal-600'}`}>
                Contact
              </button>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </header>
  )
}
