import { Award, Calendar, TrendingUp } from 'lucide-react'
import { motion } from 'framer-motion'
import FadeIn from './FadeIn'

const iconMap = { Award, Calendar, TrendingUp }

function StatCard({ icon, value, label, featured, index }) {
  const Icon = iconMap[icon] || Award
  return (
    <motion.div
      initial={{ opacity: 0, y: 24 }} whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, margin: '-40px' }}
      transition={{ duration: 0.55, delay: index * 0.12 }}
      whileHover={{ y: -2, transition: { duration: 0.2 } }}
      className={`p-8 rounded-2xl border transition-shadow duration-300 ${featured
        ? 'bg-white border-teal-100 shadow-xl shadow-teal-100/60 z-10 scale-[1.03]'
        : 'bg-white border-gray-100 shadow-sm hover:shadow-md'}`}
    >
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
    <section className="section-space bg-white">
      <div className="section-shell-wide">
        <FadeIn className="text-center mb-14">
          <h2 className="section-title">{title}</h2>
          {subtitle && <p className="section-sub">{subtitle}</p>}
        </FadeIn>
        <div className="grid md:grid-cols-3 gap-6 items-center">
          {stats.map((s, i) => <StatCard key={s.label} {...s} index={i} />)}
        </div>
      </div>
    </section>
  )
}
