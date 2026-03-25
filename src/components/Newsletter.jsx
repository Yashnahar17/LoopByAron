import { useState } from 'react'
import { Send, Mail, CheckCircle } from 'lucide-react'
import FadeIn from './FadeIn'

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/i

export default function Newsletter({ variant = 'full' }) {
  const [email, setEmail] = useState('')
  const [done, setDone]   = useState(false)
  const [error, setError] = useState('')

  const handle = (event) => {
    event?.preventDefault()
    const normalizedEmail = email.trim().toLowerCase()
    if (!EMAIL_RE.test(normalizedEmail)) {
      setError('Enter a valid email address.')
      return
    }
    setError('')
    setEmail(normalizedEmail)
    setDone(true)
  }

  if (variant === 'card') return (
    <section className="py-12 md:py-16">
      <div className="section-shell-wide">
        <FadeIn>
          <div className="rounded-[2rem] p-8 md:p-10 text-center" style={{ background: 'linear-gradient(135deg,#0f766e 0%,#0d9488 100%)' }}>
            <div className="w-12 h-12 rounded-full bg-white/20 flex items-center justify-center mx-auto mb-5">
              <Mail size={22} className="text-white" />
            </div>
            <h3 className="text-2xl font-bold text-white mb-2">Stay Updated</h3>
            <p className="text-teal-100/80 text-sm mb-6">Subscribe to receive exclusive updates, excerpts, and release announcements.</p>
            {done ? (
              <div className="flex items-center justify-center gap-2 text-white font-medium"><CheckCircle size={18} /> Subscribed!</div>
            ) : (
              <form className="max-w-md mx-auto" onSubmit={handle} noValidate>
                <div className="flex flex-col sm:flex-row gap-3">
                <input type="email" placeholder="Enter your email" value={email} onChange={(e) => setEmail(e.target.value)} onKeyDown={(e) => e.key === 'Enter' && handle()}
                  autoComplete="email"
                  aria-invalid={Boolean(error)}
                  aria-describedby={error ? 'newsletter-card-error' : undefined}
                  className="flex-1 px-4 py-3 rounded-xl bg-white/15 border border-white/30 text-white placeholder-white/60 focus:outline-none focus:ring-2 focus:ring-white/50 text-sm" />
                <button type="submit" className="inline-flex items-center justify-center gap-2 bg-white text-teal-700 font-semibold px-5 py-3 rounded-xl text-sm hover:bg-teal-50 transition-all">
                  Subscribe <Send size={14} />
                </button>
                </div>
                {error && <p id="newsletter-card-error" className="mt-2 text-left text-xs text-red-100">{error}</p>}
              </form>
            )}
          </div>
        </FadeIn>
      </div>
    </section>
  )

  return (
    <section className="relative section-space overflow-hidden" style={{ background: 'linear-gradient(135deg,#0f2744 0%,#0f766e 60%,#0d9488 100%)' }}>
      <div className="absolute inset-0 opacity-[0.04]" style={{ backgroundImage: 'radial-gradient(circle at 1px 1px,rgba(255,255,255,0.6) 1px,transparent 0)', backgroundSize: '28px 28px' }} />
      <div className="section-shell-wide relative z-10 text-center">
        <FadeIn>
          <div className="max-w-2xl mx-auto">
            <div className="w-14 h-14 rounded-2xl bg-teal-500/40 border border-teal-400/30 flex items-center justify-center mx-auto mb-8">
            <Mail size={24} className="text-teal-200" />
            </div>
            <h2 className="text-4xl md:text-5xl font-bold text-white mb-4">Join Our Reader Community</h2>
            <p className="text-teal-200/80 text-lg mb-10">Be the first to know about new releases, exclusive content, and special offers.</p>
            {done ? (
              <div className="flex items-center justify-center gap-2 text-white text-lg font-medium">
                <CheckCircle size={24} className="text-teal-300" /> You're subscribed!
              </div>
            ) : (
              <form className="max-w-md mx-auto" onSubmit={handle} noValidate>
                <div className="flex flex-col sm:flex-row gap-3">
                <input type="email" placeholder="Enter your email address" value={email} onChange={(e) => setEmail(e.target.value)} onKeyDown={(e) => e.key === 'Enter' && handle()}
                  autoComplete="email"
                  aria-invalid={Boolean(error)}
                  aria-describedby={error ? 'newsletter-error' : undefined}
                  className="flex-1 px-5 py-3.5 rounded-xl bg-white/10 border border-white/25 text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-teal-400 text-sm" />
                <button type="submit" className="inline-flex items-center justify-center gap-2 bg-teal-500 hover:bg-teal-400 text-white font-semibold px-6 py-3.5 rounded-xl text-sm whitespace-nowrap transition-all">
                  Subscribe <Send size={14} />
                </button>
                </div>
                {error && <p id="newsletter-error" className="mt-2 text-left text-xs text-red-100">{error}</p>}
              </form>
            )}
            <p className="text-teal-300/60 text-xs mt-4">We respect your privacy. Unsubscribe at any time.</p>
          </div>
        </FadeIn>
      </div>
    </section>
  )
}
