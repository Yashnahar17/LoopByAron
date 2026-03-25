import { BookOpen, Mail } from 'lucide-react'

const quickLinks   = [{ label: 'Home', page: 'home' }, { label: 'About Author', page: 'about' }, { label: 'Contact Us', page: 'contact' }]
const trilogyLinks = [{ label: 'Part I: The Loop', page: 'part-one' }, { label: 'Part II: Within The Loop', page: 'part-two' }, { label: 'Part III: Beyond The Loop', page: 'part-three' }]
const socials      = [{ Icon: Mail, label: 'Email' }]

export default function Footer({ onNavigate }) {
  const go = (page) => { onNavigate(page); window.scrollTo({ top: 0, behavior: 'smooth' }) }
  return (
    <footer className="bg-gray-900 text-gray-400">
      <div className="w-full max-w-[98rem] mx-auto px-4 sm:px-5 lg:px-6 pt-16 pb-8">
        <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-10 mb-12">
          <div>
            <button onClick={() => go('home')} className="flex items-center gap-2 mb-4 group">
              <BookOpen size={20} className="text-teal-500" />
              <span className="font-bold text-white text-base group-hover:text-teal-400 transition-colors">The Loop Trilogy</span>
            </button>
            <p className="text-sm leading-relaxed">The untold reality behind fictional characters</p>
          </div>
          <div>
            <h4 className="font-semibold text-teal-500 text-sm tracking-wider uppercase mb-5">Quick Links</h4>
            <ul className="space-y-3">{quickLinks.map(({ label, page }) => (
              <li key={label}><button onClick={() => go(page)} className="text-sm text-gray-400 hover:text-white transition-colors text-left">{label}</button></li>
            ))}</ul>
          </div>
          <div>
            <h4 className="font-semibold text-teal-500 text-sm tracking-wider uppercase mb-5">The Trilogy</h4>
            <ul className="space-y-3">{trilogyLinks.map(({ label, page }) => (
              <li key={label}><button onClick={() => go(page)} className="text-sm text-gray-400 hover:text-white transition-colors text-left">{label}</button></li>
            ))}</ul>
          </div>
          <div>
            <h4 className="font-semibold text-teal-500 text-sm tracking-wider uppercase mb-5">Connect</h4>
            <div className="flex gap-3">{socials.map(({ Icon, label }) => (
              <button key={label} aria-label={label} className="w-10 h-10 rounded-xl bg-gray-800 hover:bg-teal-600 flex items-center justify-center text-gray-400 hover:text-white transition-all duration-200 hover:scale-110">
                <Icon size={16} />
              </button>
            ))}</div>
          </div>
        </div>
        <div className="border-t border-gray-800 pt-6 flex flex-col sm:flex-row items-center justify-between gap-4">
          <p className="text-xs text-gray-600">© 2026 The Loop Trilogy. All rights reserved.</p>
          <div className="flex gap-6">
            <button onClick={() => go('privacy')} className="text-xs text-gray-600 hover:text-gray-400 transition-colors">Privacy Policy</button>
            <button onClick={() => go('terms')} className="text-xs text-gray-600 hover:text-gray-400 transition-colors">Terms of Service</button>
          </div>
        </div>
      </div>
    </footer>
  )
}
