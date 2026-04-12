
import { useState } from 'react'
import { motion } from 'framer-motion'
import { ArrowRight, ChevronLeft, ChevronRight, Clock, Infinity, ShoppingCart, MessageSquareQuote } from 'lucide-react'
import FadeIn from '../components/FadeIn'
import StarRating from '../components/StarRating'
import ReviewForm from '../components/ReviewForm'
import Newsletter from '../components/Newsletter'
import BuyPopup from '../components/BuyPopup/BuyPopup'
import { books, expertReviewSlides, reviewSummary } from '../data/content'
import homeBanner from '../assets/images/home-banner.png'

// ─── HERO ─────────────────────────────────────────────────────────────────────
function Hero({ onNavigate }) {
  return (
    <section
      className="relative min-h-screen flex items-center justify-center overflow-hidden"
      style={{
        backgroundImage: `url(${homeBanner})`,
        backgroundSize: 'cover',
        backgroundPosition: 'center',
      }}
    >
      <div
        className="absolute inset-0"
        style={{ background: 'linear-gradient(135deg,rgba(10,40,70,0.80) 0%,rgba(13,100,90,0.75) 100%)' }}
      />
      <div className="section-shell-wide relative z-10 py-24 md:py-28">
        {/* Badge */}
        <motion.div
          initial={{ opacity: 0, y: -16 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.2 }}
          className="flex justify-center mb-8 md:mb-10"
        >
          <div className="inline-flex items-center gap-2 bg-white/10 backdrop-blur-sm border border-white/20 text-white/90 px-4 py-2 rounded-full text-sm font-medium">
            <Clock size={14} className="text-teal-300" /> Coming Summer 2026
          </div>
        </motion.div>

        {/* Title */}
        <motion.h1
          initial={{ opacity: 0, y: 32 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.35, ease: [0.22, 1, 0.36, 1] }}
          className="mx-auto max-w-4xl text-center text-4xl font-extrabold leading-[0.95] tracking-tight text-white mb-10 sm:text-5xl md:text-7xl lg:text-[5.5rem] md:mb-14"
        >
          The Loop Trilogy
        </motion.h1>

        {/* CTAs */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.6 }}
          className="flex flex-col sm:flex-row gap-4 justify-center items-center"
        >
          <button
            onClick={() => onNavigate('about')}
            className="w-full sm:w-[300px] inline-flex items-center justify-center gap-2 bg-teal-600/80 hover:bg-teal-600 backdrop-blur-sm border border-teal-400/40 text-white font-semibold px-10 py-4 rounded-xl text-base transition-all duration-200 hover:shadow-lg hover:-translate-y-0.5"
          >
            Discover the Author <ArrowRight size={18} />
          </button>
          <button
            onClick={() => onNavigate('part-one')}
            className="w-full sm:w-[300px] inline-flex items-center justify-center gap-2 bg-teal-500 hover:bg-teal-400 text-white font-semibold px-10 py-4 rounded-xl text-base transition-all duration-200 hover:shadow-lg hover:-translate-y-0.5"
          >
            The Loop <ArrowRight size={18} />
          </button>
        </motion.div>
      </div>

      {/* Scroll indicator */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 1.4 }}
        className="absolute bottom-8 left-1/2 -translate-x-1/2"
      >
        <motion.div
          animate={{ y: [0, 8, 0] }}
          transition={{ duration: 1.5, repeat: Infinity, ease: 'easeInOut' }}
          className="w-7 h-11 border-2 border-white/30 rounded-full flex items-start justify-center pt-2"
        >
          <div className="w-1.5 h-2.5 bg-white/50 rounded-full" />
        </motion.div>
      </motion.div>
    </section>
  )
}

// ─── ABOUT SECTION ────────────────────────────────────────────────────────────
function AboutSection() {
  return (
    <section className="section-space bg-white">
      <div className="section-shell-wide">
        <FadeIn>
          <div className="w-16 h-16 rounded-2xl bg-teal-100 flex items-center justify-center mx-auto mb-8">
            <Infinity size={28} className="text-teal-600" />
          </div>
          <div className="max-w-3xl mx-auto text-center mb-12">
            <h2 className="text-4xl md:text-5xl font-bold text-gray-900">The Loop Trilogy</h2>
          </div>
          <div className="max-w-4xl mx-auto space-y-6 text-left text-gray-600 text-base md:text-lg leading-8">
            <p>The untold reality behind fictional characters. The Loop Trilogy is a psychological thriller trilogy consisting of three standalone series, each written to explore the true nature of the human psyche and the extent to which it can unravel when left unrestrained and without boundaries. Corruption in the world, along with addiction to substances, greed, and power, serve as the primary driving forces of the narrative. Through these themes, the evolution of morals and values challenges the traditional distinction between good and evil, revealing both sides in their purest and most authentic forms.</p>
            <p>Although the series is based on fictional situations and scenarios, its themes are strikingly relevant to the world we live in today. Each book stands complete on its own, but when all three are experienced together, they offer a multidimensional view of the world created and a deeper understanding of human psychology as a whole. The narrative is intentionally open-ended, with cliffhangers in each instalment, giving readers the freedom to interpret outcomes and imagine what lies ahead. None of the events depicted in these books is drawn from personal experience; however, there is a strong likelihood that these realities exist within contemporary society.</p>
          </div>
        </FadeIn>
      </div>
    </section>
  )
}

// ─── BOOK CARD ────────────────────────────────────────────────────────────────
function BookCard({ book, index, onNavigate }) {
  const isPartOne = book.slug === 'part-one'
  const isComingSoonPart = book.slug === 'part-two' || book.slug === 'part-three'
  const cardDescription = isPartOne
    ? 'The Loop is the opening instalment of The Loop Trilogy, followed by Within the Loop and Beyond the Loop. The novel is organised into five chapters, referred to as seasons, each consisting of four parts. Across each season, Advait experiences a profound transformation as he is driven to confront the forces behind the chaos shaping his journey.'
    : book.shortDesc
  return (
    <motion.div
      initial={{ opacity: 0, y: 30 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, margin: '-40px' }}
      transition={{ duration: 0.55, delay: index * 0.12 }}
      whileHover={{ y: -4, transition: { duration: 0.2 } }}
      className="card flex flex-col group"
    >
      {/* Cover image */}
      <div className="relative h-52 overflow-hidden flex-shrink-0">
        <img
          src={book.coverImage} alt={book.title}
          loading="lazy"
          decoding="async"
          className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
        />
        <div className="absolute inset-0 bg-teal-800/45 group-hover:bg-teal-800/35 transition-colors duration-300" />
        <div className="absolute inset-0 flex flex-col items-center justify-center px-4 text-center">
          <h3 className="text-white font-bold text-xl drop-shadow-lg">{book.title}</h3>
          {isComingSoonPart && (
            <p className="mt-1 text-white font-semibold text-sm uppercase tracking-[0.18em] drop-shadow-lg">
              Coming Soon
            </p>
          )}
        </div>
      </div>

      {/* Body */}
      <div className="p-5 flex flex-col flex-1">
        <p className="text-gray-500 text-sm leading-relaxed flex-1 mb-5">{cardDescription}</p>
        <div className="flex gap-3">
          {isPartOne ? (
            <>
              <button
                onClick={() => onNavigate(book.slug)}
                className="flex-1 btn-primary text-sm px-4 py-2.5"
              >
                Read More <ArrowRight size={14} />
              </button>
              <BuyPopup bookTitle="The Loop: Part One" className="flex-1 btn-secondary text-sm px-4 py-2.5" />
            </>
          ) : (
            <button
              onClick={() => onNavigate('contact')}
              className="w-full btn-primary text-sm px-4 py-2.5"
            >
              Get Updates <ArrowRight size={14} />
            </button>
          )}
        </div>
      </div>
    </motion.div>
  )
}

// ─── EXPERT REVIEW CARD ───────────────────────────────────────────────────────
function ExpertReviewCard({ review, index }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 24 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, margin: '-40px' }}
      transition={{ duration: 0.55, delay: index * 0.1 }}
      className="card p-6 flex flex-col gap-4"
    >
      <StarRating value={review.stars} readOnly size={18} />
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

// ─── HOME PAGE ────────────────────────────────────────────────────────────────
export default function HomePage({ onNavigate }) {
  const [activeReviewSlide, setActiveReviewSlide] = useState(0)
  const currentReviewSlide = expertReviewSlides[activeReviewSlide]
  const prevReviewSlide = () => setActiveReviewSlide((current) => (current - 1 + expertReviewSlides.length) % expertReviewSlides.length)
  const nextReviewSlide = () => setActiveReviewSlide((current) => (current + 1) % expertReviewSlides.length)

  return (
    <>
      <Hero onNavigate={onNavigate} />

      <AboutSection />

      {/* Book cards grid */}
      <section className="section-space bg-gray-50">
        <div className="section-shell-wide">
          <FadeIn className="max-w-3xl mx-auto text-center mb-12">
            <h2 className="section-title">Explore the Trilogy</h2>
            <p className="section-sub">Start with the first book or follow upcoming releases as the story expands.</p>
          </FadeIn>
          <div className="grid md:grid-cols-3 gap-6 lg:gap-8 items-stretch">
            {books.map((book, i) => (
              <BookCard key={book.id} book={book} index={i} onNavigate={onNavigate} />
            ))}
          </div>
        </div>
      </section>

      {/* Expert reviews */}
      <section className="section-space bg-gray-50">
        <div className="section-shell-wide">
          <FadeIn className="text-center mb-14">
            <div className="w-16 h-16 rounded-2xl bg-teal-100 flex items-center justify-center mx-auto mb-8">
              <MessageSquareQuote size={26} className="text-teal-600" />
            </div>
            <h2 className="section-title">Expert Reviews</h2>
            <p className="section-sub">Acclaimed by critics, philosophers, and readers worldwide</p>
          </FadeIn>

          <FadeIn delay={0.08}>
            <div className="mb-8 flex flex-wrap items-center justify-center gap-3">
              {expertReviewSlides.map((slide, index) => (
                <button
                  key={slide.id}
                  type="button"
                  onClick={() => setActiveReviewSlide(index)}
                  className={`rounded-full border px-4 py-2 text-sm font-semibold transition-all duration-200 ${
                    index === activeReviewSlide
                      ? 'border-teal-600 bg-teal-600 text-white shadow-lg shadow-teal-200/70'
                      : 'border-gray-200 bg-white text-gray-600 hover:border-teal-300 hover:text-teal-600'
                  }`}
                >
                  {slide.label}
                </button>
              ))}
            </div>

            <div className="mb-5 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
              <div className="min-w-0">
                <p className="text-sm font-semibold uppercase tracking-[0.22em] text-teal-600">
                  Now Viewing
                </p>
                <h3 className="mt-1 text-2xl font-bold text-gray-900">{currentReviewSlide.label}</h3>
              </div>
              <div className="flex items-center gap-3 self-start sm:self-auto">
                <button
                  type="button"
                  onClick={prevReviewSlide}
                  aria-label="Previous review slide"
                  className="flex h-11 w-11 items-center justify-center rounded-full border border-gray-200 bg-white text-gray-500 transition-all duration-200 hover:border-teal-300 hover:text-teal-600"
                >
                  <ChevronLeft size={18} />
                </button>
                <button
                  type="button"
                  onClick={nextReviewSlide}
                  aria-label="Next review slide"
                  className="flex h-11 w-11 items-center justify-center rounded-full border border-gray-200 bg-white text-gray-500 transition-all duration-200 hover:border-teal-300 hover:text-teal-600"
                >
                  <ChevronRight size={18} />
                </button>
              </div>
            </div>

            <motion.div
              key={currentReviewSlide.id}
              initial={{ opacity: 0, y: 16 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.35 }}
              className="grid md:grid-cols-2 gap-6 mb-16"
            >
              {currentReviewSlide.reviews.map((review, index) => (
                <ExpertReviewCard key={review.id} review={review} index={index} />
              ))}
            </motion.div>
          </FadeIn>

          {/* Summary stats */}
          <FadeIn>
            <div className="grid grid-cols-2 gap-6 text-center">
              {reviewSummary.map((s) => (
                <div key={s.label}>
                  <div className="text-4xl md:text-5xl font-bold text-teal-600 mb-2">{s.value}</div>
                  <div className="text-gray-500 text-sm font-medium">{s.label}</div>
                </div>
              ))}
            </div>
          </FadeIn>
        </div>
      </section>

      {/* Share your review */}
      <ReviewForm bookTitle="The Loop Trilogy" defaultSelectedBook="The Loop Trilogy" />

      {/* Newsletter */}
      <Newsletter variant="full" />
    </>
  )
}