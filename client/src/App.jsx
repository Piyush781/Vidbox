import { useState } from 'react'

function App() {
  const [count, setCount] = useState(0)

  return (
    <div className="min-h-screen bg-slate-950 text-white grid place-items-center">
      <h1 className="text-5xl font-extrabold tracking-tight text-amber-400">VidBox</h1>
    </div>
  )
}

export default App
