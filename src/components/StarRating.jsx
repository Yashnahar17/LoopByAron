import { useState } from 'react'
import { Star } from 'lucide-react'

export default function StarRating({ value = 0, onChange, readOnly = false, size = 20 }) {
  const [hovered, setHovered] = useState(0)
  const display = hovered || value
  return (
    <div className="flex gap-1" role={readOnly ? 'img' : 'radiogroup'} aria-label={`Rating: ${value} out of 5`}>
      {[1, 2, 3, 4, 5].map((s) => (
        <button
          key={s} type="button" disabled={readOnly}
          onClick={() => !readOnly && onChange?.(s)}
          onMouseEnter={() => !readOnly && setHovered(s)}
          onMouseLeave={() => !readOnly && setHovered(0)}
          aria-label={`${s} star${s > 1 ? 's' : ''}`}
          aria-checked={s === value}
          role={readOnly ? undefined : 'radio'}
          className={`transition-transform duration-100 ${!readOnly ? 'hover:scale-110 cursor-pointer' : 'cursor-default'}`}
        >
          <Star size={size} className={s <= display ? 'text-yellow-400 fill-yellow-400' : 'text-gray-300 fill-gray-100'} />
        </button>
      ))}
    </div>
  )
}
