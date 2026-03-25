import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { Send, CheckCircle } from 'lucide-react'
import StarRating from './StarRating'
import { countries, reviewBookOptions } from '../data/content'

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/i

export default function ReviewForm({ bookTitle = 'the loop trilogy', defaultSelectedBook = 'The Loop Trilogy' }) {
  const initialForm = {
    selectedBook: defaultSelectedBook,
    name: '',
    email: '',
    country: '',
    profession: '',
    rating: 0,
    review: '',
  }
  const [form, setForm] = useState(initialForm)
  const [errors, setErrors] = useState({})
  const [submitted, setSubmitted] = useState(false)
  const [botField, setBotField] = useState('')

  const set = (key) => (e) => setForm((f) => ({ ...f, [key]: e.target ? e.target.value : e }))

  const validate = () => {
    const e = {}
    if (!form.selectedBook)         e.selectedBook = 'Please select a title'
    if (!form.name.trim())          e.name    = 'Name is required'
    else if (!EMAIL_RE.test(form.email.trim())) e.email = 'Enter a valid email address'
    if (!form.country)              e.country = 'Please select a country'
    if (!form.rating)               e.rating  = 'Please give a rating'
    if (!form.review.trim())        e.review  = 'Please write a review'
    else if (form.review.trim().length < 20) e.review = 'Review should be at least 20 characters'
    return e
  }

  const handleSubmit = (event) => {
    event.preventDefault()
    if (botField) return
    const errs = validate()
    if (Object.keys(errs).length) { setErrors(errs); return }
    setErrors({})
    setSubmitted(true)
  }

  return (
    <section className="section-space bg-white">
      <div className="section-shell-wide">
        <div className="text-center mb-12">
          <h2 className="section-title">Share Your Review</h2>
          <p className="section-sub">Help others discover {bookTitle} by sharing your experience</p>
        </div>
        <AnimatePresence mode="wait">
          {submitted ? (
            <motion.div key="ok" initial={{ opacity: 0, scale: 0.95 }} animate={{ opacity: 1, scale: 1 }} className="text-center py-16">
              <div className="w-20 h-20 rounded-full bg-teal-100 flex items-center justify-center mx-auto mb-6">
                <CheckCircle size={36} className="text-teal-600" />
              </div>
              <h3 className="text-2xl font-bold text-gray-900 mb-2">Thank you!</h3>
              <p className="text-gray-500 text-lg">Your review has been submitted successfully.</p>
              <button onClick={() => { setSubmitted(false); setForm(initialForm) }}
                className="mt-8 btn-outline px-6 py-2.5">Write Another Review</button>
            </motion.div>
          ) : (
            <motion.div key="form" initial={{ opacity: 0 }} animate={{ opacity: 1 }}>
              <form className="card p-6 sm:p-8 md:p-10 space-y-6" onSubmit={handleSubmit} noValidate>
                <div className="hidden">
                  <label htmlFor="review-company">Company</label>
                  <input id="review-company" type="text" value={botField} onChange={(e) => setBotField(e.target.value)} tabIndex="-1" autoComplete="off" />
                </div>
                <div className="grid md:grid-cols-2 gap-4">
                  <div>
                    <label htmlFor="review-name" className="block text-sm font-semibold text-gray-700 mb-1.5">Your Name <span className="text-red-400">*</span></label>
                    <input id="review-name" type="text" placeholder="John Doe" value={form.name} onChange={set('name')}
                      autoComplete="name"
                      maxLength={80}
                      aria-invalid={Boolean(errors.name)}
                      aria-describedby={errors.name ? 'review-name-error' : undefined}
                      className={`input-base ${errors.name ? 'border-red-300 ring-1 ring-red-200' : ''}`} />
                    {errors.name && <p id="review-name-error" className="text-red-500 text-xs mt-1">{errors.name}</p>}
                  </div>
                  <div>
                    <label htmlFor="review-email" className="block text-sm font-semibold text-gray-700 mb-1.5">Email Address <span className="text-red-400">*</span></label>
                    <input id="review-email" type="email" placeholder="john@example.com" value={form.email} onChange={set('email')}
                      autoComplete="email"
                      inputMode="email"
                      maxLength={120}
                      aria-invalid={Boolean(errors.email)}
                      aria-describedby={errors.email ? 'review-email-error' : undefined}
                      className={`input-base ${errors.email ? 'border-red-300 ring-1 ring-red-200' : ''}`} />
                    {errors.email && <p id="review-email-error" className="text-red-500 text-xs mt-1">{errors.email}</p>}
                  </div>
                </div>
                <div className="grid md:grid-cols-2 gap-4">
                  <div>
                    <label htmlFor="review-country" className="block text-sm font-semibold text-gray-700 mb-1.5">Country <span className="text-red-400">*</span></label>
                    <select id="review-country" value={form.country} onChange={set('country')} aria-invalid={Boolean(errors.country)} aria-describedby={errors.country ? 'review-country-error' : undefined} className={`input-base appearance-none cursor-pointer ${errors.country ? 'border-red-300' : ''}`}>
                      <option value="">Select your country</option>
                      {countries.map((c) => <option key={c}>{c}</option>)}
                    </select>
                    {errors.country && <p id="review-country-error" className="text-red-500 text-xs mt-1">{errors.country}</p>}
                  </div>
                  <div>
                    <label htmlFor="review-profession" className="block text-sm font-semibold text-gray-700 mb-1.5">Profession</label>
                    <input id="review-profession" type="text" placeholder="e.g. Teacher, Designer, Engineer" value={form.profession} onChange={set('profession')} autoComplete="organization-title" maxLength={80} className="input-base" />
                  </div>
                </div>
                <div>
                  <label htmlFor="review-book" className="block text-sm font-semibold text-gray-700 mb-1.5">Select Title <span className="text-red-400">*</span></label>
                  <select
                    id="review-book"
                    value={form.selectedBook}
                    onChange={set('selectedBook')}
                    aria-invalid={Boolean(errors.selectedBook)}
                    aria-describedby={errors.selectedBook ? 'review-book-error' : undefined}
                    className={`input-base appearance-none cursor-pointer ${errors.selectedBook ? 'border-red-300' : ''}`}
                  >
                    <option value="">Select a title</option>
                    {reviewBookOptions.map((option) => <option key={option}>{option}</option>)}
                  </select>
                  {errors.selectedBook && <p id="review-book-error" className="text-red-500 text-xs mt-1">{errors.selectedBook}</p>}
                </div>
                <div>
                  <label className="block text-sm font-semibold text-gray-700 mb-2">Your Rating <span className="text-red-400">*</span></label>
                  <StarRating value={form.rating} onChange={(v) => setForm((f) => ({ ...f, rating: v }))} size={28} />
                  {errors.rating && <p className="text-red-500 text-xs mt-1">{errors.rating}</p>}
                </div>
                <div>
                  <label htmlFor="review-text" className="block text-sm font-semibold text-gray-700 mb-1.5">Your Review <span className="text-red-400">*</span></label>
                  <textarea id="review-text" rows={5} placeholder={`Share your thoughts about ${form.selectedBook || 'the selected title'}...`} value={form.review} onChange={set('review')}
                    maxLength={1200}
                    aria-invalid={Boolean(errors.review)}
                    aria-describedby={errors.review ? 'review-text-error' : 'review-text-help'}
                    className={`input-base resize-none ${errors.review ? 'border-red-300' : ''}`} />
                  <p id="review-text-help" className="mt-1 text-xs text-gray-400">Minimum 20 characters. Maximum 1200 characters.</p>
                  {errors.review && <p id="review-text-error" className="text-red-500 text-xs mt-1">{errors.review}</p>}
                </div>
                <button type="submit"
                  className="w-full btn-primary py-4 text-base rounded-xl hover:-translate-y-0.5 hover:shadow-lg hover:shadow-teal-200/60 transition-all">
                  Submit Review <Send size={16} />
                </button>
              </form>
            </motion.div>
          )}
        </AnimatePresence>
      </div>
    </section>
  )
}
