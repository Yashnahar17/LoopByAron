import { Suspense, lazy, useEffect, useState } from 'react'
import Navbar    from './components/Navbar'
import Footer    from './components/Footer'
import HomePage  from './pages/HomePage'

const AboutPage = lazy(() => import('./pages/AboutPage'))
const BookPage = lazy(() => import('./pages/BookPage'))
const ContactPage = lazy(() => import('./pages/ContactPage'))
const LegalPage = lazy(() => import('./pages/LegalPage'))

const BOOK_PAGES = ['part-one', 'part-two', 'part-three']
const ROUTES = {
  home: '/',
  about: '/about',
  contact: '/contact',
  privacy: '/privacy',
  terms: '/terms',
  'part-one': '/books/the-loop',
  'part-two': '/books/within-the-loop',
  'part-three': '/books/beyond-the-loop',
}

const PAGE_META = {
  home: {
    title: 'The Loop Trilogy | Psychological Thriller Books by Aron Goves',
    description:
      'Discover The Loop Trilogy, a psychological thriller series by Aron Goves exploring morality, power, addiction, and the unraveling human psyche.',
  },
  about: {
    title: 'About Aron Goves | The Loop Trilogy',
    description:
      'Learn about Aron Goves, the author and visual storyteller behind The Loop Trilogy.',
  },
  contact: {
    title: 'Contact | The Loop Trilogy',
    description:
      'Contact The Loop Trilogy team for reader questions, media enquiries, and publication updates.',
  },
  privacy: {
    title: 'Privacy Policy | The Loop Trilogy',
    description: 'Read the privacy policy for The Loop Trilogy website.',
  },
  terms: {
    title: 'Terms of Service | The Loop Trilogy',
    description: 'Review the terms of service for The Loop Trilogy website.',
  },
  'part-one': {
    title: 'Part I: The Loop | The Loop Trilogy',
    description:
      'Explore Part I: The Loop, the opening instalment in The Loop Trilogy psychological thriller series.',
  },
  'part-two': {
    title: 'Part II: Within The Loop | The Loop Trilogy',
    description:
      'Preview Part II: Within The Loop and subscribe for release updates from The Loop Trilogy.',
  },
  'part-three': {
    title: 'Part III: Beyond The Loop | The Loop Trilogy',
    description:
      'Preview Part III: Beyond The Loop and stay informed about upcoming release news.',
  },
}

function getPageFromPath(pathname) {
  const normalizedPath = pathname.replace(/\/+$/, '') || '/'
  const match = Object.entries(ROUTES).find(([, path]) => path === normalizedPath)
  return match?.[0] ?? 'home'
}

function updateDocumentMeta(page) {
  const meta = PAGE_META[page] ?? PAGE_META.home
  const canonicalHref = `${window.location.origin}${ROUTES[page] ?? ROUTES.home}`
  document.title = meta.title

  const setMeta = (selector, attribute, value) => {
    const element = document.head.querySelector(selector)
    if (element) element.setAttribute(attribute, value)
  }

  setMeta('meta[name="description"]', 'content', meta.description)
  setMeta('meta[property="og:title"]', 'content', meta.title)
  setMeta('meta[property="og:description"]', 'content', meta.description)
  setMeta('meta[property="og:url"]', 'content', canonicalHref)
  setMeta('meta[name="twitter:title"]', 'content', meta.title)
  setMeta('meta[name="twitter:description"]', 'content', meta.description)
  setMeta('link[rel="canonical"]', 'href', canonicalHref)
}

function PageFallback() {
  return (
    <div className="section-shell-wide py-24 sm:py-28">
      <div className="card p-6 text-center text-sm text-gray-500 sm:p-8">Loading page...</div>
    </div>
  )
}

export default function App() {
  const [page, setPage] = useState(() => getPageFromPath(window.location.pathname))

  useEffect(() => {
    const onPopState = () => setPage(getPageFromPath(window.location.pathname))
    window.addEventListener('popstate', onPopState)
    return () => window.removeEventListener('popstate', onPopState)
  }, [])

  useEffect(() => {
    updateDocumentMeta(page)
  }, [page])

  const navigate = (p) => {
    const nextPath = ROUTES[p] ?? ROUTES.home
    if (window.location.pathname !== nextPath) {
      window.history.pushState({ page: p }, '', nextPath)
    }
    setPage(p)
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }

  let renderedPage = <HomePage onNavigate={navigate} />
  if (page === 'about') renderedPage = <AboutPage onNavigate={navigate} />
  else if (page === 'contact') renderedPage = <ContactPage onNavigate={navigate} />
  else if (page === 'privacy') renderedPage = <LegalPage pageKey="privacy" onNavigate={navigate} />
  else if (page === 'terms') renderedPage = <LegalPage pageKey="terms" onNavigate={navigate} />
  else if (BOOK_PAGES.includes(page)) renderedPage = <BookPage slug={page} onNavigate={navigate} />

  // Home page renders its own Newsletter + Footer is added below
  // All other pages render their own Footer internally
  const homeFooter = page === 'home'

  return (
    <div className="min-h-screen flex flex-col">
      <a
        href="#main-content"
        className="sr-only focus:not-sr-only focus:fixed focus:left-4 focus:top-4 focus:z-[60] focus:rounded-lg focus:bg-white focus:px-4 focus:py-3 focus:text-sm focus:font-semibold focus:text-teal-700 focus:shadow-lg"
      >
        Skip to main content
      </a>
      <Navbar currentPage={page} onNavigate={navigate} />
      <main id="main-content" className="flex-1 pt-[70px]">
        <Suspense fallback={<PageFallback />}>{renderedPage}</Suspense>
      </main>
      {homeFooter && <Footer onNavigate={navigate} />}
    </div>
  )
}
