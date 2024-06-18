import http from '@/api'
import { _API } from '@/api/axios/servicePort'
import { Book, ResPage, BookResource } from '@/api/interface/index'

/**
 * @name 图书管理模块
 */
export const BookApi = {
  page: (params: Book.BookQuery) => http.post<ResPage<Book.BookVO>>(_API + '/book/page', params),
  add: (params: any) => http.post(_API + '/book/save', params),
  remove: (params: number[]) => http.post(_API + '/book/delete', params),
  edit: (params: any) => http.post(_API + '/book/update', params)
}

export const BookResourceApi = {
  page: (params: BookResource.BookResourceQuery) => http.post<ResPage<BookResource.BookResourceBO>>(_API + '/book/resource/page', params),
  add: (params: any) => http.post(_API + '/book/resource/save', params),
  remove: (params: number[]) => http.post(_API + '/book/resource/delete', params),
  edit: (params: any) => http.post(_API + '/book/resource/update', params),
  download: (bookId: number) =>
    http.post(
      _API + `/book/resource/download?bookId=${bookId}`,
      {},
      {
        responseType: 'blob'
      }
    )
}
