import 'dotenv/config'
import {z} from 'zod'


const schema = z.object({
    NODE_ENV : z.enum(['development','test','production']).default('development'),
    PORT : z.coerce.number().int().positive().default(4000),
    CLIENT_ORIGIN : z.string().min(1).default('http://localhost:5173'),
    DATABASE_URL : z.string().min(1,'DATABASE_URL is required')
})

const result = schema.safeParse(process.env)

if(!result.success)
{
    console.error('Invalid environment settings:')
    console.error(z.prettifyError(result.error))
    process.exit(1)
}

export const env = result.data

export const isProd = env.NODE_ENV === 'production'