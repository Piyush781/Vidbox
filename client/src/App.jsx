import { useEffect, useState } from 'react'

function App() {
  const [status,setstatus] = useState('Loading...')

  useEffect(()=>{
     fetch('/api/v1/health')
     .then((res) => res.json())
     .then((body) => setstatus(`${body.data.status}, database ${body.data.database}`))
     .catch(() => setstatus('server not reachable'))
  },[])

  return (
    <div className="min-h-screen bg-slate-950 text-white grid place-items-center">
      <h1 className="text-5xl font-extrabold tracking-tight text-amber-400">VidBox</h1>
      <p className="mt-4 text-slate-300">API status: {status}</p>
    </div>
  )
}

export default App
