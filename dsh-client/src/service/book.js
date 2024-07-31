import { http } from '@/utils/https.js'

const BOOK_API = '/book'

export const exchange = (exchangeDTO) => {
  return http({
    method: 'POST',
    url: BOOK_API + '/exchange',
    data: exchangeDTO
  })
}
