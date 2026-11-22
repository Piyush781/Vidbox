import { Router } from 'express'
import { prisma } from '../lib/prisma.js'

export const healthRouter = Router()

healthRouter.get('/', async (req, res) => {
    try {
        await prisma.$queryRaw`SELECT 1`

        return res.status(200).json({
            data: {
                status: 'ok',
                database: 'connected',
                uptimeSeconds: Math.round(process.uptime())
            }
        })

    } catch (error) {
        console.error('Health check failed:', error)

        return res.status(503).json({
            data: {
                status: 'degraded',
                database: 'down'
            }
        })
    }
})