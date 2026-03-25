import { useState } from 'react'
import { motion } from 'framer-motion'
import { ShoppingCart, ArrowRight, ChevronLeft, ChevronRight, PenTool, User } from 'lucide-react'
import FadeIn from '../components/FadeIn'
import StarRating from '../components/StarRating'
import ImageCarousel from '../components/ImageCarousel'
import ReviewForm from '../components/ReviewForm'
import Newsletter from '../components/Newsletter'
import Footer from '../components/Footer'
import { books, getBookBySlug } from '../data/content'

// ─── AUTHOR EXPERIENCE (Part I only) ─────────────────────────────────────────
function AuthorExperience({ bookTitle, authorExperience }) {
  const slides = Array.isArray(authorExperience)
    ? authorExperience
    : authorExperience.split('\n\n').filter(Boolean).map((text) => ({
        name: 'Aron Goves',
        role: 'Author Experience',
        text,
      }))
  const [current, setCurrent] = useState(0)
  const prev = () => setCurrent((c) => (c - 1 + slides.length) % slides.length)
  const next = () => setCurrent((c) => (c + 1) % slides.length)
  const activeSlide = slides[current]
  const isIllustratorSlide = activeSlide.role === 'Illustrator Experience'

  return (
    <section className="section-space bg-gray-50">
      <div className="section-shell-wide">
        <FadeIn className="text-center mb-12">
          <h2 className="section-title">Author &amp; Illustrator Experience</h2>
          <p className="section-sub">Insights into the creation of {bookTitle}</p>
        </FadeIn>
        <FadeIn delay={0.1}>
          <div className="relative card p-10">
            {/* Prev arrow */}
            <button
              onClick={prev}
              aria-label="Previous author experience slide"
              className="absolute left-3 top-1/2 -translate-y-1/2 w-9 h-9 rounded-full border border-gray-200 flex items-center justify-center text-gray-400 hover:text-teal-600 hover:border-teal-300 transition-colors z-10"
            >
              <ChevronLeft size={16} />
            </button>
            {/* Next arrow */}
            <button
              onClick={next}
              aria-label="Next author experience slide"
              className="absolute right-3 top-1/2 -translate-y-1/2 w-9 h-9 rounded-full border border-gray-200 flex items-center justify-center text-gray-400 hover:text-teal-600 hover:border-teal-300 transition-colors z-10"
            >
              <ChevronRight size={16} />
            </button>

            <div className="px-8">
              {/* Author info */}
              <div className="flex items-center gap-3 mb-6">
                <div className="w-12 h-12 rounded-full bg-teal-100 flex items-center justify-center flex-shrink-0">
                  {isIllustratorSlide ? (
                    <PenTool size={20} className="text-teal-600" />
                  ) : (
                    <User size={20} className="text-teal-600" />
                  )}
                </div>
                <div>
                  <p className="font-bold text-gray-900 text-base">{activeSlide.name}</p>
                  <p className="text-teal-600 text-sm">{activeSlide.role}</p>
                </div>
              </div>
              {/* Slide content */}
              <motion.p
                key={current}
                initial={{ opacity: 0, x: 20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ duration: 0.35 }}
                className="whitespace-pre-line text-gray-600 text-lg leading-relaxed italic"
              >
                "{activeSlide.text}"
              </motion.p>

              {/* Slide dots */}
              {slides.length > 1 && (
                <div className="flex gap-2 mt-6">
                  {slides.map((_, i) => (
                    <button
                      key={i}
                      onClick={() => setCurrent(i)}
                      className={`transition-all duration-300 rounded-full ${i === current ? 'w-5 h-2 bg-teal-600' : 'w-2 h-2 bg-gray-300 hover:bg-gray-400'}`}
                    />
                  ))}
                </div>
              )}
            </div>
          </div>
        </FadeIn>
      </div>
    </section>
  )
}

// ─── READER REVIEWS (Part I only) ────────────────────────────────────────────
function ReaderReviews({ reviews, bookTitle }) {
  return (
    <section className="section-space bg-white">
      <div className="section-shell-wide">
        <FadeIn className="text-center mb-12">
          <h2 className="section-title">Reader Reviews</h2>
          <p className="section-sub">What readers are saying about {bookTitle}</p>
        </FadeIn>
        <div className="grid md:grid-cols-3 gap-6">
          {reviews.map((review, i) => (
            <motion.div
              key={review.name}
              initial={{ opacity: 0, y: 24 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true, margin: '-40px' }}
              transition={{ duration: 0.55, delay: i * 0.1 }}
              className="card p-6 flex flex-col gap-4"
            >
              <StarRating value={review.stars} readOnly size={18} />
              <p className="text-gray-600 text-sm leading-relaxed flex-1">{review.text}</p>
              <div className="pt-3 border-t border-gray-100">
                <p className="font-semibold text-gray-900 text-sm">{review.name}</p>
                <p className="text-teal-600 text-sm mt-0.5">{review.date}</p>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  )
}

// ─── EXPLORE OTHER PARTS ─────────────────────────────────────────────────────
function ExploreOtherParts({ currentBook, onNavigate }) {
  const otherBooks = books.filter((b) => currentBook.otherParts.includes(b.slug))

  return (
    <section className="section-space bg-white">
      <div className="section-shell-wide">
        <FadeIn className="text-center mb-12">
          <h2 className="section-title">Explore Other Parts</h2>
          <p className="section-sub">Continue your journey through The Loop Trilogy</p>
        </FadeIn>
        <div className="grid md:grid-cols-2 gap-6">
          {otherBooks.map((book, i) => {
            const isPartOne = book.slug === 'part-one'
            const isComingSoonPart = book.slug === 'part-two' || book.slug === 'part-three'
            return (
              <motion.div
                key={book.id}
                initial={{ opacity: 0, y: 24 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.55, delay: i * 0.12 }}
                className="card group overflow-hidden"
              >
                {/* Cover */}
                <div className="relative h-52 overflow-hidden">
                  <img
                    src={book.coverImage} alt={book.title}
                    loading="lazy"
                    decoding="async"
                    className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                  />
                  <div className="absolute inset-0 bg-teal-800/45" />
                  <div className="absolute inset-0 flex flex-col items-center justify-center px-6 text-center">
                    <h3 className="text-white font-bold text-xl drop-shadow-lg mb-1">
                      {book.title}
                    </h3>
                    {isComingSoonPart && (
                      <p className="text-white font-semibold text-sm uppercase tracking-[0.18em] drop-shadow-lg mb-1">
                        Coming Soon
                      </p>
                    )}
                    {book.tagline && (
                      <p className="text-white/70 text-sm">{book.tagline}</p>
                    )}
                  </div>
                </div>

                {/* Buttons */}
                <div className="p-4 flex gap-3">
                  {isPartOne ? (
                    <>
                      <button
                        onClick={() => { onNavigate(book.slug); window.scrollTo({ top: 0, behavior: 'smooth' }) }}
                        className="flex-1 btn-primary text-sm py-2.5"
                      >
                        Read More <ArrowRight size={14} />
                      </button>
                      <button className="flex-1 btn-secondary text-sm py-2.5">
                        <ShoppingCart size={14} /> Buy Now
                      </button>
                    </>
                  ) : (
                    <button
                      onClick={() => { onNavigate('contact'); window.scrollTo({ top: 0, behavior: 'smooth' }) }}
                      className="w-full btn-primary text-sm py-2.5"
                    >
                      Get Updates <ArrowRight size={14} />
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

// ─── MAIN BOOK PAGE ───────────────────────────────────────────────────────────
export default function BookPage({ slug, onNavigate }) {
  const book = getBookBySlug(slug)
  if (!book) return <div className="pt-28 py-20 text-center text-gray-500">Book not found.</div>

  const isPartOne = book.slug === 'part-one'

  return (
    <>
      {/* ── Book Hero ────────────────────────────────────────────────────── */}
      <section className="pt-28 pb-16 md:pb-20 bg-white">
        <div className="section-shell-wide">
          <div className="grid lg:grid-cols-[1.02fr_0.98fr] gap-10 xl:gap-14 items-start">
            {/* Carousel */}
            <FadeIn x={-30} y={0}>
              <ImageCarousel images={book.carouselImages} />
            </FadeIn>

            {/* Info */}
            <FadeIn delay={0.15}>
              <div className="rounded-[2rem] border border-gray-100 bg-white p-8 shadow-[0_20px_55px_rgba(15,23,42,0.06)] md:p-10">
                <span className="badge mb-4 inline-block">{book.badge}</span>
                <h1 className="text-4xl md:text-5xl font-bold text-gray-900 mb-3">{book.title}</h1>
                {book.tagline && (
                  <p className="text-teal-600 text-lg font-medium mb-6">{book.tagline}</p>
                )}

                {/* Part I: show synopsis + Buy Now */}
                {isPartOne && (
                  <>
                    <h2 className="text-lg font-bold text-gray-900 mb-3">Synopsis</h2>
                    <div className="space-y-3 text-gray-600 leading-relaxed text-base mb-8">
                      {book.synopsis.split('\n\n').map((para, i) => (
                        <p key={i}>{para}</p>
                      ))}
                    </div>
                    <button className="w-full btn-primary py-4 text-base rounded-xl hover:-translate-y-0.5 hover:shadow-lg transition-all">
                      <ShoppingCart size={18} /> Buy Now
                    </button>
                  </>
                )}

                {/* Parts II & III: no synopsis, Get Updates only */}
                {!isPartOne && (
                  <div className="mt-2">
                    <p className="text-gray-500 text-lg mb-8 leading-relaxed">
                      This book is coming soon. Stay tuned for updates on the next instalment of The Loop Trilogy.
                    </p>
                    <button
                      onClick={() => { onNavigate('contact'); window.scrollTo({ top: 0, behavior: 'smooth' }) }}
                      className="w-full btn-primary py-4 text-base rounded-xl hover:-translate-y-0.5 hover:shadow-lg transition-all"
                    >
                      Get Updates <ArrowRight size={18} />
                    </button>
                  </div>
                )}
              </div>
            </FadeIn>
          </div>
        </div>
      </section>

      {/* Sales performance intentionally hidden for now.
          Re-enable the SalesStats block here when needed. */}

      {/* ── Author Experience — Part I only ──────────────────────────── */}
      {isPartOne && book.authorExperience && (
        <AuthorExperience bookTitle={book.title} authorExperience={book.authorExperience} />
      )}

      {/* ── Explore other parts (all books) ──────────────────────────── */}
      <ExploreOtherParts currentBook={book} onNavigate={onNavigate} />

      {/* ── Reader reviews — Part I only ─────────────────────────────── */}
      {isPartOne && book.readerReviews.length > 0 && (
        <ReaderReviews reviews={book.readerReviews} bookTitle={book.title} />
      )}

      {/* ── Share review form — Part I only ──────────────────────────── */}
      {isPartOne && <ReviewForm bookTitle={book.title} defaultSelectedBook="The Loop" />}

      {/* ── Stay updated card (all books) ─────────────────────────────── */}
      <Newsletter variant="card" />

      <Footer onNavigate={onNavigate} />
    </>
  )
}
