import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { Mail, MapPin, Send, CheckCircle, Newspaper, Mic, ArrowRight } from 'lucide-react'
import FadeIn from '../components/FadeIn'
import Footer from '../components/Footer'
import { countries, phoneCodes, howFoundOptions, subjectOptions } from '../data/content'

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/i

export default function ContactPage({ onNavigate }) {
  const [form, setForm] = useState({
    name: '', email: '', code: '+1 (US/CA)', phone: '',
    country: '', howFound: '', subject: '', message: '',
  })
  const [mediaEmail, setMediaEmail] = useState('')
  const [mediaEmailError, setMediaEmailError] = useState('')
  const [errors, setErrors]     = useState({})
  const [submitted, setSubmitted] = useState(false)
  const [botField, setBotField] = useState('')

  const set = (key) => (e) => setForm((f) => ({ ...f, [key]: e.target.value }))

  const validate = () => {
    const e = {}
    if (!form.name.trim())           e.name     = 'Name is required'
    else if (!EMAIL_RE.test(form.email.trim())) e.email = 'Enter a valid email address'
    if (!form.country)               e.country  = 'Please select a country'
    if (!form.howFound)              e.howFound = 'Please select an option'
    if (!form.subject)               e.subject  = 'Please select a subject'
    if (form.phone && form.phone.replace(/\D/g, '').length < 7) e.phone = 'Enter a valid phone number'
    if (!form.message.trim())        e.message  = 'Message is required'
    else if (form.message.trim().length < 20) e.message = 'Message should be at least 20 characters'
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

  const resetForm = () => {
    setSubmitted(false)
    setForm({ name: '', email: '', code: '+1 (US/CA)', phone: '', country: '', howFound: '', subject: '', message: '' })
  }

  const handleMediaEmailSend = () => {
    if (!EMAIL_RE.test(mediaEmail.trim())) {
      setMediaEmailError('Please enter a valid email address')
      return
    }

    setMediaEmailError('')

    const subject = encodeURIComponent('Press / Media Enquiry')
    const body = encodeURIComponent(
      `Hello,\n\nI would like to make a media / press enquiry regarding The Loop Trilogy.\n\nMy email: ${mediaEmail}\nPublication / Platform:\nDeadline:\nPreferred format:\nRequest details:\n\nThank you.`
    )

    window.location.href = `mailto:contact@looptrilogy.com?subject=${subject}&body=${body}`
  }

  return (
    <>
      <section className="pt-28 pb-20 md:pb-24 bg-white min-h-screen">
        <div className="section-shell-wide">
          {/* Header */}
          <FadeIn className="text-center mb-12 md:mb-14">
            <h1 className="text-5xl md:text-6xl font-bold text-gray-900 mb-4">Get in Touch</h1>
            <p className="text-gray-500 text-lg max-w-xl mx-auto leading-relaxed">
              Have questions about the trilogy? Want to connect with the author? We'd love to hear from you.
            </p>
          </FadeIn>

          <div className="grid lg:grid-cols-[320px_minmax(0,1fr)] gap-8 xl:gap-10 items-start">
            {/* ── Left: info cards ── */}
            <div className="space-y-4">
              <FadeIn delay={0.1}>
                <div className="card p-6 flex items-start gap-4">
                  <div className="w-12 h-12 rounded-xl bg-teal-100 flex items-center justify-center text-teal-600 flex-shrink-0">
                    <Mail size={20} />
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
                    <MapPin size={20} />
                  </div>
                  <div>
                    <h3 className="font-bold text-gray-900 text-base mb-1">Location</h3>
                    <p className="text-gray-500 text-sm">New York, NY</p>
                  </div>
                </div>
              </FadeIn>
            </div>

            {/* ── Right: form ── */}
            <FadeIn delay={0.2}>
              <AnimatePresence mode="wait">
                {submitted ? (
                  <motion.div
                    key="success"
                    initial={{ opacity: 0, scale: 0.95 }}
                    animate={{ opacity: 1, scale: 1 }}
                    className="card p-12 text-center"
                  >
                    <div className="w-20 h-20 rounded-full bg-teal-100 flex items-center justify-center mx-auto mb-6">
                      <CheckCircle size={36} className="text-teal-600" />
                    </div>
                    <h3 className="text-2xl font-bold text-gray-900 mb-2">Message Sent!</h3>
                    <p className="text-gray-500 text-lg mb-6">
                      Thank you for reaching out. We'll get back to you shortly.
                    </p>
                    <button onClick={resetForm} className="btn-outline px-6 py-2.5">
                      Send Another Message
                    </button>
                  </motion.div>
                ) : (
                  <motion.div key="form" initial={{ opacity: 0 }} animate={{ opacity: 1 }}>
                    <form className="card p-6 sm:p-8 md:p-10 space-y-5" onSubmit={handleSubmit} noValidate>
                      <div className="hidden">
                        <label htmlFor="contact-company">Company</label>
                        <input id="contact-company" type="text" value={botField} onChange={(e) => setBotField(e.target.value)} tabIndex="-1" autoComplete="off" />
                      </div>
                      {/* Name + Email */}
                      <div className="grid md:grid-cols-2 gap-4">
                        <div>
                          <label htmlFor="contact-name" className="block text-sm font-semibold text-gray-700 mb-1.5">
                            Name <span className="text-red-400">*</span>
                          </label>
                          <input
                            id="contact-name" type="text" placeholder="John Doe" value={form.name} onChange={set('name')}
                            autoComplete="name"
                            maxLength={80}
                            aria-invalid={Boolean(errors.name)}
                            aria-describedby={errors.name ? 'contact-name-error' : undefined}
                            className={`input-base ${errors.name ? 'border-red-300 ring-1 ring-red-200' : ''}`}
                          />
                          {errors.name && <p id="contact-name-error" className="text-red-500 text-xs mt-1">{errors.name}</p>}
                        </div>
                        <div>
                          <label htmlFor="contact-email" className="block text-sm font-semibold text-gray-700 mb-1.5">
                            Email <span className="text-red-400">*</span>
                          </label>
                          <input
                            id="contact-email" type="email" placeholder="john@example.com" value={form.email} onChange={set('email')}
                            autoComplete="email"
                            inputMode="email"
                            maxLength={120}
                            aria-invalid={Boolean(errors.email)}
                            aria-describedby={errors.email ? 'contact-email-error' : undefined}
                            className={`input-base ${errors.email ? 'border-red-300 ring-1 ring-red-200' : ''}`}
                          />
                          {errors.email && <p id="contact-email-error" className="text-red-500 text-xs mt-1">{errors.email}</p>}
                        </div>
                      </div>

                      {/* Phone code + number */}
                      <div className="grid sm:grid-cols-[160px_minmax(0,1fr)] gap-4">
                        <div>
                          <label htmlFor="contact-code" className="block text-sm font-semibold text-gray-700 mb-1.5">Code</label>
                          <select id="contact-code" value={form.code} onChange={set('code')} className="input-base appearance-none cursor-pointer">
                            {phoneCodes.map((c) => <option key={c}>{c}</option>)}
                          </select>
                        </div>
                        <div>
                          <label htmlFor="contact-phone" className="block text-sm font-semibold text-gray-700 mb-1.5">Phone Number</label>
                          <input
                            id="contact-phone" type="tel" placeholder="1234567890" value={form.phone} onChange={set('phone')}
                            autoComplete="tel-national"
                            inputMode="tel"
                            maxLength={24}
                            aria-invalid={Boolean(errors.phone)}
                            aria-describedby={errors.phone ? 'contact-phone-error' : undefined}
                            className="input-base"
                          />
                          {errors.phone && <p id="contact-phone-error" className="text-red-500 text-xs mt-1">{errors.phone}</p>}
                        </div>
                      </div>

                      {/* Country */}
                      <div>
                        <label htmlFor="contact-country" className="block text-sm font-semibold text-gray-700 mb-1.5">
                          Country <span className="text-red-400">*</span>
                        </label>
                        <select
                          id="contact-country"
                          value={form.country} onChange={set('country')}
                          aria-invalid={Boolean(errors.country)}
                          aria-describedby={errors.country ? 'contact-country-error' : undefined}
                          className={`input-base appearance-none cursor-pointer ${errors.country ? 'border-red-300' : ''}`}
                        >
                          <option value="">Select your country</option>
                          {countries.map((c) => <option key={c}>{c}</option>)}
                        </select>
                        {errors.country && <p id="contact-country-error" className="text-red-500 text-xs mt-1">{errors.country}</p>}
                      </div>

                      {/* How did you find us */}
                      <div>
                        <label htmlFor="contact-found" className="block text-sm font-semibold text-gray-700 mb-1.5">
                          How did you find us? <span className="text-red-400">*</span>
                        </label>
                        <select
                          id="contact-found"
                          value={form.howFound} onChange={set('howFound')}
                          aria-invalid={Boolean(errors.howFound)}
                          aria-describedby={errors.howFound ? 'contact-found-error' : undefined}
                          className={`input-base appearance-none cursor-pointer ${errors.howFound ? 'border-red-300' : ''}`}
                        >
                          <option value="">Select an option</option>
                          {howFoundOptions.map((o) => <option key={o}>{o}</option>)}
                        </select>
                        {errors.howFound && <p id="contact-found-error" className="text-red-500 text-xs mt-1">{errors.howFound}</p>}
                      </div>

                      {/* Subject */}
                      <div>
                        <label htmlFor="contact-subject" className="block text-sm font-semibold text-gray-700 mb-1.5">
                          Subject <span className="text-red-400">*</span>
                        </label>
                        <select
                          id="contact-subject"
                          value={form.subject} onChange={set('subject')}
                          aria-invalid={Boolean(errors.subject)}
                          aria-describedby={errors.subject ? 'contact-subject-error' : undefined}
                          className={`input-base appearance-none cursor-pointer ${errors.subject ? 'border-red-300' : ''}`}
                        >
                          <option value="">Select a subject</option>
                          {subjectOptions.map((o) => <option key={o}>{o}</option>)}
                        </select>
                        {errors.subject && <p id="contact-subject-error" className="text-red-500 text-xs mt-1">{errors.subject}</p>}
                      </div>

                      {/* Message */}
                      <div>
                        <label htmlFor="contact-message" className="block text-sm font-semibold text-gray-700 mb-1.5">
                          Message <span className="text-red-400">*</span>
                        </label>
                        <textarea
                          id="contact-message"
                          rows={5} placeholder="Tell us what's on your mind..."
                          value={form.message} onChange={set('message')}
                          maxLength={2000}
                          aria-invalid={Boolean(errors.message)}
                          aria-describedby={errors.message ? 'contact-message-error' : 'contact-message-help'}
                          className={`input-base resize-none ${errors.message ? 'border-red-300' : ''}`}
                        />
                        <p id="contact-message-help" className="mt-1 text-xs text-gray-400">Minimum 20 characters. Maximum 2000 characters.</p>
                        {errors.message && <p id="contact-message-error" className="text-red-500 text-xs mt-1">{errors.message}</p>}
                      </div>

                      {/* Submit */}
                      <button
                        type="submit"
                        className="w-full btn-primary py-4 text-base rounded-xl hover:-translate-y-0.5 hover:shadow-lg hover:shadow-teal-200/60 transition-all"
                      >
                        Send Message <Send size={16} />
                      </button>
                    </form>
                  </motion.div>
                )}
              </AnimatePresence>
            </FadeIn>
          </div>

          <FadeIn delay={0.3}>
            <div
              className="relative mt-10 overflow-hidden rounded-[2rem] px-4 py-7 shadow-[0_28px_70px_rgba(15,23,42,0.18)] md:px-6 md:py-8"
              style={{ background: 'linear-gradient(135deg,#0f2744 0%,#0f766e 60%,#0d9488 100%)' }}
            >
              <div
                className="absolute inset-0 opacity-[0.04]"
                style={{
                  backgroundImage: 'radial-gradient(circle at 1px 1px,rgba(255,255,255,0.6) 1px,transparent 0)',
                  backgroundSize: '28px 28px',
                }}
              />
              <div className="relative z-10 mx-auto max-w-6xl">
                <div className="grid gap-5 lg:grid-cols-[1.3fr_0.9fr] lg:items-center">
                  <div className="text-center lg:text-left">
                    <div className="mx-auto mb-5 flex h-12 w-12 items-center justify-center rounded-2xl border border-teal-400/30 bg-teal-500/40 lg:mx-0">
                      <Newspaper size={22} className="text-teal-200" />
                    </div>
                    <h2 className="text-3xl font-bold text-white md:text-4xl">Media and Press Release Enquiry</h2>
                    <p className="mt-3 max-w-2xl text-base leading-7 text-teal-200/80 md:text-lg">
                      For interviews, podcast appearances, review copies, press statements, and publication-related coverage, use the contact form and select <span className="font-semibold text-white">Press / Media</span> as the subject.
                    </p>
                    <div className="mt-5 flex flex-wrap justify-center gap-3 lg:justify-start">
                      <div className="inline-flex items-center gap-2 rounded-2xl border border-white/15 bg-white/10 px-4 py-2.5 text-sm font-medium text-white backdrop-blur-sm">
                        <Mic size={16} className="text-teal-200" />
                        Interviews and appearances
                      </div>
                      <div className="inline-flex items-center gap-2 rounded-2xl border border-white/15 bg-white/10 px-4 py-2.5 text-sm font-medium text-white backdrop-blur-sm">
                        <Newspaper size={16} className="text-teal-200" />
                        Press releases and media kits
                      </div>
                    </div>
                  </div>

                  <div className="rounded-[1.75rem] border border-white/15 bg-white/10 p-5 text-left backdrop-blur-sm">
                    <p className="text-xs font-semibold uppercase tracking-[0.22em] text-teal-200/80">Best way to reach us</p>
                    <p className="mt-2.5 text-sm leading-6 text-teal-100/90">
                      Include your publication or platform name, deadline, preferred interview format, and any specific request details so we can respond quickly.
                    </p>
                    <div className="mt-4">
                      <label className="mb-1.5 block text-xs font-semibold uppercase tracking-[0.22em] text-teal-200/80">
                        Your Email
                      </label>
                      <div className="flex flex-col gap-3 sm:flex-row">
                        <input
                          type="email"
                          placeholder="Enter your email address"
                          value={mediaEmail}
                          onChange={(e) => setMediaEmail(e.target.value)}
                          onKeyDown={(e) => e.key === 'Enter' && handleMediaEmailSend()}
                          autoComplete="email"
                          inputMode="email"
                          aria-invalid={Boolean(mediaEmailError)}
                          aria-describedby={mediaEmailError ? 'media-email-error' : undefined}
                          className={`flex-1 rounded-xl border bg-white/10 px-4 py-3 text-sm text-white placeholder:text-white/50 focus:outline-none focus:ring-2 focus:ring-teal-300 ${
                            mediaEmailError ? 'border-red-300/80' : 'border-white/15'
                          }`}
                        />
                        <button
                          type="button"
                          onClick={handleMediaEmailSend}
                          className="inline-flex items-center justify-center gap-2 rounded-xl bg-teal-500 px-5 py-3 text-sm font-semibold text-white transition-all duration-200 hover:-translate-y-0.5 hover:bg-teal-400"
                        >
                          Send <Send size={16} />
                        </button>
                      </div>
                      {mediaEmailError && <p id="media-email-error" className="mt-2 text-xs text-red-200">{mediaEmailError}</p>}
                    </div>
                    <div className="mt-4 rounded-2xl border border-white/10 bg-white/10 px-4 py-3">
                      <p className="text-xs font-semibold uppercase tracking-[0.22em] text-teal-200/80">Recommended Subject</p>
                      <p className="mt-1.5 text-base font-semibold text-white">Press / Media</p>
                    </div>
                    <button
                      type="button"
                      onClick={() => window.scrollTo({ top: 0, behavior: 'smooth' })}
                      className="mt-4 inline-flex items-center gap-2 text-sm font-semibold text-white/90 transition-colors duration-200 hover:text-white"
                    >
                      Or use the contact form <ArrowRight size={16} />
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </FadeIn>
        </div>
      </section>

      <Footer onNavigate={onNavigate} />
    </>
  )
}
