import cors from 'cors'
import express from 'express'
import helmet from 'helmet'
import morgan from 'morgan'
import { env, isProd } from './config/env.js'
import { errorHandler, notFound } from './middleware/errorHandler.js'
import { healthRouter } from './routes/health.routes.js'

export function createApp(){
    const app = express()

    app.disable('x-powered-by')
    app.use(helmet())
    app.use(cors({origin : env.CLIENT_ORIGIN , credentials : true}))
    app.use(express.json({limit : '10kb'}))
    if(!isProd)
    {
        app.use(morgan('dev'))
    }

    app.use('/api/v1/health',healthRouter)


    app.use(notFound)
    app.use(errorHandler)

    return app
}