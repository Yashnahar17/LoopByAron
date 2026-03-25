import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'

export default function ImageCarousel({ images = [] }) {
  const [current, setCurrent] = useState(0)
  if (!images.length) return null
  return (
    <div className="rounded-2xl overflow-hidden shadow-xl bg-gray-100">
      <div className="relative overflow-hidden" style={{ aspectRatio: '4/3' }}>
        <AnimatePresence mode="wait">
          <motion.img
            key={current} src={images[current]} alt={`Book artwork slide ${current + 1}`}
            loading={current === 0 ? 'eager' : 'lazy'}
            decoding="async"
            initial={{ opacity: 0, x: 30 }} animate={{ opacity: 1, x: 0 }} exit={{ opacity: 0, x: -30 }}
            transition={{ duration: 0.4, ease: 'easeInOut' }}
            className="w-full h-full object-cover"
          />
        </AnimatePresence>
      </div>
      <div className="flex items-center gap-2 px-4 py-3 bg-white">
        {images.map((_, i) => (
          <button
            key={i} onClick={() => setCurrent(i)} aria-label={`Slide ${i + 1}`}
            aria-pressed={i === current}
            className={`transition-all duration-300 rounded-full ${i === current ? 'w-6 h-2.5 bg-teal-600' : 'w-2.5 h-2.5 bg-gray-300 hover:bg-gray-400'}`}
          />
        ))}
      </div>
    </div>
  )
}
